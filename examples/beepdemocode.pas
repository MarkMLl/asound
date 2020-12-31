unit BeepDemoCode;

(* Demo GUI beep for Linux using ALSA.                          MarkMLl         *)

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TBeepDemoForm }

  TBeepDemoForm = class(TForm)
    ButtonAlsaSeqBeep: TButton;
    Button1X11Beep: TButton;
    ButtonStdoutBeep: TButton;
    ButtonAlsaPcmBeep: TButton;
    Label1: TLabel;
    procedure Button1X11BeepClick(Sender: TObject);
    procedure ButtonAlsaPcmBeepClick(Sender: TObject);
    procedure ButtonAlsaSeqBeepClick(Sender: TObject);
    procedure ButtonStdoutBeepClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  strict private
  public

  end;

var
  BeepDemoForm: TBeepDemoForm;

implementation

{$R *.lfm}

uses
  AlsaPcmDemo, AlsaSeqDemo, TermIO, xkblib, xlib;

{ TBeepDemoForm }


(* Whether this works is system-specific.
*)
procedure bellX11(strokes: integer= 1);

var
  dpy: PDisplay;

begin
  dpy := XOpenDisplay(nil);     (* Sensitive to "out of file descriptors" etc.  *)
  if dpy <> nil then
    try
      XSynchronize(dpy, 1); // If not used output is deferred until XCloseDisplay()
      while strokes > 0 do begin
        xkblib.XkbForceBell(dpy, 100);
        strokes -= 1
      end
    finally
      XCloseDisplay(dpy)
    end
end { bellX11 } ;


(* Beep under DOS on an IBM PS/2-77 is 900Hz 660mS but I've "rounded" this here
  to a standard note (octave above standard A).
*)
procedure TBeepDemoForm.ButtonAlsaPcmBeepClick(Sender: TObject);

begin
  BeepPcm(880, 660)
end;

procedure TBeepDemoForm.ButtonAlsaSeqBeepClick(Sender: TObject);

begin
  BeepSeq
end;


procedure TBeepDemoForm.Button1X11BeepClick(Sender: TObject);

begin
  bellX11
end;


procedure TBeepDemoForm.ButtonStdoutBeepClick(Sender: TObject);

begin
  Write(#$07)
end;


procedure TBeepDemoForm.FormCreate(Sender: TObject);

var
  ft: dword;

begin

// The OS-level handle of the Pascal-style Output device.

  Label1.Caption := 'StdOut: ' + IntToStr(TextRec(Output).Handle);

// In practice this is only good enough to detect whether the handle is an
// alias of /dev/null (ft would be zero).

// 0 if invoked from Dolphin, 1 from shell in Konsole, 1 from IDE,
// 0 IDE without debugging.

  ft := IsATty(Output);
  Label1.Caption := Label1.Caption + ' (TTY: ' + IntToStr(ft) + ')';

// I've not found a way of checking whether this binary is "close enough" to
// Konsole etc. that \a will be honoured. I suspect that the best I can do is
// see if its immediate parent is a known shell, since e.g. the Lazarus IDE
// propagates environment variables relating to XDG/D-Bus even if stdout has
// been intercepted (i.e. \a won't be passed to the shell hence to Konsole etc.).

end;


begin
  Assert(AlsaPcmDemo.IsDynamic() = AlsaSeqDemo.IsDynamic(), 'Internal error: mixing static and dynamic ALSA linkage')
end.

