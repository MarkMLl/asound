(* Lazarus+FPC 2.2.6+3.2.2 on Linux Lazarus+FPC 2.2.6+3.2.2 on Linux Lazarus+FP *)

unit BeepDemoCode;

(* Demo GUI beep for Linux using ALSA.                          MarkMLl         *)

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TBeepDemoForm }

  TBeepDemoForm = class(TForm)
    ButtonStdoutIoctlBeep: TButton;
    ButtonDevTtyIoctlBeep: TButton;
    ButtonStdoutIoctlBell: TButton;
    ButtonDefaultBeep: TButton;
    ButtonStdoutBeep: TButton;
    ButtonDevTtyBeep: TButton;
    ButtonDevTtyIoctlBell: TButton;
    ButtonDevTtyBell: TButton;
    ButtonAlsaSeqNote: TButton;
    ButtonX11Bell: TButton;
    ButtonStdoutBell: TButton;
    ButtonAlsaPcmTone: TButton;
    Label1: TLabel;
    procedure ButtonDefaultBeepClick(Sender: TObject);
    procedure ButtonDevTtyBeepClick(Sender: TObject);
    procedure ButtonDevTtyIoctlBeepClick(Sender: TObject);
    procedure ButtonDevTtyIoctlBellClick(Sender: TObject);
    procedure ButtonStdoutBeepClick(Sender: TObject);
    procedure ButtonStdoutIoctlBeepClick(Sender: TObject);
    procedure ButtonStdoutIoctlBellClick(Sender: TObject);
    procedure ButtonX11BellClick(Sender: TObject);
    procedure ButtonAlsaPcmToneClick(Sender: TObject);
    procedure ButtonAlsaSeqNoteClick(Sender: TObject);
    procedure ButtonDevTtyBellClick(Sender: TObject);
    procedure ButtonStdoutBellClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  strict private
  public

  end;

var
  BeepDemoForm: TBeepDemoForm;

implementation

{$R *.lfm}

uses
  AlsaPcmDemo, AlsaSeqDemo, TermIO, xkblib, xlib, BaseUnix, Linux, Errors;


(* Whether this works is system-specific.
*)
procedure doBellX11(strokes: integer= 1);

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
end { doBellX11 } ;


(* Beep under DOS on an IBM PS/2-77 is 900Hz 660mS but I've "rounded" this here
  to a standard note (octave above standard A).
*)
procedure TBeepDemoForm.ButtonAlsaPcmToneClick(Sender: TObject);

begin
  BeepPcm(880, 660)
end;


(* Play a MIDI sequence representing a beep.
*)
procedure TBeepDemoForm.ButtonAlsaSeqNoteClick(Sender: TObject);

begin
  BeepSeq
end;


procedure TBeepDemoForm.ButtonX11BellClick(Sender: TObject);

begin
  doBellX11
end;


procedure doDevTtyBeep;

var
  devTty: Text;

begin
  AssignFile(devTty, '/dev/tty');
  Rewrite(devTty);
  Write(devTty, #$07);
  CloseFile(devTty)
end;


procedure doDevTtyIoctlBeep;

var
  res: cint;

const
  tone: word= Round(1190000 / 880);
  duration: word= 660;

var
  devTty: Text;

begin
  AssignFile(devTty, '/dev/tty');
  Rewrite(devTty);
//  res := fpIoctl(TextRec(devTty).Handle, KDMKTONE, pointer((duration << 16) + tone));
  res := fpIoctl(TextRec(devTty).Handle, KDMKTONE, pointer((tone << 16) + duration));

// Not sure of the correct order above, but in any event it requires a "typewriter".

  if res < 0 then begin
    res := errno;                       (* Visible to debugger                  *)
    WriteLn('Error ', res, ': ', StrError(res));
    Flush(Output)
  end;
  CloseFile(devTty)
end;


procedure doStdoutBeep;

begin
  Write(#$07)
end;


(* Beep under DOS on an IBM PS/2-77 is 900Hz 660mS but I've "rounded" this here
  to a standard note (octave above standard A).
*)
procedure doStdoutIoctlBeep;

const
  tone: word= Round(1190000 / 880);
  duration: word= 660;

var
  res: cint;

begin
//  res := fpIoctl(1 { TextRec(Output).Handle } , KDMKTONE, pointer((duration << 16) + tone))
  res := fpIoctl(1 { TextRec(Output).Handle } , KDMKTONE, pointer((tone << 16) + duration));

// Not sure of the correct order above, but in any event it requires a "typewriter".

  if res < 0 then begin
    res := errno;                       (* Visible to debugger                  *)
    WriteLn('Error ', res, ': ', StrError(res));
    Flush(Output)
  end
end;


(* Like the standard InterlockedExchange() functions, the read and write of the
  target parameter is indivisble but not that of the source parameter which has
  to be updated from the result.
*)
function InterlockedExchangeBH(var target: TBeepHandler; const source: TBeepHandler): TBeepHandler; inline;

begin
{$if sizeof(TBeepHandler) = 8 }
  result := TBeepHandler(InterlockedExchange64(PtrUInt(target), PtrUInt(source)))
{$else                        }
  result := TBeepHandler(InterlockedExchange(PtrUInt(target), PtrUInt(source)))
{$endif                       }
end;


{ TBeepDemoForm }


procedure TBeepDemoForm.ButtonDevTtyIoctlBellClick(Sender: TObject);

begin
  doDevTtyIoctlBeep
end;


procedure TBeepDemoForm.ButtonStdoutBeepClick(Sender: TObject);

var
  savedBeep: TBeepHandler = @doStdoutBeep;

begin
  savedBeep := InterlockedExchangeBH(OnBeep, savedBeep);
  Application.ProcessMessages;
  Beep();
  Application.ProcessMessages;
  InterlockedExchangeBH(OnBeep, savedBeep)
end;


procedure TBeepDemoForm.ButtonStdoutIoctlBeepClick(Sender: TObject);

var
  savedBeep: TBeepHandler= @doStdoutIoctlBeep;

begin
  savedBeep := InterlockedExchangeBH(OnBeep, savedBeep);
  Application.ProcessMessages;
  Beep();
  Application.ProcessMessages;
  InterlockedExchangeBH(OnBeep, savedBeep)
end;


procedure TBeepDemoForm.ButtonStdoutIoctlBellClick(Sender: TObject);

begin
  doStdoutIoctlBeep
end;


procedure TBeepDemoForm.ButtonDefaultBeepClick(Sender: TObject);

begin
  Beep()
end;


procedure TBeepDemoForm.ButtonDevTtyBeepClick(Sender: TObject);

var
  savedBeep: TBeepHandler= @doDevTtyBeep;

begin
  savedBeep := InterlockedExchangeBH(OnBeep, savedBeep);
  Application.ProcessMessages;
  Beep();
  Application.ProcessMessages;
  InterlockedExchangeBH(OnBeep, savedBeep)
end;


procedure TBeepDemoForm.ButtonDevTtyIoctlBeepClick(Sender: TObject);

var
  savedBeep: TBeepHandler= @doDevTtyIoctlBeep;

begin
  savedBeep := InterlockedExchangeBH(OnBeep, savedBeep);
  Application.ProcessMessages;
  Beep();
  Application.ProcessMessages;
  InterlockedExchangeBH(OnBeep, savedBeep)
end;


procedure TBeepDemoForm.ButtonDevTtyBellClick(Sender: TObject);

begin
  doDevTtyBeep
end;


procedure TBeepDemoForm.ButtonStdoutBellClick(Sender: TObject);

begin
  doStdoutBeep
end;


procedure TBeepDemoForm.FormCreate(Sender: TObject);

var
  ft: dword;

begin

// The OS-level handle of the Pascal-style Output device.

  Label1.Caption := 'StdOut: ' + IntToStr(TextRec(Output).Handle);

// In practice this is only good enough to detect whether the handle is an
// alias of /dev/null (ft would be zero). It is not good enough to determine
// whether it is a "typewriter": if not then the KDMKTONE ioctl() will fail.

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


end.

