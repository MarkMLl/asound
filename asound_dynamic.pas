unit Asound_dynamic;

(********************************************************************************)
(*                                                                              *)
(* WARNING: This is a machine-generated file and manual changes will be lost.   *)
(*                                                                              *)
(********************************************************************************)

{$mode objfpc}{$H+}
{$packrecords C}

(*
 * Please refer to AsoundDefs.inc and other accompanying files for
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
{$i AsoundDefs.inc }

{$undef CONSTS  }
{$define TYPES  }
{$undef PROCS   }
{$undef VPROCS  }
{$i AsoundDefs.inc }

(* These are the type descriptions of fields used to hold references to the     *)
(* methods listed in AsoundDefs.inc (below). It is important that these types  *)
(* be considered subordinate to the definitions in the include file, since as   *)
(* well as being used here the include file might potentially be treated by the *)
(* shared library as the authoritative list of what it is to export.            *)

type
  Tsnd_strerror= function(errnum: cint): PChar; cdecl;

type
  TAsound= class(TDynamicModule)
  strict private
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
    {$i AsoundDefs.inc }
    {$pop }
  end;

(* Return either a static or a dynamic representation of the Asound embedding
  library (libasound.so or similar). In this case it is dynamic.
*)
function Asound(): TAsound; inline;

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
  xAsound: TAsound= nil;


constructor TAsound.Create(const LoadName: string);

begin
  inherited Create(loadName);
{$ifdef PRELOAD_ROUTINES }
  Fsnd_strerror := Tsnd_strerror(LoadRoutine('snd_strerror'));
  LoadVarargsRoutine;
{$else                   }
  Fsnd_strerror := nil;
{$endif PRELOAD_ROUTINES }
end { TAsound.Create } ;


(************************************************************************** DCN *)


procedure TAsound.LoadVarargsRoutine(loadName: string= ''; keepGoing: boolean= false);


begin
  loadName := Trim(loadName);
  if loadName = '*' then
    loadName := '';
end { TAsound.LoadVarargsRoutine } ;


(************************************************************************** DLV *)


function TAsound.snd_strerror(errnum: cint): PChar; cdecl;

begin
  LoadRoutine(pointer(Fsnd_strerror), 'snd_strerror');
  result := Fsnd_strerror(errnum)
end { TAsound.snd_strerror } ;

(*************************************************************************** DB *)


(* Return either a static or a dynamic representation of the Asound embedding
  library (libasound.so or similar). In this case it is dynamic.
*)
function Asound(): TAsound; inline;

begin
  if not Assigned(xAsound) then
    InitialiseLibrary;
  result := xAsound
end { Asound } ;


(* Create the object and optionally load the shared object library.
*)
procedure InitialiseLibrary(const moduleName: string= DefaultModuleName;
                                        earlyLoad: boolean= DefaultEarlyLoad);

begin
  if not Assigned(xAsound) then begin
    xAsound := TAsound.Create(moduleName);
    if Assigned(xAsound) and earlyLoad then
      xAsound.LoadModule            (* So that ModuleInMemory is correct     *)
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
  FreeAndNil(xAsound)
end.
// MD5 079212c673918b0ff020353170f23a47 149da9002573b52acfd4489b6c37102f ANSI LF {}
