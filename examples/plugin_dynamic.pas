unit plugin_dynamic;

(********************************************************************************)
(*                                                                              *)
(* WARNING: This is a machine-generated file and manual changes will be lost.   *)
(*                                                                              *)
(********************************************************************************)

{$mode objfpc}{$H+}
{$packrecords C}

(*
 * Please refer to plugin.inc and other accompanying files for
 * licensing and disclaimer information.
 *)

interface

uses
  Classes, SysUtils, AsoundSeq, DynamicModule;

const
  DefaultModuleName= 'libfilter_demo.so';
  DefaultEarlyLoad= true;
  HasLoadVarargsRoutine= true;          (* Presence is implementation-defined   *)

{$define DYNAMIC }
{$define CONSTS }
{$undef TYPES   }
{$undef PROCS   }
{$undef VPROCS  }
{$i plugin.inc }

{$undef CONSTS  }
{$define TYPES  }
{$undef PROCS   }
{$undef VPROCS  }
{$i plugin.inc }

(* These are the type descriptions of fields used to hold references to the     *)
(* methods listed in plugin.inc (below). It is important that these types  *)
(* be considered subordinate to the definitions in the include file, since as   *)
(* well as being used here the include file might potentially be treated by the *)
(* shared library as the authoritative list of what it is to export.            *)

type
  TMagicNumber= function(): longword; cdecl;
  TGetFilterVersion= function(preferredAPI: longword= 0): longword; cdecl;
  TGetFilterCompilationString= procedure(out fcs: FilterCompilationString); cdecl;
  TInitFilter= function(deviceCount: longword): boolean; cdecl;
  TApplyFilter= function(var event: snd_seq_event_t; out os: outputSet): integer; cdecl;

type
  Tplugin= class(TDynamicModule)
  strict private
    FMagicNumber: TMagicNumber;
    FGetFilterVersion: TGetFilterVersion;
    FGetFilterCompilationString: TGetFilterCompilationString;
    FInitFilter: TInitFilter;
    FApplyFilter: TApplyFilter;
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
    {$define PLUGIN__:= }
    {$i plugin.inc }
    {$pop }
  end;

(* Return either a static or a dynamic representation of the Filter_demo embedding
  library (libfilter_demo.so or similar). In this case it is dynamic.
*)
function plugin(): Tplugin; inline;

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
  xplugin: Tplugin= nil;


constructor Tplugin.Create(const LoadName: string);

begin
  inherited Create(loadName);
{$ifdef PRELOAD_ROUTINES }
  FMagicNumber := TMagicNumber(LoadRoutine('MagicNumber'));
  FGetFilterVersion := TGetFilterVersion(LoadRoutine('GetFilterVersion'));
  FGetFilterCompilationString := TGetFilterCompilationString(LoadRoutine('GetFilterCompilationString'));
  FInitFilter := TInitFilter(LoadRoutine('InitFilter'));
  FApplyFilter := TApplyFilter(LoadRoutine('ApplyFilter'));
  LoadVarargsRoutine;
{$else                   }
  FMagicNumber := nil;
  FGetFilterVersion := nil;
  FGetFilterCompilationString := nil;
  FInitFilter := nil;
  FApplyFilter := nil;
{$endif PRELOAD_ROUTINES }
end { Tplugin.Create } ;


(************************************************************************** DCN *)


procedure Tplugin.LoadVarargsRoutine(loadName: string= ''; keepGoing: boolean= false);


begin
  loadName := Trim(loadName);
  if loadName = '*' then
    loadName := '';
end { Tplugin.LoadVarargsRoutine } ;


(************************************************************************** DLV *)


function Tplugin.MagicNumber(): longword; cdecl;

begin
  LoadRoutine(pointer(FMagicNumber), 'MagicNumber');
  result := FMagicNumber()
end { Tplugin.MagicNumber } ;


function Tplugin.GetFilterVersion(preferredAPI: longword= 0): longword; cdecl;

begin
  LoadRoutine(pointer(FGetFilterVersion), 'GetFilterVersion');
  result := FGetFilterVersion(preferredAPI)
end { Tplugin.GetFilterVersion } ;


procedure Tplugin.GetFilterCompilationString(out fcs: FilterCompilationString); cdecl;

begin
  LoadRoutine(pointer(FGetFilterCompilationString), 'GetFilterCompilationString');
  FGetFilterCompilationString( fcs)
end { Tplugin.GetFilterCompilationString } ;


function Tplugin.InitFilter(deviceCount: longword): boolean; cdecl;

begin
  LoadRoutine(pointer(FInitFilter), 'InitFilter');
  result := FInitFilter(deviceCount)
end { Tplugin.InitFilter } ;


function Tplugin.ApplyFilter(var event: snd_seq_event_t; out os: outputSet): integer; cdecl;

begin
  LoadRoutine(pointer(FApplyFilter), 'ApplyFilter');
  result := FApplyFilter( event, os)
end { Tplugin.ApplyFilter } ;

(*************************************************************************** DB *)


(* Return either a static or a dynamic representation of the Filter_demo embedding
  library (libfilter_demo.so or similar). In this case it is dynamic.
*)
function plugin(): Tplugin; inline;

begin
  if not Assigned(xplugin) then
    InitialiseLibrary;
  result := xplugin
end { plugin } ;


(* Create the object and optionally load the shared object library.
*)
procedure InitialiseLibrary(const moduleName: string= DefaultModuleName;
                                        earlyLoad: boolean= DefaultEarlyLoad);

begin
  if not Assigned(xplugin) then begin
    xplugin := Tplugin.Create(moduleName);
    if Assigned(xplugin) and earlyLoad then
      xplugin.LoadModule            (* So that ModuleInMemory is correct     *)
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
  FreeAndNil(xplugin)
end.
