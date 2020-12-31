unit AsoundSeq_dynamic;

(* This is a minimal ALSA MIDI interface derived from work by Andreas Stoeckel, *)
(* Robert Rozee <rozee@mail.com> and FredvS <fiens@hotmail.com>. Refactored by  *)
(* MarkMLl.                                                                     *)

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
{$i AsoundSeqDefs.inc }

{$undef CONSTS  }
{$define TYPES  }
{$undef PROCS   }
{$i AsoundSeqDefs.inc }

(* These are the type descriptions of fields used to hold references to the     *)
(* methods listed in AsoundSeqDefs.inc (below). It is important that these      *)
(* types be considered subordinate to the definitions in the include file,      *)
(* since as well as being used here the include file might potentially be       *)
(* treated by the shared library as the authoritative list of what it is to     *)
(* export.                                                                      *)

type
  Tsnd_seq_open= function(handle: PPsnd_seq_t; name: PChar; streams: cint; mode: cint): cint; cdecl;
  Tsnd_seq_close= function(handle: Psnd_seq_t): cint; cdecl;
  Tsnd_seq_client_info_malloc= function(ptr: PPsnd_seq_client_info_t): cint; cdecl;
  Tsnd_seq_client_info_free= procedure(ptr: Psnd_seq_client_info_t); cdecl;
  Tsnd_seq_client_info_get_client= function(info: Psnd_seq_client_info_t): cint; cdecl;
  Tsnd_seq_client_info_get_type= function(info: Psnd_seq_client_info_t): snd_seq_client_type_t; cdecl;
  Tsnd_seq_client_info_get_name= function(info: Psnd_seq_client_info_t): PChar; cdecl;
  Tsnd_seq_client_info_set_client= procedure(info: Psnd_seq_client_info_t; client: cint); cdecl;
  Tsnd_seq_client_info_set_name= procedure(info: Psnd_seq_client_info_t; name: PChar); cdecl;
  Tsnd_seq_query_next_client= function(handle: Psnd_seq_t; info: Psnd_seq_client_info_t): cint; cdecl;
  Tsnd_seq_port_info_malloc= function(ptr: PPsnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_port_info_free= procedure(ptr: Psnd_seq_port_info_t); cdecl;
  Tsnd_seq_port_info_get_client= function(info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_port_info_get_port= function(info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_port_info_get_addr= function(info: Psnd_seq_port_info_t): Psnd_seq_addr_t; cdecl;
  Tsnd_seq_port_info_get_name= function(info: Psnd_seq_port_info_t): PChar; cdecl;
  Tsnd_seq_port_info_get_capability= function(info: Psnd_seq_port_info_t): cuint; cdecl;
  Tsnd_seq_port_info_get_type= function(info: Psnd_seq_port_info_t): cuint; cdecl;
  Tsnd_seq_port_info_set_client= procedure(info: Psnd_seq_port_info_t; client: cint); cdecl;
  Tsnd_seq_port_info_set_port= procedure(info: Psnd_seq_port_info_t; port: cint); cdecl;
  Tsnd_seq_port_info_set_addr= procedure(info: Psnd_seq_port_info_t; addr: Psnd_seq_addr_t); cdecl;
  Tsnd_seq_port_info_set_name= procedure(info: Psnd_seq_port_info_t; name: PChar); cdecl;
  Tsnd_seq_port_info_set_capability= procedure(info: Psnd_seq_port_info_t; capability: cuint); cdecl;
  Tsnd_seq_port_info_set_type= procedure(info: Psnd_seq_port_info_t; _type: cuint); cdecl;
  Tsnd_seq_port_info_set_port_specified= procedure(info: Psnd_seq_port_info_t; val: cint); cdecl;
  Tsnd_seq_create_port= function(handle: Psnd_seq_t; info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_query_next_port= function(handle: Psnd_seq_t; info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_alloc_named_queue= function(seq: Psnd_seq_t; name: PChar): cint; cdecl;
  Tsnd_seq_free_queue= function(handle: Psnd_seq_t; q: cint): cint; cdecl;
  Tsnd_seq_event_output= function(handle: Psnd_seq_t; ev: Psnd_seq_event_t): cint; cdecl;
  Tsnd_seq_drain_output= function(handle: Psnd_seq_t): cint; cdecl;
  Tsnd_seq_connect_to= function(seq: Psnd_seq_t; my_port, dest_client, dest_port: cint): cint; cdecl;
  Tsnd_seq_control_queue= function(seq: Psnd_seq_t; q, type_, value: cint; ev: Psnd_seq_event_t): cint; cdecl;
  Tsnd_seq_set_client_name= function(seq: Psnd_seq_t; name: PChar): cint; cdecl;
  Tsnd_seq_sync_output_queue= function(seq: Psnd_seq_t): cint; cdecl;

type
  TAsoundSeq= class(TAlsaSubsystem)
    (* The ALSA libraries are dynamically linked via a class, always return true
      even if an attempt to open them is expected to fail.
    *)
    class function IsDynamic(): boolean; inline;
  strict private
    Fsnd_seq_open: Tsnd_seq_open;
    Fsnd_seq_close: Tsnd_seq_close;
    Fsnd_seq_client_info_malloc: Tsnd_seq_client_info_malloc;
    Fsnd_seq_client_info_free: Tsnd_seq_client_info_free;
    Fsnd_seq_client_info_get_client: Tsnd_seq_client_info_get_client;
    Fsnd_seq_client_info_get_type: Tsnd_seq_client_info_get_type;
    Fsnd_seq_client_info_get_name: Tsnd_seq_client_info_get_name;
    Fsnd_seq_client_info_set_client: Tsnd_seq_client_info_set_client;
    Fsnd_seq_client_info_set_name: Tsnd_seq_client_info_set_name;
    Fsnd_seq_query_next_client: Tsnd_seq_query_next_client;
    Fsnd_seq_port_info_malloc: Tsnd_seq_port_info_malloc;
    Fsnd_seq_port_info_free: Tsnd_seq_port_info_free;
    Fsnd_seq_port_info_get_client: Tsnd_seq_port_info_get_client;
    Fsnd_seq_port_info_get_port: Tsnd_seq_port_info_get_port;
    Fsnd_seq_port_info_get_addr: Tsnd_seq_port_info_get_addr;
    Fsnd_seq_port_info_get_name: Tsnd_seq_port_info_get_name;
    Fsnd_seq_port_info_get_capability: Tsnd_seq_port_info_get_capability;
    Fsnd_seq_port_info_get_type: Tsnd_seq_port_info_get_type;
    Fsnd_seq_port_info_set_client: Tsnd_seq_port_info_set_client;
    Fsnd_seq_port_info_set_port: Tsnd_seq_port_info_set_port;
    Fsnd_seq_port_info_set_addr: Tsnd_seq_port_info_set_addr;
    Fsnd_seq_port_info_set_name: Tsnd_seq_port_info_set_name;
    Fsnd_seq_port_info_set_capability: Tsnd_seq_port_info_set_capability;
    Fsnd_seq_port_info_set_type: Tsnd_seq_port_info_set_type;
    Fsnd_seq_port_info_set_port_specified: Tsnd_seq_port_info_set_port_specified;
    Fsnd_seq_create_port: Tsnd_seq_create_port;
    Fsnd_seq_query_next_port: Tsnd_seq_query_next_port;
    Fsnd_seq_alloc_named_queue: Tsnd_seq_alloc_named_queue;
    Fsnd_seq_free_queue: Tsnd_seq_free_queue;
    Fsnd_seq_event_output: Tsnd_seq_event_output;
    Fsnd_seq_drain_output: Tsnd_seq_drain_output;
    Fsnd_seq_connect_to: Tsnd_seq_connect_to;
    Fsnd_seq_control_queue: Tsnd_seq_control_queue;
    Fsnd_seq_set_client_name: Tsnd_seq_set_client_name;
    Fsnd_seq_sync_output_queue: Tsnd_seq_sync_output_queue;
  public
    constructor Create(module: TDynamicModule; const subsys: string);
    {$push }
    {$macro on}
    {$undef CONSTS }
    {$undef TYPES  }
    {$define PROCS }
    {$define LIBASOUND__:= }
    {$i AsoundSeqDefs.inc }
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


(* Return either a static or a dynamic representation of the MIDI subsystem of
  the ALSA interface library (libasound.so or similar). In this case it is
  dynamic.
*)
function AsoundSeq(): TAsoundSeq; inline;


implementation

uses
  baseunix;

var
  xAsoundSeq: TAsoundSeq= nil;


constructor TAsoundSeq.Create(module: TDynamicModule; const subsys: string);

begin
  Inherited Create(module, subsys);
{$ifdef PRELOAD_ROUTINES }
  Fsnd_seq_open := Tsnd_seq_open(LoadRoutine('snd_seq_open'));
  Fsnd_seq_close := Tsnd_seq_close(LoadRoutine('snd_seq_close'));
  Fsnd_seq_client_info_malloc := Tsnd_seq_client_info_malloc(LoadRoutine('snd_seq_client_info_malloc'));
  Fsnd_seq_client_info_free := Tsnd_seq_client_info_free(LoadRoutine('snd_seq_client_info_free'));
  Fsnd_seq_client_info_get_client := Tsnd_seq_client_info_get_client(LoadRoutine('snd_seq_client_info_get_client'));
  Fsnd_seq_client_info_get_type := Tsnd_seq_client_info_get_type(LoadRoutine('snd_seq_client_info_get_type'));
  Fsnd_seq_client_info_get_name := Tsnd_seq_client_info_get_name(LoadRoutine('snd_seq_client_info_get_name'));
  Fsnd_seq_client_info_set_client := Tsnd_seq_client_info_set_client(LoadRoutine('snd_seq_client_info_set_client'));
  Fsnd_seq_client_info_set_name := Tsnd_seq_client_info_set_name(LoadRoutine('snd_seq_client_info_set_name'));
  Fsnd_seq_query_next_client := Tsnd_seq_query_next_client(LoadRoutine('snd_seq_query_next_client'));
  Fsnd_seq_port_info_malloc := Tsnd_seq_port_info_malloc(LoadRoutine('snd_seq_port_info_malloc'));
  Fsnd_seq_port_info_free := Tsnd_seq_port_info_free(LoadRoutine('snd_seq_port_info_free'));
  Fsnd_seq_port_info_get_client := Tsnd_seq_port_info_get_client(LoadRoutine('snd_seq_port_info_get_client'));
  Fsnd_seq_port_info_get_port := Tsnd_seq_port_info_get_port(LoadRoutine('snd_seq_port_info_get_port'));
  Fsnd_seq_port_info_get_addr := Tsnd_seq_port_info_get_addr(LoadRoutine('snd_seq_port_info_get_addr'));
  Fsnd_seq_port_info_get_name := Tsnd_seq_port_info_get_name(LoadRoutine('snd_seq_port_info_get_name'));
  Fsnd_seq_port_info_get_capability := Tsnd_seq_port_info_get_capability(LoadRoutine('snd_seq_port_info_get_capability'));
  Fsnd_seq_port_info_get_type := Tsnd_seq_port_info_get_type(LoadRoutine('snd_seq_port_info_get_type'));
  Fsnd_seq_port_info_set_client := Tsnd_seq_port_info_set_client(LoadRoutine('snd_seq_port_info_set_client'));
  Fsnd_seq_port_info_set_port := Tsnd_seq_port_info_set_port(LoadRoutine('snd_seq_port_info_set_port'));
  Fsnd_seq_port_info_set_addr := Tsnd_seq_port_info_set_addr(LoadRoutine('snd_seq_port_info_set_addr'));
  Fsnd_seq_port_info_set_name := Tsnd_seq_port_info_set_name(LoadRoutine('snd_seq_port_info_set_name'));
  Fsnd_seq_port_info_set_capability := Tsnd_seq_port_info_set_capability(LoadRoutine('snd_seq_port_info_set_capability'));
  Fsnd_seq_port_info_set_type := Tsnd_seq_port_info_set_type(LoadRoutine('snd_seq_port_info_set_type'));
  Fsnd_seq_port_info_set_port_specified := Tsnd_seq_port_info_set_port_specified(LoadRoutine('snd_seq_port_info_set_port_specified'));
  Fsnd_seq_create_port := Tsnd_seq_create_port(LoadRoutine('snd_seq_create_port'));
  Fsnd_seq_query_next_port := Tsnd_seq_query_next_port(LoadRoutine('snd_seq_query_next_port'));
  Fsnd_seq_alloc_named_queue := Tsnd_seq_alloc_named_queue(LoadRoutine('snd_seq_alloc_named_queue'));
  Fsnd_seq_free_queue := Tsnd_seq_free_queue(LoadRoutine('snd_seq_free_queue'));
  Fsnd_seq_event_output := Tsnd_seq_event_output(LoadRoutine('snd_seq_event_output'));
  Fsnd_seq_drain_output := Tsnd_seq_drain_output(LoadRoutine('snd_seq_drain_output'));
  Fsnd_seq_connect_to := Tsnd_seq_connect_to(LoadRoutine('snd_seq_connect_to'));
  Fsnd_seq_control_queue := Tsnd_seq_control_queue(LoadRoutine('snd_seq_control_queue'));
  Fsnd_seq_set_client_name := Tsnd_seq_set_client_name(LoadRoutine('snd_seq_set_client_name'));
  Fsnd_seq_sync_output_queue := Tsnd_seq_sync_output_queue(LoadRoutine('snd_seq_sync_output_queue'))
{$else                   }
  Fsnd_seq_open := nil;
  Fsnd_seq_close := nil;
  Fsnd_seq_client_info_malloc := nil;
  Fsnd_seq_client_info_free := nil;
  Fsnd_seq_client_info_get_client := nil;
  Fsnd_seq_client_info_get_type := nil;
  Fsnd_seq_client_info_get_name := nil;
  Fsnd_seq_client_info_set_client := nil;
  Fsnd_seq_client_info_set_name := nil;
  Fsnd_seq_query_next_client := nil;
  Fsnd_seq_port_info_malloc := nil;
  Fsnd_seq_port_info_free := nil;
  Fsnd_seq_port_info_get_client := nil;
  Fsnd_seq_port_info_get_port := nil;
  Fsnd_seq_port_info_get_addr := nil;
  Fsnd_seq_port_info_get_name := nil;
  Fsnd_seq_port_info_get_capability := nil;
  Fsnd_seq_port_info_get_type := nil;
  Fsnd_seq_port_info_set_client := nil;
  Fsnd_seq_port_info_set_port := nil;
  Fsnd_seq_port_info_set_addr := nil;
  Fsnd_seq_port_info_set_name := nil;
  Fsnd_seq_port_info_set_capability := nil;
  Fsnd_seq_port_info_set_type := nil;
  Fsnd_seq_port_info_set_port_specified := nil;
  Fsnd_seq_create_port := nil;
  Fsnd_seq_query_next_port := nil;
  Fsnd_seq_alloc_named_queue := nil;
  Fsnd_seq_free_queue := nil;
  Fsnd_seq_event_output := nil;
  Fsnd_seq_drain_output := nil;
  Fsnd_seq_connect_to := nil;
  Fsnd_seq_control_queue := nil;
  Fsnd_seq_set_client_name := nil;
  Fsnd_seq_sync_output_queue := nil
{$endif PRELOAD_ROUTINES }
end { TAsoundSeq.Create } ;


function TAsoundSeq.snd_seq_open(handle: PPsnd_seq_t; name: PChar; streams: cint; mode: cint): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_open), 'snd_seq_open');
    result := Fsnd_seq_open(handle, name, streams, mode)
  except
    result := -ESysELIBACC              (* Can not access a needed shared library *)
  end
end { TAsoundSeq.snd_seq_open } ;


function TAsoundSeq.snd_seq_close(handle: Psnd_seq_t): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_close), 'snd_seq_close');
    result := Fsnd_seq_close(handle)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_close } ;


function TAsoundSeq.snd_seq_client_info_malloc(ptr: PPsnd_seq_client_info_t): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_client_info_malloc), 'snd_seq_client_info_malloc');
    result := Fsnd_seq_client_info_malloc(ptr)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_client_info_malloc } ;


procedure TAsoundSeq.snd_seq_client_info_free(ptr: Psnd_seq_client_info_t); cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_client_info_free), 'snd_seq_client_info_free');
    Fsnd_seq_client_info_free(ptr)
  except
  end
end { TAsoundSeq.snd_seq_client_info_free } ;


function TAsoundSeq.snd_seq_client_info_get_client(info: Psnd_seq_client_info_t): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_client_info_get_client), 'snd_seq_client_info_get_client');
    result := Fsnd_seq_client_info_get_client(info)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_client_info_get_client } ;


function TAsoundSeq.snd_seq_client_info_get_type(info: Psnd_seq_client_info_t): snd_seq_client_type_t; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_client_info_get_type), 'snd_seq_client_info_get_type');
    result := Fsnd_seq_client_info_get_type(info)
  except
    FillByte(result, SizeOf(result), 0)
  end
end { TAsoundSeq.snd_seq_client_info_get_type } ;


function TAsoundSeq.snd_seq_client_info_get_name(info: Psnd_seq_client_info_t): PChar; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_client_info_get_name), 'snd_seq_client_info_get_name');
    result := Fsnd_seq_client_info_get_name(info)
  except
    result := ''
  end
end { TAsoundSeq.snd_seq_client_info_get_name } ;


procedure TAsoundSeq.snd_seq_client_info_set_client(info: Psnd_seq_client_info_t; client: cint); cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_client_info_set_client), 'snd_seq_client_info_set_client');
    Fsnd_seq_client_info_set_client(info, client)
  except
  end
end { TAsoundSeq.snd_seq_client_info_set_client } ;


procedure TAsoundSeq.snd_seq_client_info_set_name(info: Psnd_seq_client_info_t; name: PChar); cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_client_info_set_name), 'snd_seq_client_info_set_name');
    Fsnd_seq_client_info_set_name(info, name)
  except
  end
end { TAsoundSeq.snd_seq_client_info_set_name } ;


function TAsoundSeq.snd_seq_query_next_client(handle: Psnd_seq_t; info: Psnd_seq_client_info_t): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_query_next_client), 'snd_seq_query_next_client');
    result := Fsnd_seq_query_next_client(handle, info)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_query_next_client } ;


function TAsoundSeq.snd_seq_port_info_malloc(ptr: PPsnd_seq_port_info_t): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_port_info_malloc), 'snd_seq_port_info_malloc');
    result := Fsnd_seq_port_info_malloc(ptr)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_port_info_malloc } ;


procedure TAsoundSeq.snd_seq_port_info_free(ptr: Psnd_seq_port_info_t); cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_port_info_free), 'snd_seq_port_info_free');
    Fsnd_seq_port_info_free(ptr)
  except
  end
end { TAsoundSeq.snd_seq_port_info_free } ;


function TAsoundSeq.snd_seq_port_info_get_client(info: Psnd_seq_port_info_t): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_port_info_get_client), 'snd_seq_port_info_get_client');
    result := Fsnd_seq_port_info_get_client(info)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_port_info_get_client } ;


function TAsoundSeq.snd_seq_port_info_get_port(info: Psnd_seq_port_info_t): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_port_info_get_port), 'snd_seq_port_info_get_port');
    result := Fsnd_seq_port_info_get_port(info)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_port_info_get_port } ;


function TAsoundSeq.snd_seq_port_info_get_addr(info: Psnd_seq_port_info_t): Psnd_seq_addr_t; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_port_info_get_addr), 'snd_seq_port_info_get_addr');
    result := Fsnd_seq_port_info_get_addr(info)
  except
    FillByte(result, SizeOf(result), 0)
  end
end { TAsoundSeq.snd_seq_port_info_get_addr } ;


function TAsoundSeq.snd_seq_port_info_get_name(info: Psnd_seq_port_info_t): PChar; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_port_info_get_name), 'snd_seq_port_info_get_name');
    result := Fsnd_seq_port_info_get_name(info)
  except
    result := ''
  end
end { TAsoundSeq.snd_seq_port_info_get_name } ;


function TAsoundSeq.snd_seq_port_info_get_capability(info: Psnd_seq_port_info_t): cuint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_port_info_get_capability), 'snd_seq_port_info_get_capability');
    result := Fsnd_seq_port_info_get_capability(info)
  except
{$push }
{$r-   }
    result := cuint(-ESysEBADFD)
{$pop  }
  end
end { TAsoundSeq.snd_seq_port_info_get_capability } ;


function TAsoundSeq.snd_seq_port_info_get_type(info: Psnd_seq_port_info_t): cuint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_port_info_get_type), 'snd_seq_port_info_get_type');
    result := Fsnd_seq_port_info_get_type(info)
  except
{$push }
{$r-   }
    result := cuint(-ESysEBADFD)
{$pop  }
  end
end { TAsoundSeq.snd_seq_port_info_get_type } ;


procedure TAsoundSeq.snd_seq_port_info_set_client(info: Psnd_seq_port_info_t; client: cint); cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_port_info_set_client), 'snd_seq_port_info_set_client');
    Fsnd_seq_port_info_set_client(info, client)
  except
  end
end { TAsoundSeq.snd_seq_port_info_set_client } ;


procedure TAsoundSeq.snd_seq_port_info_set_port(info: Psnd_seq_port_info_t; port: cint); cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_port_info_set_port), 'snd_seq_port_info_set_port');
    Fsnd_seq_port_info_set_port(info, port)
  except
  end
end { TAsoundSeq.snd_seq_port_info_set_port } ;


procedure TAsoundSeq.snd_seq_port_info_set_addr(info: Psnd_seq_port_info_t; addr: Psnd_seq_addr_t); cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_port_info_set_addr), 'snd_seq_port_info_set_addr');
    Fsnd_seq_port_info_set_addr(info, addr)
  except
  end
end { TAsoundSeq.snd_seq_port_info_set_addr } ;


procedure TAsoundSeq.snd_seq_port_info_set_name(info: Psnd_seq_port_info_t; name: PChar); cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_port_info_set_name), 'snd_seq_port_info_set_name');
    Fsnd_seq_port_info_set_name(info, name)
  except
  end
end { TAsoundSeq.snd_seq_port_info_set_name } ;


procedure TAsoundSeq.snd_seq_port_info_set_capability(info: Psnd_seq_port_info_t; capability: cuint); cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_port_info_set_capability), 'snd_seq_port_info_set_capability');
    Fsnd_seq_port_info_set_capability(info, capability)
  except
  end
end { TAsoundSeq.snd_seq_port_info_set_capability } ;


procedure TAsoundSeq.snd_seq_port_info_set_type(info: Psnd_seq_port_info_t; _type: cuint); cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_port_info_set_type), 'snd_seq_port_info_set_type');
    Fsnd_seq_port_info_set_type(info, _type)
  except
  end
end { TAsoundSeq.snd_seq_port_info_set_type } ;


procedure TAsoundSeq.snd_seq_port_info_set_port_specified(info: Psnd_seq_port_info_t; val: cint); cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_port_info_set_port_specified), 'snd_seq_port_info_set_port_specified');
    Fsnd_seq_port_info_set_port_specified(info, val)
  except
  end
end { TAsoundSeq.snd_seq_port_info_set_port_specified } ;


function TAsoundSeq.snd_seq_create_port(handle: Psnd_seq_t; info: Psnd_seq_port_info_t): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_create_port), 'snd_seq_create_port');
    result := Fsnd_seq_create_port(handle, info)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_create_port } ;


function TAsoundSeq.snd_seq_query_next_port(handle: Psnd_seq_t; info: Psnd_seq_port_info_t): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_query_next_port), 'snd_seq_query_next_port');
    result := Fsnd_seq_query_next_port(handle, info)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_query_next_port } ;


function TAsoundSeq.snd_seq_alloc_named_queue(seq: Psnd_seq_t; name: PChar): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_alloc_named_queue), 'snd_seq_alloc_named_queue');
    result := Fsnd_seq_alloc_named_queue(seq, name)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_alloc_named_queue } ;


function TAsoundSeq.snd_seq_free_queue(handle: Psnd_seq_t; q: cint): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_free_queue), 'snd_seq_free_queue');
    result := Fsnd_seq_free_queue(handle, q)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_free_queue } ;


function TAsoundSeq.snd_seq_event_output(handle: Psnd_seq_t; ev: Psnd_seq_event_t): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_event_output), 'snd_seq_event_output');
    result := Fsnd_seq_event_output(handle, ev)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_event_output } ;


function TAsoundSeq.snd_seq_drain_output(handle: Psnd_seq_t): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_drain_output), 'snd_seq_drain_output');
    result := Fsnd_seq_drain_output(handle)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_drain_output } ;


function TAsoundSeq.snd_seq_connect_to(seq: Psnd_seq_t; my_port, dest_client, dest_port: cint): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_connect_to), 'snd_seq_connect_to');
    result := Fsnd_seq_connect_to(seq, my_port, dest_client, dest_port)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_connect_to } ;


function TAsoundSeq.snd_seq_control_queue(seq: Psnd_seq_t; q, type_, value: cint; ev: Psnd_seq_event_t): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_control_queue), 'snd_seq_control_queue');
    result := Fsnd_seq_control_queue(seq, q, type_, value, ev)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_control_queue } ;


function TAsoundSeq.snd_seq_set_client_name(seq: Psnd_seq_t; name: PChar): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_set_client_name), 'snd_seq_set_client_name');
    result := Fsnd_seq_set_client_name(seq, name)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_set_client_name } ;


function TAsoundSeq.snd_seq_sync_output_queue(seq: Psnd_seq_t): cint; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_seq_sync_output_queue), 'snd_seq_sync_output_queue');
    result := Fsnd_seq_sync_output_queue(seq)
  except
    result := -ESysEBADFD
  end
end { TAsoundSeq.snd_seq_sync_output_queue } ;


procedure TAsoundSeq.snd_seq_ev_clear(ev: Psnd_seq_event_t); inline;

begin
  FillChar(ev^, SizeOf(snd_seq_event_t), 0);
end { TAsoundSeq.snd_seq_ev_clear } ;


function TAsoundSeq.snd_seq_start_queue(seq: Psnd_seq_t; q: cint; ev: Psnd_seq_event_t): cint; inline;

begin
  Result := snd_seq_control_queue(seq, q, cint(SND_SEQ_EVENT_START), 0, ev)
end { TAsoundSeq.snd_seq_start_queue } ;


procedure TAsoundSeq.snd_seq_ev_set_fixed(ev: Psnd_seq_event_t); inline;

begin
  ev^.flags := ev^.flags and not SND_SEQ_EVENT_LENGTH_MASK;
  ev^.flags := ev^.flags or SND_SEQ_EVENT_LENGTH_FIXED;
end { TAsoundSeq.snd_seq_ev_set_fixed } ;


(* Return either a static or a dynamic representation of the MIDI subsystem of
  the ALSA interface library (libasound.so or similar). In this case it is
  dynamic.
*)
function AsoundSeq(): TAsoundSeq; inline;

begin
  AsoundSeq := xAsoundSeq
end { AsoundSeq } ;

(********************************************************************************)
(*                                                                              *)
(* Convenience function(s) to satisfy the most common reasons a caller would    *)
(* have to go directly to Asound.                                               *)
(*                                                                              *)
(********************************************************************************)

function TAsoundSeq.snd_strerror(errnum: cint): PChar; cdecl;

begin
  result := Asound.snd_strerror(errnum)
end { TAsoundSeq.snd_strerror } ;


class function TAsoundSeq.IsDynamic(): boolean; inline;

begin
  result := true
end { TAsoundSeq.IsDynamic } ;


function TAsoundSeq.ModuleInMemory(): boolean;

begin
  result := Asound.ModuleInMemory
end { TAsoundSeq.ModuleInMemory } ;


initialization
  xAsoundSeq := TAsoundSeq.Create(ASound, 'seq')
finalization
  FreeAndNil(xAsoundSeq)
end.

