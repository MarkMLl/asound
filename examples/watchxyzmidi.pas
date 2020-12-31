(* Lazarus+FPC 2.0.0+3.0.4 on Linux Lazarus+FPC 2.0.0+3.0.4 on Linux Lazarus+FP *)

unit WatchXyzMidi;

(* Translate a human-readable note etc. string and send it to a MIDI device     *)
(* using ALSA.                                                  MarkMLl         *)

(********************************************************************************)
(*                                                                              *)
(* I make no claim that this is good code, or is the best (or even a "right")   *)
(* way of doing things. Also the format I'm using to represent MIDI sequences   *)
(* (see examples in MidiParse unit) is idiosyncratic... the whole thing was     *)
(* coded for Windows in around 2000 and haphazardly ported to ALSA on Linux 20  *)
(* years later.                                                                 *)
(*                                                                              *)
(********************************************************************************)

{$mode objfpc}{$H+}

interface

{$define DYNAMIC }

uses
  Classes, SysUtils, SyncObjs,
{$ifdef DYNAMIC }
                        AsoundSeq_dynamic
{$else          }
                        AsoundSeq
{$endif DYNAMIC }
;

type
  TSelectedDevice= class
                     client: integer;
                     destination: snd_seq_addr_t;
                     capabilities, portType: dword;
                     clientName, portName: string;
                   end;

  TMidiWriterThread= class(TThread)
    strict private
      fLock: TCriticalSection;
      fEvent: TSimpleEvent;
      fDetentCount: integer;
      fQueue, fDeviceList: TStringList;
      fWarning: string;
      selectedDevice: TSelectedDevice;
      seqHandle: Psnd_seq_t;
      seqQueue: longint;

      (* Tell the GUI thread to display a warning dialogue. This contains duplicated
        code rather than using the main form's MessageDlgOpt() to avoid having to
        import that unit, its simplicity doesn't justify something which is
        technically a circular reference.
      *)
      procedure shimWarning;

      (* Display a warning dialogue.
      *)
      procedure warning(const msg: string);

      (* This is used during initialisation and potentially if the population of
        MIDI output devices is seen to have changed. The deviceList is populated
        and passed to the GUI process, which should remove all devices except the
        one to be used.
      *)
      procedure shimSelectDevice;

      (* Mark the thread as not-running pending another Spin(). This is called by the
        thread itself, which means that there is no issue of latency between calling
        it and the thread pausing.
      *)
      procedure detent;

      (* Allow the GUI thread to determine whether the background thread has
        done what was asked of it.
      *)
      function getDetented(): boolean;

    protected

      (* Mark the thread as ready to run and return true. If true is not returned
        then the correct response is to pause briefly and retry.
      *)
      function Spin(): boolean;

      (* When a MIDI sequence has been made available collect, translate, and pass
        it to the ALSA subsystem. Output a generic beep if ALSA is unavailable (i.e.
        broken rather than busy).
      *)
      procedure Execute; override;

      (* Remove one note etc. from the front of the string and convert it into a MIDI
        event for the synthesiser device associated with the sequencer handle. This
        was originally PlayMidi() etc. in UtilXyz.
      *)
      function ParseMidiAndEmit(var txt: string): boolean;
    public
      constructor Create(createSuspended: boolean);
      destructor Destroy; override;

    (* Enqueue a MIDI sequence to be played ASAP, but respecting any current
      activity.
    *)
    procedure Enqueue(const midi: string);
  end;

(* Is the underlying ALSA library linked statically or dynamically?
*)

function IsDynamic(): boolean;


implementation

(* Originally compiled against Alsapas-1.0.27.1_RC with the NO_LIBC define in   *)
(* project options. This will probably need the alsa_version.sh script run at   *)
(* development time (requires Bash) to tell the Pascal shim what version        *)
(* library the distro has provided.                                             *)
(*                                                                              *)
(* Now compiled against my own library derived from fpalsa and tested with both *)
(* static and dynamic linkage.                                                  *)

uses Forms, Dialogs, MidiSelectCode, MidiParse;

const
  clientName= 'WatchXyz';


(* Tell the GUI thread to display a warning dialogue. This contains duplicated
  code rather than using the main form's MessageDlgOpt() to avoid having to
  import that unit, its simplicity doesn't justify something which is
  technically a circular reference.
*)
procedure TMidiWriterThread.shimWarning;

var
  x, y: integer;

begin
  with Application.MainForm do begin
    x := Left + Width div 2;
    y := top + height div 2
  end;
  x:= (x + Screen.Width DIV 2) DIV 2;
  y:= (y + Screen.Height DIV 2) DIV 2;
  MessageDlgPos(fWarning, mtWarning, [mbOk], 0, x, y)
end { TMidiWriterThread.shimWarning } ;


(* Display a warning dialogue.
*)
procedure TMidiWriterThread.warning(const msg: string);

begin
  fWarning := msg;
  Synchronize(@shimWarning)
end { TMidiWriterThread.warning } ;


(* This is used during initialisation and potentially if the population of
  MIDI output devices is seen to have changed. The deviceList is populated
  and passed to the GUI process, which should remove all devices except the
  one to be used.
*)
procedure TMidiWriterThread.shimSelectDevice;

begin
  MidiSelectForm.Select(fDeviceList)
end { TMidiWriterThread.shimSelectDevice } ;


(* Mark the thread as not-running pending another Spin(). This is called by the
  thread itself, which means that there is no issue of latency between calling
  it and the thread pausing.
*)
procedure TMidiWriterThread.detent;

begin
  Assert(GetCurrentThreadID <> MainThreadID, 'Internal error: called detent() in GUI thread');
  Assert(fDetentCount = 0, 'Internal error: worker thread nested detent()');

// Do I need a lock here? If I do use a different one, this is falling over
// Enqueue() etc.

//  fLock.Enter;
  try
    InterlockedIncrement(fDetentCount);
    fEvent.WaitFor(INFINITE);
    fEvent.ResetEvent;
    InterlockedDecrement(fDetentCount)
  finally
//    fLock.Leave;
    Assert(fDetentCount >= 0, 'Internal error: worker thread detent count gone -ve')
  end
end { TMidiWriterThread.detent } ;


(* Allow the GUI thread to determine whether the background thread has
  done what was asked of it.
*)
function TMidiWriterThread.getDetented(): boolean;

begin
  Assert((fDetentCount = 0) or (fDetentCount = 1), 'Internal error: worker thread unexpected spin/detent state');
  result := fDetentCount > 0
end { TMidiWriterThread.getDetented } ;


(* Mark the thread as ready to run and return true. If true is not returned
  then the correct response is to pause briefly and retry.
*)
function TMidiWriterThread.Spin(): boolean;

begin
  Assert(GetCurrentThreadID = MainThreadID, 'Internal error: called Spin() in non-GUI thread');
//  Assert(fDetentCount = 1, 'Internal error: worker thread nested spin()');
  result := fDetentCount > 0;
  if result then
    fEvent.SetEvent
end { TMidiWriterThread.Spin } ;


constructor TMidiWriterThread.Create(createSuspended: boolean);

begin
  inherited Create(createSuspended);
  fLock := TCriticalSection.Create;
  fEvent := TSimpleEvent.Create;
  fDetentCount := 0;
  fQueue := TStringList.Create;
  fDeviceList := nil;
  selectedDevice := nil
end { TMidiWriterThread.Create } ;


destructor TMidiWriterThread.Destroy;

begin
  while not getDetented do              (* Wait for worker thread to go quiescent *)
    Sleep(1);
  fLock.Enter;
  if Assigned(fDeviceList) then
    FreeAndNil(fDeviceList);
  fQueue.Free;
  fEvent.Free;
  FreeAndNil(fLock);
  inherited Destroy
end { TMidiWriterThread.Destroy } ;


(* Enqueue a MIDI sequence to be played ASAP, but respecting any current
  activity.
*)
procedure TMidiWriterThread.Enqueue(const midi: string);

begin
  if not Assigned(selectedDevice) then
    exit;
  fLock.Enter;
  fQueue.Append(midi);
  fLock.Leave;
  while not Spin() do
    Application.ProcessMessages
end { TMidiWriterThread.Enqueue } ;


(* When a MIDI sequence has been made available collect, translate, and pass
  it to the ALSA subsystem. Output a generic beep if ALSA is unavailable (i.e.
  broken rather than busy).
*)
procedure TMidiWriterThread.Execute;

const
  writable= SND_SEQ_PORT_CAP_SUBS_WRITE or SND_SEQ_PORT_CAP_WRITE; (* Both required *)
  synthesizer= SND_SEQ_PORT_TYPE_SYNTHESIZER { or SND_SEQ_PORT_TYPE_PORT } ; (* Either required *)
  understandsMidi= SND_SEQ_PORT_TYPE_MIDI_GENERIC or SND_SEQ_PORT_TYPE_MIDI_GM or
                SND_SEQ_PORT_TYPE_MIDI_GS or SND_SEQ_PORT_TYPE_MIDI_XG or
                SND_SEQ_PORT_TYPE_MIDI_MT32 or SND_SEQ_PORT_TYPE_MIDI_GM2;

var
  status: integer;
  cinfo: Psnd_seq_client_info_t;
  pinfo: Psnd_seq_port_info_t;
  currentClient: integer;
  scratch: string;

begin

(* Open the MIDI sequencer in order to enumerate a list of devices. Start off   *)
(* with a check that the ALSA interface library is accessible, if this fails    *)
(* (which since the program has started implies a missing shared-object         *)
(* library) fail gracefully.                                                    *)

  if ASoundSeq.ModuleInMemory then
    status := AsoundSeq.snd_seq_open(@seqHandle, 'hw', SND_SEQ_OPEN_OUTPUT, 0)
  else
    status := -1;
  if status < 0 then begin
    seqHandle := nil;
    Warning('Cannot open sequencer for ALSA device enumeration: ' + AsoundSeq.snd_strError(status))
  end else
    try
      fDeviceList := TStringList.Create;
      AsoundSeq.snd_seq_client_info_malloc(@cinfo);
      try
        AsoundSeq.snd_seq_client_info_set_client(cinfo, -1);
        while AsoundSeq.snd_seq_query_next_client(seqHandle, cinfo) >= 0 do begin
          currentClient := AsoundSeq.snd_seq_client_info_get_client(cinfo);
          AsoundSeq.snd_seq_port_info_malloc(@pinfo);
          try

(* Beware of lots of procedures (originally macros) with similar names.         *)

            AsoundSeq.snd_seq_port_info_set_client(pinfo, currentClient);
            AsoundSeq.snd_seq_port_info_set_port(pinfo, -1);
            while (AsoundSeq.snd_seq_query_next_port(seqHandle, pinfo) >= 0) do begin
              selectedDevice := TSelectedDevice.Create;
              with selectedDevice do begin
                client := currentClient;
                capabilities := AsoundSeq.snd_seq_port_info_get_capability(pinfo);
                destination.client := AsoundSeq.snd_seq_port_info_get_client(pinfo);
                portType := AsoundSeq.snd_seq_port_info_get_type(pinfo);
                destination.port := AsoundSeq.snd_seq_port_info_get_port(pinfo);
                clientName := AsoundSeq.snd_seq_client_info_get_name(cinfo);
                portName := AsoundSeq.snd_seq_port_info_get_name(pinfo);
                if Pos(clientName, portName) <> 1 then
                  scratch := Format('%d:%d %s %s {%d,%d}', [destination.client,
                                destination.port, clientName, portName, capabilities, portType])
                else
                  scratch := Format('%d:%d %s {%d,%d}', [destination.client,
                                destination.port, portName, capabilities, portType]);

(* Special cases: recognising known client names, adjust the capabilities to    *)
(* ensure that they appear in what we believe to be the correct combination of  *)
(* input and output lists. I'm not saying that the quirked capabilities would   *)
(* be correct according to the ALSA API, only that they force the comparisons   *)
(* below.                                                                       *)

                if clientName = 'QmidiNet' then (* MIDI networking protocol     *)
                  if capabilities and SND_SEQ_PORT_CAP_DUPLEX = 0 then
                    capabilities += SND_SEQ_PORT_CAP_DUPLEX;

(* If the type of port indicates that it "may connect to other devices (whose   *)
(* characteristics are not known)" and it understands MIDI and is writeable     *)
(* then assume it's an interface to an external sound generator.                *)

                if portType and SND_SEQ_PORT_TYPE_PORT <> 0 then
                  if (portType and understandsMidi) <> 0 then
                    if (selectedDevice.capabilities and writable) = writable then
                      if Pos('through', LowerCase(portName)) < 1 then
                        portType += synthesizer

(* Noting the possibility of duplication between the client and port name, it's *)
(* far easier to remove it before rather than after returning it as a string.   *)
(* Note that the text description is generated before the capabilities and type *)
(* are massaged.                                                                *)
(*                                                                              *)
(*        16:0 Ensoniq AudioPCI              ES1370                             *)
(*        20:0 MD100                         MD100 MIDI 1                       *)
(*       128:0 TiMidity                      TiMidity port 0                    *)
(*       129:0 QmidiNet                      port 0                             *)

              end;
              if ((selectedDevice.capabilities and writable) = writable) and
                        ((selectedDevice.portType and synthesizer) <> 0) then begin
                fDeviceList.AddObject(scratch, selectedDevice);
                selectedDevice := nil   (* Object is in list                    *)
              end else begin

(* Output debugging messages so that a user can tell the developers what        *)
(* devices are being dropped. I'm particularly bothered here by the fact that a *)
(* generic USB->MIDI adapter, which has presumably been put on the system to    *)
(* drive a sound generator peripheral, might not be identified as such even if  *)
(* something is physically connected to its output port. Note that the text     *)
(* description is generated before the capabilities and type are massaged.      *)

                if selectedDevice.portType <> 0 then begin (* Ignore timers etc. *)
                  if (selectedDevice.capabilities and writable) <> writable then
                    WriteLn('Dropping ''', scratch, ''' since it is not an output device');
                  if (selectedDevice.portType and synthesizer) = 0 then
                    WriteLn('Dropping ''', scratch, ''' since it is not a synthesiser')
                end;
                FreeAndNil(selectedDevice) (* Object is no longer required      *)
              end
            end { while }
          finally
            AsoundSeq.snd_seq_port_info_free(pinfo);
            pinfo := nil
          end
        end
      finally
        AsoundSeq.snd_seq_client_info_free(cinfo);
        cinfo := nil;

(* Ask the user what MIDI device is to be used. Don't simplify this for the no- *)
(* device case so that the modal form handling the selection can optionally     *)
(* display the available devices for debugging purposes.                        *)

        if fDeviceList.Count = 0 then
          Warning('No attached MIDI synthesiser devices')
        else
          Synchronize(@shimSelectDevice);
        if fDeviceList.Count = 1 then begin (* Is precisely one device left?    *)
          selectedDevice := TSelectedDevice(fDeviceList.Objects[0]);
          fDeviceList.Objects[0] := nil (* Make sure it's not freed             *)
        end else
          selectedDevice := nil;
        for currentClient := 0 to fDeviceList.Count - 1 do
          if fDeviceList.Objects[currentClient] <> nil then begin
            TSelectedDevice(fDeviceList.Objects[currentClient]).Free;
            fDeviceList.Objects[currentClient] := nil
          end;
        FreeAndNil(fDeviceList)
      end
    finally
      AsoundSeq.snd_seq_close(seqHandle)
    end;

(* If selectedDevice is unset then terminate the thread, assuming that any useful  *)
(* error messages have already been displayed. In principle at least it should  *)
(* be possible to try again if the device population changes.                   *)

  if selectedDevice = nil then
    exit;

(* The sequence that follows is borrowed from the aplaymidi source. That's not  *)
(* one of the references I used when I was working on the Unyoked program, but  *)
(* the various examples etc. available seem better suited for writing filters   *)
(* than for the (in principle) simple requirement of sending the content of a   *)
(* file to a MIDI synthesiser (implemented either as hardware or software).     *)

(* Open named (actually numbered) device, description is in selectedDevice.     *)

  status := AsoundSeq.snd_seq_open(@seqHandle, 'default', SND_SEQ_OPEN_OUTPUT, 0);
  if status < 0 then begin
    Warning('Cannot open sequencer for ALSA device output: ' + AsoundSeq.snd_strError(status));
    exit
  end;
  try
    status := AsoundSeq.snd_seq_set_client_name(seqHandle, clientName);
    if status < 0 then begin
      Warning('Cannot set ALSA client name: ' + AsoundSeq.snd_strError(status));
      exit
    end;

(* We already have the client and port number from parsing the available ports, *)
(* confirmed by the user if there was more than one possibility. Create a       *)
(* source port which is used to originate MIDI events, even if each event is    *)
(* populated by code here rather than by a hardware or software MIDI device.    *)


    status := AsoundSeq.snd_seq_port_info_malloc(@pinfo);
    if status < 0 then begin
      Warning('Cannot allocate ALSA port_info memory: ' + AsoundSeq.snd_strError(status));
      exit
    end;
    try
      AsoundSeq.snd_seq_port_info_set_port(pinfo, 0); (* Defaults to 0, this for safety *)
      AsoundSeq.snd_seq_port_info_set_port_specified(pinfo, 1);
      AsoundSeq.snd_seq_port_info_set_name(pinfo, clientName);
      AsoundSeq.snd_seq_port_info_set_capability(pinfo, 0); (* Ditto            *)
      AsoundSeq.snd_seq_port_info_set_type(pinfo, SND_SEQ_PORT_TYPE_MIDI_GENERIC +
                                        SND_SEQ_PORT_TYPE_APPLICATION);
      status := AsoundSeq.snd_seq_create_port(seqHandle, pinfo);
      if status < 0 then begin
        Warning('Cannot create ALSA source port: ' + AsoundSeq.snd_strError(status));
        exit
      end
    finally
      AsoundSeq.snd_seq_port_info_free(pinfo);
      pinfo := nil
    end;

(* Create a queue.                                                              *)

    seqQueue := AsoundSeq.snd_seq_alloc_named_queue(seqHandle, clientName);
    if seqQueue < 0 then begin
      Warning('Cannot create ALSA queue: ' + AsoundSeq.snd_strError(seqQueue));
      exit
    end;
    try

(* Connect the ports in order to keep the raw device open.                      *)

      status := AsoundSeq.snd_seq_connect_to(seqHandle, 0, selectedDevice.destination.client, selectedDevice.destination.port);
      if status < 0 then begin
        Warning('Cannot connect ALSA ports: ' + AsoundSeq.snd_strError(status));
        exit
      end;
      status := AsoundSeq.snd_seq_start_queue(seqHandle, seqQueue, nil);
      if status < 0 then begin
        Warning('Cannot start ALSA queue: ' + AsoundSeq.snd_strError(status));
        exit
      end;

(* Ready to run, enqueue a startup jingle (first three notes of "Fanfare for    *)
(* the Common Man).                                                             *)

//      fQueue.Append('!127 c009 +200 G5C6 +1000 G');

(* Hack here: because the code I've repurposed prompts the user for the MIDI    *)
(* device asynchronously, we'll fall out of this procedure before it's known.   *)
(* As a result, I've hardcoded the default tune in the thread's main loop and   *)
(* hope the user doesn't notice.                                                *)

      fQueue.Append('c050 !127 +660 A6');

(* Loop outputting to the device as requests are passed to us.                  *)

      repeat
        if fQueue.Count = 0 then
          Detent;
        if fQueue.Count > 0 then begin
          fLock.Enter;
          scratch := fQueue[0];
          fQueue.Delete(0);
          fLock.Leave;
          while ParseMidiAndEmit(scratch) do ;
          status := AsoundSeq.snd_seq_sync_output_queue(seqHandle);
          if status < 0 then begin
            Warning('ALSA output failure: ' + AsoundSeq.snd_strError(status));
            exit
          end
        end
      until Terminated
    finally
      AsoundSeq.snd_seq_free_queue(seqHandle, seqQueue);
      seqQueue := -1
    end
  finally
    AsoundSeq.snd_seq_close(seqHandle)
  end
end { TMidiWriterThread.Execute } ;


(* Remove one note etc. from the front of the string and convert it into a MIDI
  event for the synthesiser device associated with the sequencer handle. This
  was originally PlayMidi() etc. in UtilXyz.
*)
function TMidiWriterThread.ParseMidiAndEmit(var txt: string): boolean;

var
  ev: snd_seq_event_t;
  i: integer;

begin
  txt := Trim(txt);
  if txt = '' then
    exit(false);
  i := Length(txt);
  AsoundSeq.snd_seq_ev_clear(@ev);
  ev.queue := seqQueue;
  ev.source.port := 0;
  ev.flags := SND_SEQ_TIME_STAMP_REAL + SND_SEQ_TIME_MODE_REL;
  ev.time.time.tv_sec := 0;
  ev.time.time.tv_nsec := 0;
  result := ParseMidiToEvent(txt, ev);
  Assert(Length(txt) < i, 'Internal error: MIDI string not getting shorter');
  AsoundSeq.snd_seq_ev_set_fixed(@ev);
  ev.dest.client := selectedDevice.destination.client;
  ev.dest.port := selectedDevice.destination.port;

(* If the type has been set to SND_SEQ_EVENT_NONE it is not necessarily an      *)
(* error but the event should be ignored.                                       *)

  if ev.type_ = byte(SND_SEQ_EVENT_NONE) then
    exit;

(* As long as the result is true then emit the event to ALSA.                   *)

  if result then begin
    i := AsoundSeq.snd_seq_event_output(seqHandle, @ev);
    if i < 0 then
      result := false;
    if result then begin
      i := AsoundSeq.snd_seq_drain_output(seqHandle);
      if i < 0 then
        result := false
      else

(* We have successfully enqueued a note and told the queue to start draining.   *)
(* All of the synthesised _NOTE events will relate to channel zero so we have   *)
(* to pause here to ensure that the next note will not try to overwrite them,   *)
(* also delay for explicit channel-zero _NOTEON events but assume that other    *)
(* channels are implicitly paced by channel zero activity.                      *)
(*                                                                              *)
(* If I want to continue to support the legacy MIDI notation (i.e. with low-    *)
(* level hex activity) I suspect that I will have to redo this and use absolute *)
(* rather than relative timestamps.                                             *)

        if (ev.type_ = byte(SND_SEQ_EVENT_NOTE)) or
                ((ev.type_ = byte(SND_SEQ_EVENT_NOTEON)) and (ev.data.note.channel = 0)) then
          Sleep(ev.data.note.duration); // TODO : Unsure about duration scaling
    end
  end;

(* If result has become false then make sure the caller gives up.               *)

  if not result then
    txt := ''
end { TMidiWriterThread.ParseMidiAndEmit } ;


(* Is the underlying ALSA library linked statically or dynamically?
*)

function IsDynamic(): boolean;

begin
  AsoundSeq.IsDynamic
end { IsDynamic } ;


initialization
  Assert(InitMidiParser() = AsoundSeq.IsDynamic, 'Internal error: mixing static and dynamic ALSA linkage')
end.

