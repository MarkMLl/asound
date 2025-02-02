// unit THIS LINE IS NEEDED FOR THE LAZARUS IDE'S DECLARATION HINTING TO WORK.

(* Return either a static or a dynamic representation of the Asound embedding
  library (libasound.a or similar). In this case it is static.
*)
unit AsoundSeq;

(********************************************************************************)
(*                                                                              *)
(* WARNING: This is a machine-generated file and manual changes will be lost.   *)
(*                                                                              *)
(********************************************************************************)

(*
 * Please refer to AsoundSeqDefs.inc and other accompanying files for
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
{$i AsoundSeqDefs.inc }

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
{$i AsoundSeqDefs.inc }

{$undef EARLY   }
{$undef CONSTS  }
{$define TYPES  }
{$undef PROCS   }
{$undef VPROCS  }
{$i AsoundSeqDefs.inc }

{$undef EARLY   }
{$undef CONSTS  }
{$undef TYPES   }
{$define PROCS  }
{$define VPROCS }
{$i AsoundSeqDefs.inc }
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


(* Procedures and functions which are defined locally rather than being part of *)
(* the external library, and which in C would often be implemented as macros,   *)
(* are defined in this file to protect them from being overwritten.             *)

{$define CLSASOUND__:=  }
{$i AsoundSeq-macros.inc }


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
// MD5 9e8d79bcd988c51e0fcec3ea18bcec67 054338ba58bc653f39c48659ac36b505 ANSI LF {}
