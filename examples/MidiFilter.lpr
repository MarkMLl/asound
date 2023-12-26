(* Lazarus+FPC 2.2.6+3.2.2 on Linux Lazarus+FPC 2.2.6+3.2.2 on Linux Lazarus+FP *)

program MidiFilter;

(* This transfers control either directly to the ConsoleFilter unit, or via     *)
(* the usual mechanism if running as part of a GUI-based application.           *)
(*                                                              MarkMLl         *)

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Classes,
{$ifdef LCL }
  Interfaces, // this includes the LCL widgetset
  Forms,
{$endif LCL }
  midifiltercode, ConsoleFilter;

var
  devices: TStringList= nil;

{$ifdef LCL }
{$R *.res}
{$endif LCL }

begin
{$ifdef LCL }

(* Lazarus v1 (roughly corresponding to FPC 3.0) introduced this global         *)
(* variable, defaulting to false. It controls error reporting at startup if an  *)
(* expected .lfm is missing, so may be omitted if unsupported by the target LCL *)
(* etc. version.                                                                *)

{$if declared(RequireDerivedFormResource) }
  RequireDerivedFormResource:=True;
{$endif declared                          }

(* Lazarus v2 or later might insert  Application.Scaled := true  here if the    *)
(* project-level application settings include "Use LCL scaling". This will mess *)
(* up compatibility with older versions, generally speaking it may be omitted.  *)

  Application.Scaled:=True;
  Application.Initialize;
{$endif LCL }

(* If there is a parameter list and it either doesn't make sense or contains    *)
(* --help etc. then display help text.                                          *)

  if not ParseParams(PluginName, devices) then
    Halt(ShowHelp());

(* If the parameters parsed into a device list then treat as a non-GUI program. *)
(* Parameters which parse like nn:nn are device numbers, and a single parameter *)
(* which parses as a filename is assumed to be a filtering plugin applicable to *)
(* either a GUI or non-GUI program.                                             *)

  if devices <> nil then
    Halt(NonGui(PluginName, devices));
// TODO : GUI support, at present must have command line.
{$ifdef LCL }
  Application.CreateForm(TForm1, Form1);
  Application.Run;
{$endif LCL }
end.

