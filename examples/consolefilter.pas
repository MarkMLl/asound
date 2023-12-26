(* Lazarus+FPC 2.2.6+3.2.2 on Linux Lazarus+FPC 2.2.6+3.2.2 on Linux Lazarus+FP *)

unit ConsoleFilter;

(* This is effectively the main code for the MidiFilter demo program. It is     *)
(* called directly if running in console mode, or abstracted if part of a GUI-  *)
(* based application program.                                   MarkMLl         *)

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

{$define ANNOUNCE }                     (* Limited progress messages to stdout  *)

(* Parse the command line. Expect an optional plugin name plus one or more
  Alsa MIDI (sequencer) device names, any other combination is treated as a
  request for a help message in which case false is returned. In all cases it's
  the caller's responsibility to free the device list.
*)
function ParseParams(var pluginName: string; var devices: TStringList): boolean;

(* Output a help message. Return zero if this is the result of an explicit
  --help etc. parameter, non-zero in other cases.
*)
function ShowHelp(): word;

(* Filter MIDI messages from a single input device to standard output and one
  or more output devices via an optional plugin. Return non-zero on error.
*)
function NonGui(const PluginName: string; const devices: TStringList): word;


implementation

{ define DYNAMIC }                      (* Change as required                   *)

uses
  StrUtils, BaseUnix, DynLibs, Plugin_dynamic
{$ifdef DYNAMIC }
                , AsoundSeq_dynamic
{$else          }
                , AsoundSeq
{$endif DYNAMIC }
;

var
  helpRequest: boolean= true;
{$if declared(Plugin_dynamic) }
  Plugin: TPlugin= nil;
{$endif                       }

(* The plugin is always loaded dynamically, although it will fall back to the   *)
(* minimal functionality in nullplugin.inc if not specified. For debugging      *)
(* purposes, it might be simpler to change the import from Plugin_dynamic (with *)
(* the symbol "Plugin" referring to an instance of class TPlugin) to Plugin     *)
(* (i.e. referring directly to the unit of that name).                          *)

{$I nullplugin.inc }

(* Parse the command line. Expect an optional plugin name plus one or more
  Alsa MIDI (sequencer) device names, any other combination is treated as a
  request for a help message in which case false is returned. In all cases it's
  the caller's responsibility to free the device list.
*)
function ParseParams(var pluginName: string; var devices: TStringList): boolean;

var
  i: integer;


  (* Return true if the parameter matches the client:port pattern.
  *)
  function isClientPort(const p: string): boolean;

  var
    client, port: string;
    n: integer;

  begin
    if Pos(':', p) < 1 then
      exit(false);
    client := ExtractDelimited(1, p, [':']);
    port := ExtractDelimited(2, p, [':']);
    result := TryStrToInt(client, n) and TryStrToInt(port, n)
  end { isClientPort } ;


begin
  result := true;

(* Look for an explicit help request. In this case, other parameters are        *)
(* discarded.                                                                   *)

  for i := 1 to ParamCount() do begin
    if Pos('-h', LowerCase(ParamStr(i))) in [1, 2] then
      exit(false);
    if LowerCase(ParamStr(i)) = '/h' then
      exit(false)
  end;
  helpRequest := false;

(* For each parameter, expect either a plugin name (which may only occur once)  *)
(* or a client:port number.                                                     *)

(* This originally assumed multiple input devices plus a single output device   *)
(* (for reasons discussed below), but I have redone it for a single input and   *)
(* multiple output devices after RTFMing and considering what was likely to be  *)
(* most useful.                                                                 *)
(*                                                                              *)
(* Apropos being able to use multiple input devices. I've got an M-Audio        *)
(* Keystation Pro 88 here, which is presented by ALSA as two ports on the same  *)
(* client. I was initially uncertain about the significance of this thinking it *)
(* might represent a keyboard split or that notes and controls appeared on      *)
(* different ports, until finding this in the Advanced Guide:                   *)
(*                                                                              *)
(* "The MIDI In port can be used to interface another MIDI device with your     *)
(* computer via the USB port. Data received from the MIDI In will be            *)
(* transmitted via the Keystation Pro 88 to the computer.                       *)
(*                                                                              *)
(* "When you select the MIDI devices section of your MIDI host, you will see    *)
(* two Keystation Pro 88 USB MIDI Inputs. The first MIDI input in your MIDI     *)
(* host is used to receive the Keystation Pro 88 controller data. The second    *)
(* MIDI input in your MIDI host is used to receive data from MIDI devices       *)
(* connected to the Keystation Pro 88's MIDI In plug. In this way, the          *)
(* Keystation Pro 88 acts as a MIDI-to-USB interface for the other MIDI         *)
(* device."                                                                     *)
(*                                                                              *)
(* In addition, I was hoping that the Bristol/Brighton software synthesisers    *)
(* were controllable via MIDI, but it turns out that their MIDI handling is     *)
(* limited (key and pitchbend/modulation wheels only) and that at best the      *)
(* underlying synthesiser engine can be controlled using TCP/IP.                *)
(*                                                                              *)
(* On the balance, that leaves the most useful situation for a demo program     *)
(* such as this as (a) being able to monitor keys and controllers from a single *)
(* input device, (b) being able to direct events to one or more output devices, *)
(* and (c) having a plugin architecture which is able to- for example- send     *)
(* suitable control messages over TCP/IP to the Bristol synthesiser engine.     *)

  for i := 1 to ParamCount() do
    if (ParamStr(i) = '-') {$ifndef LCL } or (ParamStr(i) = '--') {$endif } then
      continue
    else
      if isClientPort(ParamStr(i)) then begin
        if not Assigned(devices) then
          devices := TStringList.Create;
        devices.Append(ParamStr(i))
      end else
        if pluginName = '' then
          pluginName := ParamStr(i)
        else
          exit(false)
end { ParseParams } ;


(* Output a help message. Return zero if this is the result of an explicit
  --help etc. parameter, non-zero in other cases.
*)
function ShowHelp(): word;

var
  outputTo: Text;

begin
  if helpRequest then begin
    result := 0;
    outputTo := StdOut
  end else begin
    result := 1;
    outputTo := StdErr
  end;
  WriteLn(outputTo);

// Below: plugin temporarily not documented hence the braces. As is conventional,
// brackets indicate an optional parameter.

  WriteLn(outputTo, 'Usage: MidiFilter ', { '[PLUGIN] ', } 'DEVICE [DEVICE...]');
  WriteLn(outputTo);
  WriteLn(outputTo, 'Filter MIDI events from an input device to zero or more output devices.');
  WriteLn(outputTo);
{  WriteLn(outputTo, 'PLUGIN is the name of a filter implemented as a dynamically-loaded library.');
  WriteLn(outputTo); }
//TODO : Plugin support.
  WriteLn(outputTo, 'DEVICE is formatted as client:port, refer to ALSA''s aconnect utility.');
  WriteLn(outputTo);
{$ifdef LCL }
  WriteLn(outputTo, 'If there is no explicit option or device an interactive GUI screen will');
  WriteLn(outputTo, 'be presented. Supported options are as below:');
{$else      }
  WriteLn(outputTo, 'Supported options are as below:');
{$endif LCL }
  WriteLn(outputTo);
  WriteLn(outputTo, '  --help         This help text, also reports default device.');
  WriteLn(outputTo);
{$ifdef LCL }
  WriteLn(outputTo, '  -              Dummy option, ignored.');
{$else      }
  WriteLn(outputTo, '  - --           Dummy options, ignored.');
{$endif LCL }
  WriteLn(outputTo);
  WriteLn(outputTo, 'Exit status:');
  WriteLn(outputTo);
  WriteLn(outputTo, ' 0  Normal termination');
  WriteLn(outputTo, ' 1  Cannot parse device command line');
  WriteLn(outputTo)
end { ShowHelp } ;


(********************************************************************************)
(*                                                                              *)
(* Main program.                                                                *)
(*                                                                              *)
(********************************************************************************)

var
  pleaseTerminate: boolean= false;
  pleaseReload: boolean= false;


(* We don't ever want to screw the MCP by responding to a casual ^C. We do,
  however, want to do our best to shut down in good order if we get an urgent
  signal such as SIGTERM, since it might indicate an incipient power failure.
*)
procedure termHandler(sig: longint; info: PSigInfo; context: PSigContext); cdecl;

begin
  case sig of
    SIGINT,
    SIGQUIT,
    SIGTERM:  if not pleaseTerminate then
                pleaseTerminate := true
              else
                fpKill(fpGetpid, SIGKILL);
    SIGHUP:   pleaseReload := true
  otherwise
  end
end { termHandler } ;


type
  tDevice= class(TObject)
             fClient, fPort: integer;
             constructor Create(device: string);
             property client: integer read fClient;
             property port: integer read fPort;
           end;


constructor tDevice.Create(device: string);

begin
  inherited Create;
  fClient := StrToInt(ExtractDelimited(1, device, [':']));
  fPort := StrToInt(ExtractDelimited(2, device, [':']))
end { tDevice.Create } ;


(* Filter MIDI messages from a single input device to standard output and one
  or more output devices via an optional plugin. Return non-zero on error.
*)
function NonGui(const PluginName: string; const devices: TStringList): word;

var
  outputDevices: TStringList;
  seq: Psnd_seq_t;
  i, status, appClient: integer;


  (* We don't ever want to bomb on getting ^C (SIGINT) or SIGTERM, since this
    will leave an active subscription.
  *)
  procedure catchsignals;

  var     action: SigActionRec;

  begin
    FillChar(action, SizeOf(action), 0);
    action.Sa_Handler := @termHandler;
    action.Sa_Flags := SA_SIGINFO;
    if fpSigAction(SIGINT, @action, nil) <> 0 then
      WriteLn(stderr, 'Warning: ^C (SIGINT) not hooked, error ', fpGetErrNo, '.');
    if fpSigAction(SIGQUIT, @action, nil) <> 0 then
      WriteLn(stderr, 'Warning: SIGQUIT not hooked, error ', fpGetErrNo, '.');
    if fpSigAction(SIGTERM, @action, nil) <> 0 then
      WriteLn(stderr, 'Warning: SIGTERM not hooked, error ', fpGetErrNo, '.');
    if fpSigAction(SIGHUP, @action, nil) <> 0 then
      WriteLn(stderr, 'Warning: SIGHUP not hooked, error ', fpGetErrNo, '.')
  end { catchSignals } ;


  function client(index: integer): integer;

  begin
    result := tDevice(outputDevices.Objects[index]).Client
  end { client } ;


  function port(index: integer): integer;

  begin
    result := tDevice(outputDevices.Objects[index]).port
  end { port } ;


  function reloadAndCheck(): boolean;

  begin
    result := true;
{$if declared(Plugin_dynamic) }
    if Assigned(plugin) then
      plugin.InitFilter(0)
    else
{$endif                       }
      ConsoleFilter.InitFilter(0);
{$if declared(Plugin_dynamic) }
    if Assigned(plugin) then begin
      plugin.Free;
      plugin := nil
{ TODO : Remove .so file from FAM list. }
    end;
    if pluginName <> '' then begin
      plugin := TPlugin.Create(PluginName);
      result := Assigned(plugin);
      if not result then
        WriteLn(stderr, 'Unable to load filter plugin "', PluginName, '", ', TPlugin.GetLoadErrorStr())
      else begin
        result := plugin.MagicNumber() = PluginMagicNumber;
        if not result then
          WriteLn(stderr, 'Plugin magic number is ', plugin.MagicNumber(),
                                        ', expecting ', PluginMagicNumber)
{ TODO : More negotiation using GetFilterVersion() and GetFilterCompilationString(). }
      end
{ TODO : If successful, add .so file to FAM list. }
    end;
{$endif                       }
{$if declared(Plugin_dynamic) }
    if Assigned(plugin) then
      result := result and plugin.InitFilter(outputDevices.Count)
    else
{$endif                       }
      result := ConsoleFilter.InitFilter(outputDevices.Count)
  end { reloadAndCheck } ;


  procedure dumpEvent(const ev: snd_seq_event_t; os: outputSet);

  const
//    arrow= '->';
    arrow= '→';

  var
    scratch: string;
    i: integer;

  begin
    Write(ev.source.client, ':', ev.source.port, arrow);
    Str(snd_seq_event_type(ev.type_), scratch);
    if Pos('SND_SEQ_EVENT_', scratch) = 1 then
      Delete(scratch, 1, Length('SND_SEQ_EVENT_'));
    Write(scratch:12, ' ');
    case snd_seq_event_type(ev.type_) of
      SND_SEQ_EVENT_NOTE,
      SND_SEQ_EVENT_NOTEON,
      SND_SEQ_EVENT_NOTEOFF,
      SND_SEQ_EVENT_KEYPRESS:  with ev.data.note do begin
                                 Write(channel, ' ', note, ' ', velocity);
                                 if snd_seq_event_type(ev.type_) = SND_SEQ_EVENT_NOTE then
                                   Write(' ', off_velocity, ' ', duration)
                               end;
      SND_SEQ_EVENT_CONTROLLER,
      SND_SEQ_EVENT_PITCHBEND,
      SND_SEQ_EVENT_PGMCHANGE: with ev.data.control do
                                 Write(channel, ' ', param, ' ', value)
    otherwise
    end;
    Write(' ', arrow);
    for i := 1 to devices.Count - 1 do
      if i in os then
        Write(client(i), ':', port(i), ' ');
    WriteLn
  end { dumpEvent } ;


  (* return zero on normal termination.
  *)
  function mainLoop(): integer;

  var
    usePlugin: boolean= false;
    pev: Psnd_seq_event_t;
    os: outputSet;
    count, i: integer;

  begin
    result := 0;
{$if declared(Plugin_dynamic) }
    usePlugin := Assigned(plugin);
{$endif                       }
    repeat

  (* Repeat for every available input event.                                    *)

      while AsoundSeq.snd_seq_event_input(seq, @pev) >= 0 do begin
        if usePlugin then
          count := Plugin.ApplyFilter(pev^, os)
        else
          count := ConsoleFilter.ApplyFilter(pev^, os);

  (* Repeat for as many events as ApplyFilter() deigns to return.               *)

        while count > 0 do begin

  (* Send to each indicated output.                                             *)

          for i := 0 to devices.Count - 1 do
            if i in os then

  (* Index 0 is special, representing stdout.                                   *)

              if i = 0 then
                dumpEvent(pev^, os)
              else begin
                snd_seq_ev_set_dest(pev, client(i), port(i));
                AsoundSeq.snd_seq_event_output(seq, pev)
              end;

  (* If this is the only or final event then flush, otherwise ask for more.     *)

          if count = 1 then begin
            AsoundSeq.snd_seq_drain_output(seq);
            count := 0                  (* This is effectively a decrement      *)
          end else
            if usePlugin then
              count := Plugin.ApplyFilter(pev^, os) (* Effectively a decrement *)
            else
              count := ConsoleFilter.ApplyFilter(pev^, os) (* Effectively a decrement *)

{ #todo :  There's a risk that event reuse will result in a double-free (or worse). }
// Basically, I don't know whether a received event results in a malloc() with a
// free() when it is transmitted, or if at all times it is in an internal pool
// hence could be overwritten while we think we are able to use it.

        end;
        Sleep(0)
      end;

  (* Assume that even if there are no note events there will be timing ticks    *)
  (* etc., which result in our checking signals fairly regularly.               *)

      if pleaseTerminate or pleaseReload then
        exit
{ TODO : Poll FAM list. }
    until false
  end { mainLoop } ;


begin
  result := 0;
  Assert(Assigned(devices), 'No device names.');
  if devices.Count < 1 then begin
    WriteLn(StdErr, 'At least one device name must be specified.');
    exit(1)
  end;
{$ifdef ANNOUNCE }
  Write(stderr, 'Opening ALSA sequencer... ');
{$endif ANNOUNCE }
  status := AsoundSeq.snd_seq_open(@seq, 'default', SND_SEQ_OPEN_DUPLEX, 0);
  if status < 0 then begin
    WriteLn(stderr, 'Unable to open ALSA sequencer: ', AsoundSeq.snd_strError(status), '.');
    exit(2)                             (* Via stringlist free in finally block *)
  end else
{$ifdef ANNOUNCE }
    WriteLn(stderr, 'OK')
{$endif ANNOUNCE } ;
  try
{$ifdef ANNOUNCE }
    Write(stderr, 'Getting ALSA client (application) ID... ');
{$endif ANNOUNCE }
    appClient := AsoundSeq.snd_seq_client_id(seq);
    if appClient < 0 then begin
      WriteLn(stderr, 'Unable to get ALSA client (application) ID: ', AsoundSeq.snd_strError(appClient), '.');
      exit(2)                           (* Via snd_seq_close() in finally block *)
    end else
{$ifdef ANNOUNCE }
      WriteLn(stderr, 'OK')
{$endif ANNOUNCE } ;
{$ifdef ANNOUNCE }
    Write(stderr, 'Setting ALSA client name... ');
{$endif ANNOUNCE }
    status := AsoundSeq.snd_seq_set_client_name(seq, 'MidiFilter Demo');
    if status < 0 then begin
      WriteLn(stderr, 'Unable to set ALSA client name: ', AsoundSeq.snd_strError(status), '.');
      exit(2)                           (* Via snd_seq_close() in finally block *)
    end else
{$ifdef ANNOUNCE }
      WriteLn(stderr, 'OK')
{$endif ANNOUNCE } ;
{$ifdef ANNOUNCE }
    Write(stderr, 'Creating ALSA port... ');
{$endif ANNOUNCE }
    status := AsoundSeq.snd_seq_create_simple_port(seq, 'MidiFilter Demo 0',
                                        SND_SEQ_PORT_CAP_READ or
                                        SND_SEQ_PORT_CAP_SUBS_READ or
                                        SND_SEQ_PORT_CAP_WRITE or
                                        SND_SEQ_PORT_CAP_SUBS_WRITE,
                                        SND_SEQ_PORT_TYPE_MIDI_GENERIC or
                                        SND_SEQ_PORT_TYPE_APPLICATION);
    if status < 0 then begin
      WriteLn(stderr, 'Unable to create ALSA port: ', AsoundSeq.snd_strError(status), '.');
      exit(2)                           (* Via snd_seq_close() in finally block *)
    end else
{$ifdef ANNOUNCE }
      WriteLn(stderr, 'OK')
{$endif ANNOUNCE } ;

(* The client and port should now be visible to e.g. aconnect -l. The first     *)
(* device (i.e. index zero) is an input.                                        *)

    outputDevices := TStringList.Create;
    try
      outputDevices.OwnsObjects := true;
      outputDevices.Append(devices[0]);
      Assert(outputDevices.Count = 1, 'Internal error: impossible count (1)');
      outputDevices.Objects[0] := tDevice.Create(devices[0]);
{$ifdef ANNOUNCE }
      Write(stderr, 'Connecting to ALSA input device ', client(0), ':', port(0), '... ');
{$endif ANNOUNCE }
      status := AsoundSeq.snd_seq_connect_from(seq, 0, client(0), port(0));
      if status < 0 then begin
        WriteLn(stderr, 'Unable to connect to ALSA input device ', devices[0], ': ',
                                        AsoundSeq.snd_strError(status), '.');
        exit(2)                         (* Via snd_seq_close() in finally block *)
      end else
{$ifdef ANNOUNCE }
        WriteLn(stderr, 'OK')
{$endif ANNOUNCE } ;

(* Subsequent devices are outputs.                                              *)

      for i := 1 to devices.Count - 1 do begin
        outputDevices.Append(devices[i]);
        Assert(outputDevices.Count = i + 1, 'Internal error: impossible count (2)');
        outputDevices.Objects[i] := tDevice.Create(devices[i]);
{$ifdef ANNOUNCE }
        Write(stderr, 'Connecting to ALSA output device ', client(i), ':', port(i), '... ');
{$endif ANNOUNCE }
        status := AsoundSeq.snd_seq_connect_to(seq, 0, client(i), port(i));
        if status < 0 then begin
          WriteLn(stderr, 'Unable to connect to ALSA output device ', devices[i], ': ',
                                        AsoundSeq.snd_strError(status), '.');
          exit(2)                       (* Via snd_seq_close() in finally block *)
        end else
{$ifdef ANNOUNCE }
          WriteLn(stderr, 'OK')
{$endif ANNOUNCE }
      end;

(* outputDevices[0] was initialised from the input device, but will actually be *)
(* used to represent stdout without checking its content. The result of this is *)
(* that outputDevices.Count represents the number of output devices including   *)
(* stdout.                                                                      *)

(* Load a plugin if required.                                                   *) // TBD

{$ifdef ANNOUNCE }
      Write(stderr, 'Loading filter plugin... ');
{$endif ANNOUNCE }
      if not reloadAndCheck() then begin
        WriteLn(stderr, 'Unable to load filtering plugin.');
        exit(9)                         (* Via finally blocks                   *)
      end else
{$ifdef ANNOUNCE }
        WriteLn(stderr, 'OK')
{$endif ANNOUNCE } ;

(* Loop processing events, monitoring termination and plugin-reload flags.      *)

      catchSignals;
      repeat
{$ifdef ANNOUNCE }
        WriteLn(stderr, 'Running main loop.');
{$endif ANNOUNCE }
        status := mainLoop();
        if (status <> 0) or pleaseTerminate then begin
{$ifdef ANNOUNCE }
          Write(stderr, 'Received termination signal. ');
{$endif ANNOUNCE }
          exit(status)                  (* Via finally blocks                   *)
        end;
        if pleaseReload then begin
{$ifdef ANNOUNCE }
          Write(stderr, 'Received reload signal. ');
{$endif ANNOUNCE }
{$ifdef ANNOUNCE }
          Write(stderr, 'Reloading filter plugin... ');
{$endif ANNOUNCE }
          if reloadAndCheck() then begin
{$ifdef ANNOUNCE }
            WriteLn(stderr, 'OK')
{$endif ANNOUNCE } ;
            pleaseReload := false
          end else begin
            WriteLn(stderr, 'Unable to reload filtering plugin.');
            exit(9)                     (* Via finally blocks                   *)
          end
        end
      until false
    finally
      FreeAndNil(outputDevices)
    end
  finally
{$ifdef ANNOUNCE }
    Write(stderr, 'Closing ALSA sequencer... ');
{$endif ANNOUNCE }
    AsoundSeq.snd_seq_close(seq);
{$ifdef ANNOUNCE }
    WriteLn(stderr, 'OK')
{$endif ANNOUNCE } ;
  end
end { NonGui } ;


end.

