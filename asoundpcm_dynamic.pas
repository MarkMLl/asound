unit AsoundPcm_dynamic;

(* This is a minimal ALSA PCM interface derived from work by Andreas Stoeckel,  *)
(* Robert Rozee <rozee@mail.com> and FredvS <fiens@hotmail.com>. Refactored by  *)
(* MarkMLl based on a concept by Martin Halliday <kodekraft@cix> and possibly   *)
(* older work relating to NAG.                                                  *)

{  Free Pascal port by Nikolay Nikolov <nickysn@users.sourceforge.net>
   This version of the header has been created by Andreas Stoeckel and has been
   adapted to the needs of the Audorra audio library. For a complete version of the
   header for pascal have a look for the fpAlsa project on sourceforge.
   http://sourceforge.net/projects/fpalsa/
   This adaption has been done for the following reasons:
     - Easier to update to new versions of ALSA, as not the whole header has to be updated
     - Easier to distribute with Audorra (only a short, single file)
}

{**
 * \file include/asoundlib.h
 * \brief Application interface library for the ALSA driver
 * \author Jaroslav Kysela <perex@perex.cz>
 * \author Abramo Bagnara <abramo@alsa-project.org>
 * \author Takashi Iwai <tiwai@suse.de>
 * \date 1998-2001
 *
 * Application interface library for the ALSA driver
 *}
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

{$mode objfpc}{$H+}
{$PACKRECORDS C}

interface

uses
  Classes, SysUtils, Asound_dynamic, CTypes;

{$define CONSTS }
{$undef TYPES   }
{$undef PROCS   }
{$i AsoundPcmDefs.inc }

{$undef CONSTS  }
{$define TYPES  }
{$undef PROCS   }
{$i AsoundPcmDefs.inc }

(* These are the type descriptions of fields used to hold references to the     *)
(* methods listed in AsoundPcmDefs.inc (below). It is important that these      *)
(* types be considered subordinate to the definitions in the include file,      *)
(* since as well as being used here the include file might potentially be       *)
(* treated by the shared library as the authoritative list of what it is to     *)
(* export.                                                                      *)

type
  Tsnd_pcm_open= function(pcm: PPsnd_pcm_t; Name: PChar; stream: snd_pcm_stream_t; mode: cint): cint; cdecl;
  Tsnd_pcm_set_params= function(pcm: Psnd_pcm_t; format: snd_pcm_format_t; access: snd_pcm_access_t; channels, rate: cuint; soft_resample: cint; latency: cuint): cint; cdecl;
  Tsnd_pcm_writei= function(pcm: Psnd_pcm_t; buffer: Pointer; size: snd_pcm_uframes_t): snd_pcm_sframes_t; cdecl;
  Tsnd_pcm_recover= function(pcm: Psnd_pcm_t; err, silent: cint): cint; cdecl;
  Tsnd_pcm_drain= function(pcm: Psnd_pcm_t): cint; cdecl;
  Tsnd_pcm_close= function(pcm: Psnd_pcm_t): cint; cdecl;

type
  TAsoundPcm= class(TAlsaSubsystem)
    (* The ALSA libraries are dynamically linked via a class, always return true
      even if an attempt to open them is expected to fail.
    *)
    class function IsDynamic(): boolean; inline;
  strict private
    Fsnd_pcm_open: Tsnd_pcm_open;
    Fsnd_pcm_set_params: Tsnd_pcm_set_params;
    Fsnd_pcm_writei: Tsnd_pcm_writei;
    Fsnd_pcm_recover: Tsnd_pcm_recover;
    Fsnd_pcm_drain: Tsnd_pcm_drain;
    Fsnd_pcm_close: Tsnd_pcm_close;
  public
    constructor Create(module: TDynamicModule; const subsys: string);
    {$push }
    {$macro on}
    {$undef CONSTS }
    {$undef TYPES  }
    {$define PROCS }
    {$define LIBASOUND__:= }
    {$i AsoundPcmDefs.inc }
    {$pop }
    (* Returns the message for an error code.

    Parameters
        errnum	The error code number, which must be a system error code or an ALSA error code.

    Returns
        The ASCII description of the given numeric error code.
    *)
    function snd_strerror(errnum: cint): PChar; cdecl;
    function ModuleInMemory(): boolean;
  end;


(* Return either a static or a dynamic representation of the PCM subsystem of
  the ALSA interface library (libasound.so or similar). In this case it is
  dynamic.
*)
function AsoundPcm(): TAsoundPcm; inline;


implementation

uses
  baseunix;

var
  xAsoundPcm: TAsoundPcm= nil;


constructor TAsoundPcm.Create(module: TDynamicModule; const subsys: string);

begin
  Inherited Create(module, subsys);
{$ifdef PRELOAD_ROUTINES }
  Fsnd_pcm_open := Tsnd_pcm_open(LoadRoutine('snd_pcm_open'));
  Fsnd_pcm_set_params := Tsnd_pcm_set_params(LoadRoutine('snd_pcm_set_params'));
  Fsnd_pcm_writei := Tsnd_pcm_writei(LoadRoutine('snd_pcm_writei'));
  Fsnd_pcm_recover := Tsnd_pcm_recover(LoadRoutine('snd_pcm_recover'));
  Fsnd_pcm_drain := Tsnd_pcm_drain(LoadRoutine('snd_pcm_drain'));
  Fsnd_pcm_close := Tsnd_pcm_close(LoadRoutine('snd_pcm_close'))
{$else                   }
  Fsnd_pcm_open := nil;
  Fsnd_pcm_set_params := nil;
  Fsnd_pcm_writei := nil;
  Fsnd_pcm_recover := nil;
  Fsnd_pcm_drain := nil;
  Fsnd_pcm_close := nil
{$endif PRELOAD_ROUTINES }
end { TAsoundPcm.Create } ;


function TAsoundPcm.snd_pcm_open(pcm: PPsnd_pcm_t; Name: PChar; stream: snd_pcm_stream_t; mode: cint): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_pcm_open), 'snd_pcm_open');
    result := Fsnd_pcm_open(pcm, Name, stream, mode)
  except
    result := -ESysELIBACC              (* Can not access a needed shared library *)
  end
end { TAsoundPcm.snd_pcm_open } ;


function TAsoundPcm.snd_pcm_set_params(pcm: Psnd_pcm_t; format: snd_pcm_format_t; access: snd_pcm_access_t; channels, rate: cuint; soft_resample: cint; latency: cuint): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_pcm_set_params), 'snd_pcm_set_params');
    result := Fsnd_pcm_set_params(pcm, format, access, channels, rate, soft_resample, latency)
  except
    result := -ESysEBADFD
  end
end { Tsnd_pcm_set_params } ;


function TAsoundPcm.snd_pcm_writei(pcm: Psnd_pcm_t; buffer: Pointer; size: snd_pcm_uframes_t): snd_pcm_sframes_t; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_pcm_writei), 'snd_pcm_writei');
    result := Fsnd_pcm_writei(pcm, buffer, size)
  except
    result := -ESysEBADFD
  end
end { TAsoundPcm.snd_pcm_writei } ;


function TAsoundPcm.snd_pcm_recover(pcm: Psnd_pcm_t; err, silent: cint): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_pcm_recover), 'snd_pcm_recover');
    result := Fsnd_pcm_recover(pcm, err, silent)
  except
    result := -ESysEBADFD
  end
end { TAsoundPcm.snd_pcm_open } ;


function TAsoundPcm.snd_pcm_drain(pcm: Psnd_pcm_t): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_pcm_drain), 'snd_pcm_drain');
    result := Fsnd_pcm_drain(pcm)
  except
    result := -ESysEBADFD
  end
end { TAsoundPcm.snd_pcm_drain } ;


function TAsoundPcm.snd_pcm_close(pcm: Psnd_pcm_t): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_pcm_close), 'snd_pcm_close');
    result := Fsnd_pcm_close(pcm)
  except
    result := -ESysEBADFD
  end
end { TAsoundPcm.snd_pcm_open } ;


(* Return either a static or a dynamic representation of the PCM subsystem of
  the ALSA interface library (libasound.so or similar). In this case it is
  dynamic.
*)
function AsoundPcm(): TAsoundPcm; inline;

begin
  AsoundPcm := xAsoundPcm
end { AsoundPcm } ;

(********************************************************************************)
(*                                                                              *)
(* Convenience function(s) to satisfy the most common reasons a caller would    *)
(* have to go directly to Asound.                                               *)
(*                                                                              *)
(********************************************************************************)

function TAsoundPcm.snd_strerror(errnum: cint): PChar; cdecl;

begin
  result := Asound.snd_strerror(errnum)
end { TAsoundPcm.snd_strerror } ;


class function TAsoundPcm.IsDynamic(): boolean; inline;

begin
  result := true
end { TAsoundPcm.IsDynamic } ;


function TAsoundPcm.ModuleInMemory(): boolean;

begin
  result := Asound.ModuleInMemory
end { TAsoundPcm.ModuleInMemory } ;


initialization
  xAsoundPcm := TAsoundPcm.Create(Asound, 'pcm')
finalization
  FreeAndNil(xAsoundPcm)
end.

