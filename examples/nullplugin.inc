
(********************************************************************************)
(*                                                                              *)
(* Interim functions that should be in a dynamically-loadable library. These    *)
(* are in an include file rather than a separate unit to avoid having to mess   *)
(* around with type visibility.                                                 *)
(*                                                                              *)
(* Note that to keep things simple these avoid anything that might imply heap   *)
(* operations.                                                                  *)
(*                                                                              *)
(********************************************************************************)

{ type
  filterCompilationString= string[80];
  outputNums= 0..31;
  outputSet= set of outputNums;
  seq_event_type_set= set of snd_seq_event_type; }


(* Return a magic number. Since this takes no parameter it should be immune to
  the ravages of the C/Pascal calling convention dichotomy.
*)
function ActualFilterVersion(): qword;

begin
  result := 202312250815
end { ActualFilterVersion } ;


(* On entry, this is either a magic number indicating the preferred API version
  or zero to indicate no preference. On exit, this is either the nearest
  available API version or zero indicating that no compatible API is available.
*)
function GetFilterVersion(preferredAPI: qword= 0): qword;

begin
  result := ActualFilterVersion
end { GetFilterVersion } ;


(* Return a string formed of the date and time of compilation.
*)
procedure GetFilterCompilationString(out fcs: FilterCompilationString);

begin
  fcs := (*$I %DATE% *) + ', ' + (*$I %TIME% *)
end { GetFilterCompilationString } ;


(* Initialise or wrap up filter operations, the parameter represents the number
  of output devices in the range 1 (stdout only) through 32; if the parameter
  is 0 then assume the plugin is being unloaded which does not necessarily
  imply that the entire program is shutting down. Return true on success, on
  failure optionally write an error message to stderr.
*)
function InitFilter(deviceCount: longword): boolean;

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
function ApplyFilter(var event: snd_seq_event_t; out os: outputSet): integer;

{ #todo :  There's a risk that event reuse will result in a double-free (or worse). }
// Basically, I don't know whether a received event results in a malloc() with a
// free() when it is transmitted, or if at all times it is in an internal pool
// hence could be overwritten while we think we are able to use it.

begin
  result := 1;                          (* No subsequent events                 *)
  os := [0..31]                         (* Caller only uses stdout and active devices *)
end { ApplyFilter } ;


