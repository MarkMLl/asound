unit Asound_dynamic;

(* This is a minimal ALSA interface derived from work by Andreas Stoeckel,      *)
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
  Classes, SysUtils, SyncObjs, CTypes;

type
  (* Contributed by kodekraft@cix (Martin Halliday), possibly derived from a NAG
    interface library. Minor reformatting and port to Lazarus MarkMLl.
  *)
  TDynamicModule= class
    (* The ALSA libraries are dynamically linked via a class, always return true
      even if an attempt to open them is expected to fail.
    *)
    class function IsDynamic(): boolean; inline;
  strict private
    FModuleHandle: THandle;
    FAlreadyInMemory: BOOLEAN;
    FModuleName: string;
    FLoadError: string;
    FLastError: string;
    (* Case-sensitivity depends on the operating system and filesystem.
    *)
    procedure SetModuleName(const Value: string);
    function GetModuleHandle(): THandle;
    procedure UnloadModule;
  public
    (* Case-sensitivity depends on the operating system and filesystem.
    *)
    constructor Create(const ModuleName: string);
    destructor Destroy; override;
    procedure LoadModule;
    (* Note that the name of the entry point is case-sensitive.
    *)
    procedure LoadRoutine(var Routine: Pointer; const Name: string);
    (* This is an overloaded addition to Martin's original code. It can result in
      neater code but is much less efficient since it can't check whether it has
      already been called.
    *)
    function LoadRoutine(const Name: string): Pointer;
    function ModuleExists(): Boolean;
    (* Note that the name of the entry point is case-sensitive.
    *)
    function RoutineExists(const Name: string): Boolean;
    property ModuleName: string read FModuleName write SetModuleName;
    property ModuleHandle: THandle read GetModuleHandle;
    property ModuleInMemory: boolean read FAlreadyInMemory;
    property LoadError: string read FLoadError;
    property LastError: string read FLastError;
  end;

  (* Relies on a preexisting TDynamicModule, and implements a group of library
    entry points.
  *)
  TAlsaSubsystem= class
  strict private
    FModule: TDynamicModule;
    FSubsystem: string;
    FLastError: string;
  public
    (* Case-sensitivity depends on the operating system and filesystem.
    *)
    constructor Create(module: TDynamicModule; const subsystem: string);
    procedure LoadRoutine(var Routine: Pointer; const Name: string);
    (* This is an overloaded addition to Martin's original code. It can result in
      neater code but is much less efficient since it can't check whether it has
      already been called.
    *)
    function LoadRoutine(const Name: string): Pointer;
    function RoutineExists(const Name: string): Boolean;
    property Subsystem: string read FSubsystem;
    property LastError: string read FLastError;
  end;

{$define CONSTS }
{$undef TYPES   }
{$undef PROCS   }
{$i AsoundDefs.inc }

{$undef CONSTS  }
{$define TYPES  }
{$undef PROCS   }
{$i AsoundDefs.inc }

(* These are the type descriptions of fields used to hold references to the     *)
(* methods listed in AsoundDefs.inc (below). It is important that these         *)
(* types be considered subordinate to the definitions in the include file,      *)
(* since as well as being used here the include file might potentially be       *)
(* treated by the shared library as the authoritative list of what it is to     *)
(* export.                                                                      *)

type
  Tsnd_strerror= function(errnum: cint): PChar; cdecl;

  TAsound= class(TDynamicModule)
  strict private
    FLock: TCriticalSection;
    Fsnd_strerror: Tsnd_strerror;
  public
    constructor Create();
    destructor Destroy; override;
    procedure Enter;
    procedure Leave;
    {$push }
    {$macro on}
    {$undef CONSTS }
    {$undef TYPES  }
    {$define PROCS }
    {$define LIBASOUND__:= }
    {$i AsoundDefs.inc }
    {$pop }
  end;

(* Return either a static or a dynamic representation of the ALSA interface
  library (libasound.so or similar). In this case it is dynamic.
*)
function Asound(): TAsound; inline;


implementation

uses
  DynLibs;

var
  xAsound: TAsound= nil;


type      DynamicModuleException= class(Exception);


(* The ALSA libraries are dynamically linked via a class, always return true
  even if an attempt to open them is expected to fail.
*)
class function TDynamicModule.IsDynamic(): boolean; inline;

begin
  IsDynamic := true
end { TDynamicModule.IsDynamic } ;


(* Case-sensitivity depends on the operating system and filesystem.
*)
procedure TDynamicModule.SetModuleName(const Value: string);

begin
  UnloadModule;
  FModuleName := Value
end { TDynamicModule.SetModuleName } ;


function TDynamicModule.GetModuleHandle(): THandle;

begin
  LoadModule;
  Result := FModuleHandle;
end { TDynamicModule.GetModuleHandle } ;


procedure TDynamicModule.UnloadModule;

begin
  if (FModuleHandle <> NilHandle) AND NOT FAlreadyInMemory then begin
    FreeLibrary(FModuleHandle);
    FLastError := GetLoadErrorStr
  end;
  FModuleHandle := NilHandle;
  FAlreadyInMemory:= FALSE
end { TDynamicModule.UnloadModule } ;


(* Case-sensitivity depends on the operating system and filesystem.
*)
constructor TDynamicModule.Create(const ModuleName: string);

begin
  inherited Create;
  FModuleHandle := NilHandle;           (* Be absolutely explicit about these   *)
  FAlreadyInMemory:= FALSE;             (* since used for presence testing.     *)
  FModuleName := ModuleName;
  FLoadError := '[Undefined or not implemented]';
  FLastError := FLoadError
end { TDynamicModule.Create } ;


destructor TDynamicModule.Destroy;

begin
  UnloadModule;
  inherited
end { TDynamicModule.Destroy } ;


procedure TDynamicModule.LoadModule;

var     revisedFilename: string;


  function readSecondLine(const name: string): string;

  var   txt: TEXT;

  begin
    Assign(txt, name);
    Reset(txt);
    repeat
      ReadLn(txt, result)
    until (Pos('GROUP ( ', result) = 1) or Eof(txt);
    Close(txt)
  end { readSecondLine } ;


begin
  if FModuleHandle = NilHandle then
  begin
    FModuleHandle:= LoadLibrary(FModuleName);
    FLoadError := GetLoadErrorStr;
    FLastError := FLoadError;
    FAlreadyInMemory:= FModuleHandle <> NilHandle;
    IF NOT FAlreadyInMemory THEN BEGIN
      FModuleHandle := LoadLibrary(FModuleName);
      FLoadError := GetLoadErrorStr;
      FLastError := FLoadError;
      if FModuleHandle = NilHandle then
{$IFDEF UNIX }
        if (GetLastOSError = 0) and (Pos(': invalid ELF header', LastError) > 0) then begin

(* I believe this is a Debian special: libusb-0.1 has been declared obsolete    *)
(* and "replaced by a linker script, in the hope it will make everybody happy." *)
(* The error message above might be subject to i18n, so users in non-English    *)
(* speaking locales might have at least as much grief as I've just had. Blame   *)
(* Aurelien Jarno :-)                                                           *)

          revisedFilename := LastError;
          SetLength(revisedFilename, Pos(':', revisedFilename) - 1);
          revisedFilename := readSecondLine(revisedFilename);
          if Pos('GROUP ( ', revisedFilename) = 1 then begin
            Delete(revisedFilename, 1, Length('GROUP ( '));
            SetLength(revisedFilename, Pos(' )', revisedFilename) - 1);
            FModuleName := revisedFilename;
            LoadModule;                 (* Recursive                            *)

(* Exits on success, otherwise raises the same exception as below.              *)

            exit
          end
        end;
{$ENDIF }
        raise DynamicModuleException.Create(SysErrorMessage(GetLastOSError)
                                        + ' loading ' + FModuleName);
    END
  end
end { TDynamicModule.LoadModule } ;


(* Note that the name of the entry point is case-sensitive.
*)
procedure TDynamicModule.LoadRoutine(var Routine: Pointer; const Name: string);


begin
  if Routine = nil then
  begin
{$if defined(CPUX86_64) }
    Assert(PtrUInt(@Routine) mod 8 = 0, 'Internal error: processor-specific stack misalignment for GetProcedureAddress(2) A');
    Assert(PtrUInt(@Name) mod 8 = 0, 'Internal error: processor-specific stack misalignment for GetProcedureAddress(2) B');
{$endif                 }
    Routine := GetProcedureAddress(ModuleHandle, Name);
    FLastError := GetLoadErrorStr;
    if Routine = nil then
      raise DynamicModuleException.Create(SysErrorMessage(GetLastOSError)
                                        + ' mapping function ' + Name)
  end
end { TDynamicModule.LoadRoutine } ;


(* This is an overloaded addition to Martin's original code. It can result in
  neater code but is much less efficient since it can't check whether it has
  already been called.
*)
function TDynamicModule.LoadRoutine(const Name: string): Pointer;

begin
{$if defined(CPUX86_64) }
  Assert(PtrUInt(@result) mod 8 = 0, 'Internal error: processor-specific stack misalignment for GetProcedureAddress(1) A');
  Assert(PtrUInt(@Name) mod 8 = 0, 'Internal error: processor-specific stack misalignment for GetProcedureAddress(1) B');
{$endif                 }
  RESULT:= GetProcedureAddress(ModuleHandle, Name);
  FLastError := GetLoadErrorStr;
  if RESULT = nil then
    raise DynamicModuleException.Create(SysErrorMessage(GetLastOSError)
                                        + ' mapping function ' + Name)
end { TDynamicModule.LoadRoutine } ;


function TDynamicModule.ModuleExists(): Boolean;

begin
  try
    Result := ModuleHandle <> NilHandle
  except
    Result := False
  end
end { TDynamicModule.ModuleExists } ;


(* Note that the name of the entry point is case-sensitive.
*)
function TDynamicModule.RoutineExists(const Name: string): Boolean;

var
  Routine: Pointer;
begin
  Routine:= NIL;                        (* We're looking to see if this changes *)
  try
    LoadRoutine(Routine, Name);
  except
    Routine := nil;
  end;
  FLastError := GetLoadErrorStr;
  Result := Routine <> nil;
end { TDynamicModule.RoutineExists } ;


(* Case-sensitivity depends on the operating system and filesystem.
*)
constructor TAlsaSubsystem.Create(module: TDynamicModule; const subsystem: string);

begin
  inherited Create;
  FModule := module;
  FSubsystem := subsystem;
  ASound.Enter;                         (* Protect LastError                    *)
  try
    try
      FModule.LoadModule
    except
    end;
    FLastError := FModule.LastError
  finally
    ASound.Leave
  end
end { TAlsaSubsystem.Create } ;


(* Note that the name of the entry point is case-sensitive.
*)
procedure TAlsaSubsystem.LoadRoutine(var Routine: Pointer; const Name: string);


begin
  if Routine <> nil then                (* Avoid uneccessary critical section   *)
    exit;
  ASound.Enter;                         (* Protect LastError                    *)
  try
    FModule.LoadRoutine(Routine, Name);
    FLastError := FModule.LastError
  finally
    ASound.Leave
  end
end { TAlsaSubsystem.LoadRoutine } ;


(* This is an overloaded addition to Martin's original code. It can result in
  neater code but is much less efficient since it can't check whether it has
  already been called.
*)
function TAlsaSubsystem.LoadRoutine(const Name: string): Pointer;

begin
  ASound.Enter;                         (* Protect LastError                    *)
  try
    result := FModule.LoadRoutine(Name);
    FLastError := FModule.LastError
  finally
    ASound.Leave
  end
end { TAlsaSubsystem.LoadRoutine } ;


(* Note that the name of the entry point is case-sensitive.
*)
function TAlsaSubsystem.RoutineExists(const Name: string): Boolean;

begin
  ASound.Enter;                         (* Protect LastError                    *)
  try
    result := FModule.RoutineExists(Name);
    FLastError := FModule.LastError
  finally
    ASound.Leave
  end
end { TAlsaSubsystem.RoutineExists } ;


constructor TAsound.Create();

begin
  inherited Create('libasound.so.2');
  if Assigned(xASound) then
    xASound.LoadModule;
  FLock := TCriticalSection.Create;
{$ifdef PRELOAD_ROUTINES }
  Fsnd_strerror := Tsnd_strerror(LoadRoutine('snd_strerror'))
{$else                   }
  Fsnd_strerror := nil
{$endif PRELOAD_ROUTINES }
end { TAsound.Create } ;


destructor TAsound.Destroy;

begin
  FreeAndNil(FLock);
  inherited
end { TAsound.Destroy } ;


procedure TAsound.Enter;

begin
  FLock.Enter
end { TAsound.Enter } ;


procedure TAsound.Leave;

begin
  FLock.Leave
end { TAsound.Leave } ;


function TAsound.snd_strerror(errnum: cint): PChar; cdecl;

begin
  try
    LoadRoutine(pointer(Fsnd_strerror), 'snd_strerror');
    result := Fsnd_strerror(errnum)
  except
    result := PChar('Dynamic asound library not loaded (' + LoadError + ')')
  end
end { TAsound.snd_strerror } ;


(* Return either a static or a dynamic representation of the ALSA interface
  library (libasound.so or similar). In this case it is dynamic.
*)
function Asound(): TAsound; inline;

begin
  Asound := xAsound
end { Asound } ;


(* During initialisation, create the object but do not attempt to load the      *)
(* library.                                                                     *)

initialization
  xAsound := TAsound.Create()
finalization
  FreeAndNil(xAsound)
end.

