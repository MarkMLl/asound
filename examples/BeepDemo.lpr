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
  MidiParse // DO NOT import Asound, Asound_dynamic etc. here
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TBeepDemoForm, BeepDemoForm);
  Application.CreateForm(TMidiSelectForm, MidiSelectForm);
  Application.Run;
end.

