unit Filter_DemoCode;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ASoundSeq;

{$push }
{$macro on }
{$define CONSTS }
{$i plugin.inc }
{$undef CONSTS  }
{$define TYPES  }
{$i plugin.inc }
{$undef TYPES   }
{$define PROCS  }
{$define PLUGIN__:= }
{$i plugin.inc }
{$undef PROCS   }
{$pop }


implementation


(* Return the magic number which describes this library's API. This takes no
  parameter in an attempt to make sensible operation independent of the calling
  convention.
*)
function MagicNumber(): longword; cdecl;

begin
  result := PluginMagicNumber
end { MagicNumber } ;


(* On entry, this is either a magic number indicating the preferred API version
  or zero to indicate no preference. On exit, this is either the nearest
  available API version or zero indicating that no compatible API is available.
*)
function GetFilterVersion(preferredAPI: longword= 0): longword; cdecl;

begin
  result := PluginMagicNumber
end { GetFilterVersion } ;


(* Return a string formed of the date and time of compilation.
*)
procedure GetFilterCompilationString(out fcs: FilterCompilationString); cdecl;

begin
  fcs := (*$I %DATE% *) + ', ' + (*$I %TIME% *)
end { GetFilterCompilationString } ;


(* Initialise or wrap up filter operations, the parameter represents the number
  of output devices in the range 1 (stdout only) through 32; if the parameter
  is 0 then assume the plugin is being unloaded which does not necessarily
  imply that the entire program is shutting down. Return true on success, on
  failure optionally write an error message to stderr.
*)
function InitFilter(deviceCount: longword): boolean; cdecl;

begin
  if deviceCount = 0 then
    result := true
  else
    result := (deviceCount <= 32)
end { InitFilter } ;


(* Filter an event of the indicated type, setting bits 0..31 as appropriate
  showing which output devices (0 representing stdout) it is to be sent to. The
  result will be 1 if the caller is expected to transmit the event and then
  flush the output queue, 0 if it is to be ignored, and some larger number if
  it is expected to repeat the call passing subsequent events to be overwritten
  and transmitted to one or more output devices with a flush after the final
  one.
*)
function ApplyFilter(var event: snd_seq_event_t; out os: outputSet): integer; cdecl;

{ #todo :  There's a risk that event reuse will result in a double-free (or worse). }
// Basically, I don't know whether a received event results in a malloc() with a
// free() when it is transmitted, or if at all times it is in an internal pool
// hence could be overwritten while we think we are able to use it.

begin
  result := 1;                          (* No subsequent events                 *)
  os := [0..31];                        (* Caller only uses stdout and active devices *)

(* This is an example hack. A keyboard is emitting organ-style NOTEON events    *)
(* (with zero-velocity standing in for NOTEOFF), convert these into piano-style *)
(* NOTE events.                                                                 *)

  case snd_seq_event_type(event.type_) of
    SND_SEQ_EVENT_NOTEON:  with event.data.note do
                             if velocity = 0 then       (* Ignore this if seen  *)
                               result := 0
                             else begin
                               event.type_ := snd_seq_event_type_t(SND_SEQ_EVENT_NOTE);
                               off_velocity := velocity;
                               duration := 6 * velocity
                             end;
    SND_SEQ_EVENT_NOTEOFF: result := 0                  (* Ignore this if seen  *)
  otherwise
  end

end { ApplyFilter } ;


end.

