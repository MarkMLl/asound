(* Lazarus+FPC 2.2.6+3.2.2 on Linux Lazarus+FPC 2.2.6+3.2.2 on Linux Lazarus+FP *)

program BeepDemo;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, BeepDemoCode, AlsaPcmDemo, AlsaSeqDemo, MidiSelectCode, WatchXyzMidi,
  MidiParse; // DO NOT import paired Asound, Asound_dynamic etc. here

(* Note the conditional compilation here specifically to support "old-style"    *)
(* resources etc. as used by a pre-v1 Lazarus typically with a pre-v2.4 FPC. In *)
(* practice that means FPC 2.2.4, since no attempt is made to support older     *)
(* versions due to their lack of the FPC_FULLVERSION predefined.                *)

{$if FPC_FULLVERSION >= 020400 }
  {$R *.res}
{$endif FPC_FULLVERSION        }

begin

(* Lazarus v1 (roughly corresponding to FPC 3.0) introduced this global         *)
(* variable, defaulting to false. It controls error reporting at startup if an  *)
(* expected .lfm is missing, so may be omitted if unsupported by the target LCL *)
(* etc. version e.g. by using the test $if LCL_FULLVERSION >= 1000000...$ifend. *)

{$if declared(RequireDerivedFormResource) }
  RequireDerivedFormResource:=True;
{$endif declared                          }

(* Lazarus v2 or later might insert  Application.Scaled := true  here if the    *)
(* project-level application settings include "Use LCL scaling". We probably    *)
(* don't want this since it might have the effect of messing up the pixel-level *)
(* operations we're trying to calibrate, and in any event will make this file   *)
(* incompatible with older versions if that's what's on the hardware in use. If *)
(* required guard using the test $if LCL_FULLVERSION >= 1080000...$ifend.       *)

  Application.Initialize;
  Application.CreateForm(TBeepDemoForm, BeepDemoForm);
  Application.CreateForm(TMidiSelectForm, MidiSelectForm);
  Application.Run;
end.

