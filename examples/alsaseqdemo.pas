(* Lazarus+FPC 2.2.6+3.2.2 on Linux Lazarus+FPC 2.2.6+3.2.2 on Linux Lazarus+FP *)

unit AlsaSeqDemo;

(* Demo beep for Linux using ALSA, with a simple MIDI sequence being passed to  *)
(* either a statically- or dynamically-loaded library.          MarkMLl         *)

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

(* A short MIDI phrase, set to a default if not specified.
*)
function BeepSeq(const tune: string= 'c050 !127 +660 A6'): boolean;

(* Is the underlying ALSA library linked statically or dynamically?
*)
function IsDynamic(): boolean;


implementation

uses
  Forms, WatchXyzMidi;

var
  hasInitialisedMidi: boolean= false;
  MidiWriterThread: TMidiWriterThread= nil;


(* A short MIDI phrase, set to a default if not specified.
*)
function BeepSeq(const tune: string= 'c050 !127 +660 A6'): boolean;

begin
  if not hasInitialisedMidi then begin
    MidiWriterThread := TMidiWriterThread.Create(false, 'BeepDemo');
    Application.ProcessMessages;

(* Hack here: because the code I've repurposed prompts the user for the MIDI    *)
(* device asynchronously, we'll fall out of this procedure before it's known.   *)
(* As a result, I've hardcoded the default tune in the thread's main loop and   *)
(* hope the user doesn't notice.                                                *)

    hasInitialisedMidi := true
  end;
  if Assigned(MidiWriterThread) then
    MidiWriterThread.Enqueue(tune)
end { BeepSeq } ;


(* Is the underlying ALSA library linked statically or dynamically?
*)
function IsDynamic(): boolean;

begin
  result := WatchXyzMidi.IsDynamic
end { IsDynamic } ;


end.

