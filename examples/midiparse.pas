(* Lazarus+FPC 2.2.6+3.2.2 on Linux Lazarus+FPC 2.2.6+3.2.2 on Linux Lazarus+FP *)

unit MidiParse;

(* Parser for the text representation of MIDI events used by Dialarm compatible *)
(* with the original implementation in UtilXyz.                 MarkMLl         *)

// Examples:
//
// First three phrases from "Fanfare for the Common Man"
//
// !127 c009 +200 G5C6 +1000 G
// !127 c009 +200 C6G +1000 F
// !127 c009 +400 A6FC +1000 G5
//
// Whittington chimes
//
// c00e !127 +250 C6 A5FD !112 B !80 GE +500 C
//
// In the cases above, c0xx selects an instrument, ! prefixes a velocity (i.e.
// volume) expressed as decimal digits, and + prefixes a duration expressed as
// mSec. Notes are capitalised and may have a trailing # (sharp) and/or octave
// number (C5 is middle C), _ is a rest.
//
// Gong (quality highly variable depending on sound card)
//
// c00e b00760 c159 b1077f 90227f 91227f +250 b10740 +500 b10720 +1000 b10710 +2000 b10708 +500 802200 812200

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, AlsaSeqDemo, WatchXyzMidi;

(* Parse a note, hint, or raw MIDI command expressed as hex from the front of
  the string and delete it. Emit an ALSA-format event set to SND_SEQ_EVENT_NONE
  if it is to be ignored, return false if a syntax error is encountered which
  includes the string being empty which would normally indicate completion.

  MIGHT handle sysex messages of up to three bytes, but DEFINITELY NOT longer.
*)
function ParseMidiToEvent(var txt: string; var ev: snd_seq_event_t_): boolean;

(* Initialise the parser. This is not mandatory but makes sure that persistent
  octave etc. are reset to the default values.
*)
procedure InitMidiParser;


implementation

uses StrUtils, UnixType;

var
  lastExplicitDuration: integer= 500;
  lastExplicitOctave: integer= 5;
  lastExplicitVelocity: integer= 64;


(* Parse a note, hint, or raw MIDI command expressed as hex from the front of
  the string and delete it. Emit an ALSA-format event set to SND_SEQ_EVENT_NONE
  if it is to be ignored, return false if a syntax error is encountered which
  includes the string being empty which would normally indicate completion.

  MIGHT handle sysex messages of up to three bytes, but DEFINITELY NOT longer.
*)
function ParseMidiToEvent(var txt: string; var ev: snd_seq_event_t_): boolean;


  (* Parse up to six hex digits, and convert them into an event with reference to
    the code in aplaymidi.
  *)
  function parseHexEvent(): boolean;

  var
    hexStr: string= '';
    hexInt: dword;

  begin
    result := true;
    while (txt <> '') and (txt[1] in ['0'..'9', 'a'..'f']) do begin
      hexStr += txt[1];
      Delete(txt, 1, 1)
    end;
    if (hexStr = '') or (Length(hexStr) > 6) or Odd(Length(hexStr)) then
      exit(false);
    while Length(hexStr) < 6 do         (* Final byte might be a dummy          *)
      hexStr += '00';
    hexInt := Hex2Dec(hexStr);

(* That must have parsed six digits into 24 bits. Extract the type but hold off *)
(* decoding the data since some of it is common to multiple types.              *)

    case hexInt shr 20 of
      $8: ev.type_ := byte(SND_SEQ_EVENT_NOTEOFF_);
      $9: ev.type_ := byte(SND_SEQ_EVENT_NOTEON_);
      $a: ev.type_ := byte(SND_SEQ_EVENT_KEYPRESS_);
      $b: ev.type_ := byte(SND_SEQ_EVENT_CONTROLLER_);
      $c: ev.type_ := byte(SND_SEQ_EVENT_PGMCHANGE_);
      $d: ev.type_ := byte(SND_SEQ_EVENT_CHANPRESS_);
      $e: ev.type_ := byte(SND_SEQ_EVENT_PITCHBEND_);
      $f: ev.type_ := byte(SND_SEQ_EVENT_SYSEX_)
    otherwise
      exit(false)
    end;

(* Now decode the data. It's a pain that this has to be donefor ALSA            *)
(* compatibility since it will revert to precisely the original form in order   *)
(* to be sent to the physical synthesiser.                                      *)

    case ev.type_ of
      byte(SND_SEQ_EVENT_NOTEOFF_),
      byte(SND_SEQ_EVENT_NOTEON_),
      byte(SND_SEQ_EVENT_KEYPRESS_):   begin
                                        ev.data.note.channel := (hexInt shr 16) and $0f;
                                        ev.data.note.note := (hexInt shr 8) and $7f;
                                        ev.data.note.velocity := hexInt and $7f
                                      end;
      byte(SND_SEQ_EVENT_CONTROLLER_): begin
                                        ev.data.control.channel := (hexInt shr 16) and $0f;
                                        ev.data.control.param := (hexInt shr 8) and $7f;
                                        ev.data.control.value := hexInt and $7f
                                      end;
      byte(SND_SEQ_EVENT_PGMCHANGE_),
      byte(SND_SEQ_EVENT_CHANPRESS_):  begin
                                        ev.data.control.channel := (hexInt shr 16) and $0f;
                                        ev.data.control.value := (hexInt shr 8) and $7f
                                      end;
      byte(SND_SEQ_EVENT_PITCHBEND_):  begin
                                        ev.data.control.channel := (hexInt shr 16) and $0f;
                                        ev.data.control.value := ((hexInt shr 8) and $7f +
                                                        (hexInt and $7f) shl 7) - $2000
                                      end;

(* Sysex messages are not currently supported since they are usually longer     *)
(* than the three bytes being decoded here.                                     *)
// TODO : MIDI sysex messages
      byte(SND_SEQ_EVENT_SYSEX_):      begin
                                        exit(false)
                                      end
    otherwise
      exit(false)
    end
  end { parseHexEvent } ;


  (* A valid note is a capital letter in the range A-G optionally followed by # *)
  (* and/or a digit representing an octave, the octave number is persistent.    *)

  function parseNoteEvent(): boolean;

  var
    noteCode: integer= -1000;
    isSharp: integer= 0;

  begin
    while (txt <> '') and (txt[1] <> ' ') do begin
      if (noteCode <> -1000) and (txt[1] in ['A'..'G', '_']) then
        break;
      case txt[1] of
        'C':      noteCode := 0;
        'D':      noteCode := 2;
        'E':      noteCode := 4;
        'F':      noteCode := 5;
        'G':      noteCode := 7;
        'A':      noteCode := 9;
        'B':      noteCode := 11;
        '_':      noteCode := -999;
        '#':      isSharp += 1;
        '0'..'9': lastExplicitOctave := Ord(txt[1]) - Ord('0')
      otherwise
        exit(false)
      end;
      Delete(txt, 1, 1)
    end;
    ev.type_ := byte(SND_SEQ_EVENT_NOTE_);
    ev.data.note.channel := 0;
    if noteCode >=  0 then begin
      ev.data.note.note := noteCode + (12 * lastExplicitOctave) + isSharp;
      ev.data.note.velocity := lastExplicitVelocity
    end else begin
      ev.data.note.note := 60;
      ev.data.note.velocity := 0
    end;
    ev.data.note.off_velocity := 127;
    ev.data.note.duration := lastExplicitDuration; // TODO : Unsure about duration scaling
    result := true
  end { parseNoteEvent } ;


  (* Parse a timing Duration in mSec.
  *)
  function parseDuration(): boolean;

  var
    decStr: string= '';

  begin
    if (txt = '') or (txt[1] <> '+') then
      exit(false);
    Delete(txt, 1, 1);
    while (txt <> '') and (txt[1] in ['0'..'9']) do begin
      decStr += txt[1];
      Delete(txt, 1, 1)
    end;
    lastExplicitDuration := StrToIntDef(decStr, 0);
    ev.type_ := byte(SND_SEQ_EVENT_NONE_);      (* Do not generate MIDI output  *)
    result := true
  end { parseDuration } ;


  (* parse a note velocity mod 128.
  *)
  function parseVelocity(): boolean;

  var
    decStr: string= '';

  begin
    if (txt = '') or (txt[1] <> '!') then
      exit(false);
    Delete(txt, 1, 1);
    while (txt <> '') and (txt[1] in ['0'..'9']) do begin
      decStr += txt[1];
      Delete(txt, 1, 1)
    end;
    lastExplicitVelocity := StrToIntDef(decStr, 0) mod 128;
    ev.type_ := byte(SND_SEQ_EVENT_NONE_);      (* Do not generate MIDI output  *)
    result := true
  end { parseVelocity } ;


begin
  if txt = '' then
    exit(false);
  case txt[1] of
    '0'..'9',
    'a'..'f': result := parseHexEvent;
    'A'..'G',
    '_':      result := parseNoteEvent;
    '+':      result := parseDuration;
    '!':      result := parseVelocity
  otherwise
    exit(false)
  end
end { ParseMidiToEvent } ;


(* Initialise the parser. This is not mandatory but makes sure that persistent
  octave etc. are reset to the default values.
*)
procedure InitMidiParser;

begin
  lastExplicitDuration := 500;
  lastExplicitOctave := 5;
  lastExplicitVelocity := 64
end { InitMidiParser } ;


end.

