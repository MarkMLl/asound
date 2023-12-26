unit AsoundPcm_dynamic;

(********************************************************************************)
(*                                                                              *)
(* WARNING: This is a machine-generated file and manual changes will be lost.   *)
(*                                                                              *)
(********************************************************************************)

{$mode objfpc}{$H+}
{$packrecords C}

(*
 * Please refer to AsoundPcmDefs.inc and other accompanying files for
 * licensing and disclaimer information.
 *)

interface

uses
  Classes, SysUtils, UnixType, DynamicModule;

const
  DefaultModuleName= 'libasound.so';
  DefaultEarlyLoad= true;
  HasLoadVarargsRoutine= true;          (* Presence is implementation-defined   *)

{$define DYNAMIC }
{$define CONSTS }
{$undef TYPES   }
{$undef PROCS   }
{$undef VPROCS  }
{$i AsoundPcmDefs.inc }

{$undef CONSTS  }
{$define TYPES  }
{$undef PROCS   }
{$undef VPROCS  }
{$i AsoundPcmDefs.inc }

(* These are the type descriptions of fields used to hold references to the     *)
(* methods listed in AsoundPcmDefs.inc (below). It is important that these types  *)
(* be considered subordinate to the definitions in the include file, since as   *)
(* well as being used here the include file might potentially be treated by the *)
(* shared library as the authoritative list of what it is to export.            *)

type
  Tsnd_pcm_open= function(pcm: PPsnd_pcm_t; Name: PChar; stream: snd_pcm_stream_t; mode: cint): cint; cdecl;
  Tsnd_pcm_set_params= function(pcm: Psnd_pcm_t; format: snd_pcm_format_t; access: snd_pcm_access_t; channels, rate: cuint; soft_resample: cint; latency: cuint): cint; cdecl;
  Tsnd_pcm_writei= function(pcm: Psnd_pcm_t; buffer: Pointer; size: snd_pcm_uframes_t): snd_pcm_sframes_t; cdecl;
  Tsnd_pcm_recover= function(pcm: Psnd_pcm_t; err, silent: cint): cint; cdecl;
  Tsnd_pcm_drain= function(pcm: Psnd_pcm_t): cint; cdecl;
  Tsnd_pcm_close= function(pcm: Psnd_pcm_t): cint; cdecl;
  Tsnd_strerror= function(errnum: cint): PChar; cdecl;

type
  TAsoundPcm= class(TDynamicModule)
  strict private
    Fsnd_pcm_open: Tsnd_pcm_open;
    Fsnd_pcm_set_params: Tsnd_pcm_set_params;
    Fsnd_pcm_writei: Tsnd_pcm_writei;
    Fsnd_pcm_recover: Tsnd_pcm_recover;
    Fsnd_pcm_drain: Tsnd_pcm_drain;
    Fsnd_pcm_close: Tsnd_pcm_close;
    Fsnd_strerror: Tsnd_strerror;
  public
    (* Case-sensitivity depends on the operating system and filesystem.
    *)
    constructor Create(const LoadName: string);
    procedure LoadVarargsRoutine(loadName: string= ''; keepGoing: boolean= false);
    {$push }
    {$macro on }
    {$undef CONSTS }
    {$undef TYPES  }
    {$define PROCS }
    {$undef VPROCS }
    {$define CDECL__:= }
    {$define CDECL_VARARGS__:= }
    {$define LIBASOUND__:= }
    {$i AsoundPcmDefs.inc }
    {$pop }
  end;

(* Return either a static or a dynamic representation of the Asound embedding
  library (libasound.so or similar). In this case it is dynamic.
*)
function AsoundPcm(): TAsoundPcm; inline;

(* Create the object and optionally load the shared object library.
*)
procedure InitialiseLibrary(const moduleName: string= DefaultModuleName;
                                        earlyLoad: boolean= DefaultEarlyLoad);

(* Create the object and optionally load the shared object library.
*)
procedure InitializeLibrary(const moduleName: string= DefaultModuleName;
                                        earlyLoad: boolean= DefaultEarlyLoad);


implementation

var
  xAsoundPcm: TAsoundPcm= nil;


constructor TAsoundPcm.Create(const LoadName: string);

begin
  inherited Create(loadName);
{$ifdef PRELOAD_ROUTINES }
  Fsnd_pcm_open := Tsnd_pcm_open(LoadRoutine('snd_pcm_open'));
  Fsnd_pcm_set_params := Tsnd_pcm_set_params(LoadRoutine('snd_pcm_set_params'));
  Fsnd_pcm_writei := Tsnd_pcm_writei(LoadRoutine('snd_pcm_writei'));
  Fsnd_pcm_recover := Tsnd_pcm_recover(LoadRoutine('snd_pcm_recover'));
  Fsnd_pcm_drain := Tsnd_pcm_drain(LoadRoutine('snd_pcm_drain'));
  Fsnd_pcm_close := Tsnd_pcm_close(LoadRoutine('snd_pcm_close'));
  Fsnd_strerror := Tsnd_strerror(LoadRoutine('snd_strerror'));
  LoadVarargsRoutine;
{$else                   }
  Fsnd_pcm_open := nil;
  Fsnd_pcm_set_params := nil;
  Fsnd_pcm_writei := nil;
  Fsnd_pcm_recover := nil;
  Fsnd_pcm_drain := nil;
  Fsnd_pcm_close := nil;
  Fsnd_strerror := nil;
{$endif PRELOAD_ROUTINES }
end { TAsoundPcm.Create } ;


(************************************************************************** DCN *)


procedure TAsoundPcm.LoadVarargsRoutine(loadName: string= ''; keepGoing: boolean= false);


begin
  loadName := Trim(loadName);
  if loadName = '*' then
    loadName := '';
end { TAsoundPcm.LoadVarargsRoutine } ;


(************************************************************************** DLV *)


function TAsoundPcm.snd_pcm_open(pcm: PPsnd_pcm_t; Name: PChar; stream: snd_pcm_stream_t; mode: cint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_pcm_open), 'snd_pcm_open');
  result := Fsnd_pcm_open(pcm, Name, stream, mode)
end { TAsoundPcm.snd_pcm_open } ;


function TAsoundPcm.snd_pcm_set_params(pcm: Psnd_pcm_t; format: snd_pcm_format_t; access: snd_pcm_access_t; channels, rate: cuint; soft_resample: cint; latency: cuint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_pcm_set_params), 'snd_pcm_set_params');
  result := Fsnd_pcm_set_params(pcm, format, access, channels, rate, soft_resample, latency)
end { TAsoundPcm.snd_pcm_set_params } ;


function TAsoundPcm.snd_pcm_writei(pcm: Psnd_pcm_t; buffer: Pointer; size: snd_pcm_uframes_t): snd_pcm_sframes_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_pcm_writei), 'snd_pcm_writei');
  result := Fsnd_pcm_writei(pcm, buffer, size)
end { TAsoundPcm.snd_pcm_writei } ;


function TAsoundPcm.snd_pcm_recover(pcm: Psnd_pcm_t; err, silent: cint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_pcm_recover), 'snd_pcm_recover');
  result := Fsnd_pcm_recover(pcm, err, silent)
end { TAsoundPcm.snd_pcm_recover } ;


function TAsoundPcm.snd_pcm_drain(pcm: Psnd_pcm_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_pcm_drain), 'snd_pcm_drain');
  result := Fsnd_pcm_drain(pcm)
end { TAsoundPcm.snd_pcm_drain } ;


function TAsoundPcm.snd_pcm_close(pcm: Psnd_pcm_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_pcm_close), 'snd_pcm_close');
  result := Fsnd_pcm_close(pcm)
end { TAsoundPcm.snd_pcm_close } ;


function TAsoundPcm.snd_strerror(errnum: cint): PChar; cdecl;

begin
  LoadRoutine(pointer(Fsnd_strerror), 'snd_strerror');
  result := Fsnd_strerror(errnum)
end { TAsoundPcm.snd_strerror } ;

(*************************************************************************** DB *)


(* Return either a static or a dynamic representation of the Asound embedding
  library (libasound.so or similar). In this case it is dynamic.
*)
function AsoundPcm(): TAsoundPcm; inline;

begin
  if not Assigned(xAsoundPcm) then
    InitialiseLibrary;
  result := xAsoundPcm
end { AsoundPcm } ;


(* Create the object and optionally load the shared object library.
*)
procedure InitialiseLibrary(const moduleName: string= DefaultModuleName;
                                        earlyLoad: boolean= DefaultEarlyLoad);

begin
  if not Assigned(xAsoundPcm) then begin
    xAsoundPcm := TAsoundPcm.Create(moduleName);
    if Assigned(xAsoundPcm) and earlyLoad then
      xAsoundPcm.LoadModule            (* So that ModuleInMemory is correct     *)
  end
end { InitialiseLibrary } ;


(* Create the object and optionally load the shared object library.
*)
procedure InitializeLibrary(const moduleName: string= DefaultModuleName;
                                        earlyLoad: boolean= DefaultEarlyLoad);

begin
  InitialiseLibrary(moduleName, earlyLoad)
end { InitializeLibrary } ;


initialization
//  InitialiseLibrary
finalization
  FreeAndNil(xAsoundPcm)
end.
