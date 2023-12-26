
(********************************************************************************)
(********************************************************************************)
(**                                                                            **)
(** FORMATTING NOTE: This file might be post-processed to generate Pascal      **)
(** units describing the static and dynamic interfaces to an external library. **)
(** Subroutine declarations MUST start with case-insensitive "function" or     **)
(** "procedure" as appropriate, and MUST end either with a Pascal macro name   **)
(** with at least one trailing underscore or with a semicolon. The style of    **)
(** termination is used to distinguish between external entry points and local **)
(** routines implemented as functional equivalents to C-style macros           **)
(** respectively.                                                              **)
(**                                                                            **)
(********************************************************************************)
(********************************************************************************)

(* This file contains the list of procedures/functions, either exported by a    *)
(* shared library or implemented by a statically-linked library. This might     *)
(* also double as the description of a list of procedures/functions exported by *)
(* a unit in cases where a library is written as part of a project group rather *)
(* than being provided by the host system.                                      *)
(*                                                                              *)
(* As such it is the master description of parameters and calling conventions,  *)
(* and all method type definitions etc. should comply with it.  MarkMLl.        *)

(* We need to refer to AsoundSeq to get the definition of snd_seq_event_t and   *)
(* its constituent fields and enumerations, no entry points are used.           *)

{
#include <AsoundSeq>
}

{$ifdef CONSTS }
const
  PluginMagicNumber= 2312250815;
{$endif CONSTS }

{$ifdef TYPES  }
type
  filterCompilationString= string[80];
  outputNums= 0..31;
  outputSet= set of outputNums;
{$endif TYPES  }

{$ifdef PROCS  }

(* Return the magic number which describes this library's API. This takes no
  parameter in an attempt to make sensible operation independent of the calling
  convention.
*)
function MagicNumber(): longword; cdecl; PLUGIN__

(* On entry, this is either a magic number indicating the preferred API version
  or zero to indicate no preference. On exit, this is either the nearest
  available API version or zero indicating that no compatible API is available.
*)
function GetFilterVersion(preferredAPI: longword= 0): longword; cdecl; PLUGIN__

(* Return a string formed of the date and time of compilation.
*)
procedure GetFilterCompilationString(out fcs: FilterCompilationString); cdecl; PLUGIN__

(* Initialise or wrap up filter operations, the parameter represents the number
  of output devices in the range 1 (stdout only) through 32; if the parameter
  is 0 then assume the plugin is being unloaded which does not necessarily
  imply that the entire program is shutting down. Return true on success, on
  failure optionally write an error message to stderr.
*)
function InitFilter(deviceCount: longword): boolean; cdecl; PLUGIN__

(* Filter an event of the indicated type, setting bits 0..31 as appropriate
  showing which output devices (0 representing stdout) it is to be sent to. The
  result will be 1 if the caller is expected to transmit the event and then
  flush the output queue, 0 if it is to be ignored, and some larger number if
  it is expected to repeat the call passing subsequent events to be overwritten
  and transmitted to one or more output devices with a flush after the final
  one.
*)
function ApplyFilter(var event: snd_seq_event_t; out os: outputSet): integer; cdecl; PLUGIN__

{$endif PROCS  }

