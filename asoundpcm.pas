// unit THIS LINE IS NEEDED FOR THE LAZARUS IDE'S DECLARATION HINTING TO WORK.

(* Return either a static or a dynamic representation of the Asound embedding
  library (libasound.a or similar). In this case it is static.
*)
unit AsoundPcm;

(********************************************************************************)
(*                                                                              *)
(* WARNING: This is a machine-generated file and manual changes will be lost.   *)
(*                                                                              *)
(********************************************************************************)

(*
 * Please refer to AsoundPcmDefs.inc and other accompanying files for
 * licensing and disclaimer information.
 *)

{$mode ObjFPC }{$longstrings on }

{$push }
{$macro on }
{$define CDECL__:= cdecl; }
{$define CDECL_VARARGS__:= cdecl varargs; }
{$define LIBASOUND__:= external 'libasound'; }
{$define _LIBASOUND__:= asound }
{$undef DYNAMIC }

{$define EARLY  }
{$undef CONSTS  }
{$undef TYPES   }
{$undef PROCS   }
{$undef VPROCS  }
{$i AsoundPcmDefs.inc }

interface

uses
  Classes, SysUtils, UnixType;

const
  DefaultModuleName= 'libasound';
  DefaultEarlyLoad= true;
  HasLoadVarargsRoutine= true;          (* Presence is implementation-defined   *)

const

  (* The Asound libraries are statically linked, always return false.
  *)
  IsDynamic= false;

  (* The Asound libraries are statically linked, if the program has started
    successfully then they must be in memory.
  *)
  ModuleInMemory= true;

{$undef EARLY   }
{$define CONSTS }
{$undef TYPES   }
{$undef PROCS   }
{$undef VPROCS  }
{$i AsoundPcmDefs.inc }

{$undef EARLY   }
{$undef CONSTS  }
{$define TYPES  }
{$undef PROCS   }
{$undef VPROCS  }
{$i AsoundPcmDefs.inc }

{$undef EARLY   }
{$undef CONSTS  }
{$undef TYPES   }
{$define PROCS  }
{$define VPROCS }
{$i AsoundPcmDefs.inc }
{$pop }

(* For a statically-linked program this has no effect.
*)
procedure InitialiseLibrary(const moduleName: string= DefaultModuleName;
                                        earlyLoad: boolean= DefaultEarlyLoad);

(* For a statically-linked program this has no effect.
*)
procedure InitializeLibrary(const moduleName: string= DefaultModuleName;
                                        earlyLoad: boolean= DefaultEarlyLoad);

(* Load a named routine expecting a C-style variable number of parameters, or
  attempt to load all varargs routines if the parameter is * or blank. For a
  statically-linked program this has no effect.
*)
procedure LoadVarargsRoutine(loadName: string= '';
                                        keepGoing: boolean= false);

implementation

{$push } {$hints off   Suppress hints about parameters being unused }

(* For a statically-linked program this has no effect.
*)
procedure InitialiseLibrary(const moduleName: string= DefaultModuleName;
                                        earlyLoad: boolean= DefaultEarlyLoad);

begin
end { InitialiseLibrary } ;

{$pop }


(* For a statically-linked program this has no effect.
*)
procedure InitializeLibrary(const moduleName: string= DefaultModuleName;
                                        earlyLoad: boolean= DefaultEarlyLoad);

begin
  InitialiseLibrary(moduleName, earlyLoad)
end { InitializeLibrary } ;


(* Load a named routine expecting a C-style variable number of parameters, or
  attempt to load all varargs routines if the parameter is * or blank. For a
  statically-linked program this has no effect.
*)
procedure LoadVarargsRoutine(loadName: string= '';
                                        keepGoing: boolean= false);
begin
end { LoadVarargsRoutine } ;


end.
// MD5 8a3a909554b541a742b57df6e9c0cb01 5903670336c254f4a8de829a0716f518 ANSI LF {}
