(* Lazarus+FPC 2.0.0+3.0.4 on Linux Lazarus+FPC 2.0.0+3.0.4 on Linux Lazarus+FP *)

unit MidiSelectCode;

(* Select a MIDI synthesiser device.                            MarkMLl         *)

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TMidiSelectForm }

  TMidiSelectForm = class(TForm)
    ButtonOK: TButton;
    ButtonCancel: TButton;
    PanelBottom: TPanel;
    RadioGroup1: TRadioGroup;
  private

  public

    (* The parameter contains a list of MIDI devices. Either delete the ones we don't
      want to use (i.e. all but one) and their associated objects or leave them all
      intact.
    *)
    procedure Select(dl: TStringList);

  end;

var
  MidiSelectForm: TMidiSelectForm;

implementation

{$R *.lfm}


(* The parameter contains a list of MIDI devices. Either delete the ones we don't
  want to use (i.e. all but one) and their associated objects or leave them all
  intact.
*)
procedure TMidiSelectForm.Select(dl: TStringList);

var
  i: integer;

begin
  Left := (Application.MainForm.Left + Width DIV 2 + Screen.Width DIV 2) DIV 2;
  Top := (Application.MainForm.Top + Height DIV 2 + Screen.Height DIV 2) DIV 2;
  RadioGroup1.Items.Clear;
  for i := 0 to dl.Count - 1 do
    RadioGroup1.Items.Add(dl[i]);
  RadioGroup1.ItemIndex := 0;

(* Normally, if there is only a single item then there is no point in asking    *)
(* the user which one he wants. However allow it to be enabled (by commenting   *)
(* out the two lines below) for debugging, or if the operator has explicit      *)
(* instructions to select a MIDI device and verify that it is working.          *)

{  if RadioGroup1.Items.Count < 2 then
    exit;                     }
  case ShowModal of
    mrOk: for i := dl.Count - 1 downto 0 do
            if i <> RadioGroup1.itemIndex then begin
              if dl.Objects[i] <> nil then
                dl.Objects[i].free;
              dl.Delete(i)
            end
  otherwise

(* Special case: the user has not hit OK but there is only a single device.     *)
(* Delete it so that the caller doesn't think we mean "use this one".           *)

    if dl.Count = 1 then
      if dl.Objects[0] <> nil then
        dl.Objects[0].free;
      dl.Delete(0)
  end
end { TMidiSelectForm.Select } ;


end.

