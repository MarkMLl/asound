
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

// Documentation from https://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html

{
#include <UnixType>
}

{$ifdef CONSTS }
{$endif CONSTS }

{$ifdef TYPES  }

// fpalsa defines these in pcm.inc:

type
  { Signed frames quantity }
  snd_pcm_sframes_t = cint;

  { PCM handle }
  PPsnd_pcm_t = ^Psnd_pcm_t;
  Psnd_pcm_t  = Pointer;

  { PCM stream (direction) }
  snd_pcm_stream_t = cint;

  { PCM sample format }
  snd_pcm_format_t = cint;

  { PCM access type }
  snd_pcm_access_t = cint;

  { Unsigned frames quantity }
  snd_pcm_uframes_t = cuint;

const
  { Playback stream }
  SND_PCM_STREAM_PLAYBACK: snd_pcm_stream_t = 0;

  { Unsigned 8 bit }
  SND_PCM_FORMAT_U8: snd_pcm_format_t       = 1;

  { snd_pcm_readi/snd_pcm_writei access }
  SND_PCM_ACCESS_RW_INTERLEAVED: snd_pcm_access_t = 3;

{$endif TYPES  }

{$ifdef PROCS  }

// fpalsa defines these in pcm.inc:


(* Opens a PCM.

Parameters
    pcm         Returned PCM handle
    name        ASCII identifier of the PCM handle
    stream      Wanted stream
    mode        Open mode (see SND_PCM_NONBLOCK, SND_PCM_ASYNC)

Returns
    0 on success otherwise a negative error code
*)
function snd_pcm_open(pcm: PPsnd_pcm_t; Name: PChar; stream: snd_pcm_stream_t; mode: cint): cint; cdecl; LIBASOUND__

(* Set the hardware and software parameters in a simple way.

Parameters
    pcm	PCM handle
    format	required PCM format
    access	required PCM access
    channels	required PCM channels
    rate	required sample rate in Hz
    soft_resample	0 = disallow alsa-lib resample stream, 1 = allow resampling
    latency	required overall latency in us

Returns
    0 on success otherwise a negative error code
*)
function snd_pcm_set_params(pcm: Psnd_pcm_t; format: snd_pcm_format_t; access: snd_pcm_access_t; channels, rate: cuint; soft_resample: cint; latency: cuint): cint; cdecl; LIBASOUND__


(* Write interleaved frames to a PCM.

Parameters
    pcm	PCM handle
    buffer	frames containing buffer
    size	frames to be written

Returns
    a positive number of frames actually written otherwise a negative error code

Return values
    -EBADFD	PCM is not in the right state (SND_PCM_STATE_PREPARED or SND_PCM_STATE_RUNNING)
    -EPIPE	an underrun occurred
    -ESTRPIPE	a suspend event occurred (stream is suspended and waiting for an application recovery)

If the blocking behaviour is selected and it is running, then routine waits until all requested frames are played or put to the playback ring buffer. The returned number of frames can be less only if a signal or underrun occurred.

If the non-blocking behaviour is selected, then routine doesn't wait at all.

The function is thread-safe when built with the proper option.
*)
function snd_pcm_writei(pcm: Psnd_pcm_t; buffer: Pointer; size: snd_pcm_uframes_t): snd_pcm_sframes_t; cdecl; LIBASOUND__


(* Recover the stream state from an error or suspend.

Parameters
    pcm	PCM handle
    err	error number
    silent	do not print error reason

Returns
    0 when error code was handled successfuly, otherwise a negative error code

This a high-level helper function building on other functions.

This functions handles -EINTR (interrupted system call), -EPIPE (overrun or underrun) and -ESTRPIPE (stream is suspended) error codes trying to prepare given stream for next I/O.

Note that this function returs the original error code when it is not handled inside this function (for example -EAGAIN is returned back).
*)
function snd_pcm_recover(pcm: Psnd_pcm_t; err, silent: cint): cint; cdecl; LIBASOUND__


(* Stop a PCM preserving pending frames.

Parameters
    pcm	PCM handle

Returns
    0 on success otherwise a negative error code

Return values
    -ESTRPIPE	a suspend event occurred

For playback wait for all pending frames to be played and then stop the PCM. For capture stop PCM permitting to retrieve residual frames.

For stopping the PCM stream immediately, use ::snd_pcm_drop() instead.

The function is thread-safe when built with the proper option.
*)
function snd_pcm_drain(pcm: Psnd_pcm_t): cint; cdecl; LIBASOUND__


(* close PCM handle

Parameters
    pcm	PCM handle

Returns
    0 on success otherwise a negative error code

Closes the specified PCM handle and frees all associated resources.
*)
function snd_pcm_close(pcm: Psnd_pcm_t): cint; cdecl; LIBASOUND__


// fpalsa defines these in error.inc:


(* Returns the message for an error code.

Parameters
    errnum	The error code number, which must be a system error code or an ALSA error code.

Returns
    The ASCII description of the given numeric error code.
*)
function snd_strerror(errnum: cint): PChar; cdecl; LIBASOUND__

{$endif PROCS  }

