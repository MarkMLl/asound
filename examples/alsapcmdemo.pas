unit AlsaPcmDemo;

(* Demo beep for Linux using ALSA, with a simple signal-generation function     *)
(* passing control to either a statically- or dynamically-loaded library. See   *)
(* https://forum.lazarus.freepascal.org/index.php/topic,49502.msg359352.html    *)
(*                                                              MarkMLl         *)

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

(* Beep under DOS on an IBM PS/2-77 is 900Hz 660mS but I've "rounded" this here
  to a standard note (octave above standard A).
*)
function BeepPcm(freqHz: integer= 880; mSec: integer= 660): boolean;

(* Is the underlying ALSA library linked statically or dynamically?
*)

function IsDynamic(): boolean;


implementation

{$define DYNAMIC }

uses
{$ifdef LCL }
  Forms,
{$endif LCL }
{$ifdef DYNAMIC }
  AsoundPcm_dynamic;                    (* AsoundPcm (hence Asound) is an object *)
{$else }
uses
  AsoundPcm;                            (* AsoundPcm (hence Asound) is a unit   *)
{$endif DYNAMIC }

var
  SA: array[0..359] of byte;            // One cycle of precomputed sine wave
  mainThreadID: TThreadID;


(* Beep under DOS on an IBM PS/2-77 is 900Hz 660mS but I've "rounded" this here
  to a standard note (octave above standard A).
*)
function BeepPcm(freqHz: integer= 880; mSec: integer= 660): boolean;

const
  bps= 48000;                           (* Don't change this                    *)
  fraction= 20;                         (* 1/20th sec precomputed               *)
  top= (bps div fraction) - 1;          (* e.g. 2399 for 1/20th sec @48000 bps  *)

var
  pcmBuffer: array[0..top] of byte;
  frames: snd_pcm_sframes_t;
  pcm: PPsnd_pcm_t;
  I, LC: integer;
  SS, R: real;

const
  device= 'default' + #0;

begin
  Assert(bps mod fraction = 0, 'Internal error: bps/fraction not an integer');
  result := AsoundPcm.ModuleInMemory;

(* Establish some minimum settings and calculate the step size as determined by *)
(* the freqHz parameter.                                                        *)

  if freqHz < 20 then                   (* 1x cycle in 1/20th of a second       *)
    freqHz := 20;
  if mSec < 1000 div fraction then      (* 1/20th of a second                   *)
    mSec := 1000 div fraction;
  SS := (sizeof(SA) / sizeof(pcmBuffer)) * (freqHz / fraction);
  R := 0.0;

  if result and (AsoundPcm.snd_pcm_open(@pcm, @device[1], SND_PCM_STREAM_PLAYBACK, 0) = 0) then
    try
      if result and (AsoundPcm.snd_pcm_set_params(pcm, SND_PCM_FORMAT_U8,
                                SND_PCM_ACCESS_RW_INTERLEAVED,
                                1,
                                bps,    // Normally 48000
                                1,
                                100000  // Lower numeric latency needs faster system
                                ) = 0) then

(* Iterate the precomputed array into the output buffer, the number of times    *)
(* being determined by the mSec parameter.                                      *)

        for LC := 1 to (mSec * fraction) div 1000 do begin
          begin

(* Transfer the precomputed array into the output buffer once.                  *)

            for I := 0 to sizeof(pcmBuffer) - 1 do
              begin
                pcmBuffer[I] := SA[trunc(R)];
                R := R + SS;
                if R >= 360.0 then
                  R := R - 360.0
              end;

(* Output the buffer, retrying/recovering as necessary. If this is irregular or *)
(* results in error messages, try increasing the value in the latency parameter *)
(* to snd_pcm_set_params() above.                                               *)

            frames := AsoundPcm.snd_pcm_writei(pcm, @pcmBuffer, sizeof(pcmBuffer));
            if frames < 0 then
              frames := AsoundPcm.snd_pcm_recover(pcm, frames, 0);
            if frames < 0 then begin
              WriteLn(AsoundPcm.snd_strerror(frames));
              break
            end
          end;

(* Assuming that the outer loop runs 20 times a second, if this is a GUI (as    *)
(* distinct from console) application and we are running in the context of the  *)
(* main thread then give the GUI a chance to handle any user interaction 10     *)
(* times a second.                                                              *)

{$ifdef LCL }
          if Odd(LC) and (GetCurrentThreadID() = mainThreadID) then
            Application.ProcessMessages
{$endif LCL }
        end
      else // snd_pcm_set_params() failed
        result := false
    finally
      AsoundPcm.snd_pcm_drain(pcm);
      AsoundPcm.snd_pcm_close(pcm)
    end
  else // snd_pcm_open() failed
    result := false
end { BeepPcm } ;


(* Is the underlying ALSA library linked statically or dynamically?
*)

function IsDynamic(): boolean;

begin
  result := AsoundPcm.IsDynamic
end { IsDynamic } ;


(* Initialise the array that contains a single cycle of the output waveform. I
  find a sine wave a bit blunt, so add some harmonics to move it a bit closer to
  a square wave (but not all the way, computation of which would be trivial)
  which has a bit more edge to it.

  The return value is the maximum amplitude, the volume parameter should be
  chosen- if necessarily iteratively- to keep this slightly less than 255 lest
  changing target causes an overflow.
*)
function initAlsaPcm(volume: double= 134.5): integer;

const
  first= 1.0;
  third= first / 3;
  fifth= first / 5;

var
  I: integer;

begin
  result := 0;
  for I := 0 to 179 do begin
    SA[I] := 128 + round(first * sin(1 * pi * I / 180.0) * volume) +
             128 + round(third * sin(3 * pi * I / 180.0) * volume) +
             128 + round(fifth * sin(5 * pi * I / 180.0) * volume);
    SA[I + 180] := 255 - SA[I];
    if SA[I] > result then
      result := SA[I]
  end
end { initAlsaPcm } ;                   // Breakpoint here to check max amplitude


initialization
  initAlsaPcm();
  mainThreadID := GetCurrentThreadID
end.

