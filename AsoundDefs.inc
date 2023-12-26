
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

(* In the specific case of an interface to an ALSA subsystem (i.e. pcm, seq     *)
(* etc.), this supports only a small part of the overall API and should be      *)
(* extended with reference to the fpalsa project as required.                   *)

{*
 *   This library is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Lesser General Public License as
 *   published by the Free Software Foundation; either version 2.1 of
 *   the License, or (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Lesser General Public License for more details.
 *
 *   You should have received a copy of the GNU Lesser General Public
 *   License along with this library; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 *
 *}

// Documentation from https://www.alsa-project.org/alsa-doc/alsa-lib/group___error.html

{
#include <UnixType>
}

{$ifdef CONSTS }
{$endif CONSTS }
{$ifdef TYPES  }
{$endif TYPES  }

{$ifdef PROCS  }

// fpalsa defines these in error.inc:


(* Returns the message for an error code.

Parameters
    errnum	The error code number, which must be a system error code or an ALSA error code.

Returns
    The ASCII description of the given numeric error code.
*)
function snd_strerror(errnum: cint): PChar; cdecl; LIBASOUND__

{$endif PROCS  }

