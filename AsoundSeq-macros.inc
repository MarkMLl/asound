
(* Most of the content of this file is functions which are defined in the       *)
(* AsoundSeqDefs.inc file but are implemented in the main program rather than   *)
(* in the external library. These are mostly derived from C macros, but there   *)
(* are also a small number of "convenience" functions intended to minimise the  *)
(* differences between static and dynamic linkage.                              *)

{$ifdef DYNAMIC }

{* Exported event type table
 *
This table is referred by snd_seq_ev_is_xxx.
 *}
function get_snd_seq_event_types(): Pcuint; inline;

begin
  result := AsoundSeq.get_snd_seq_event_types()
end;

property
{* Exported event type table
 *
This table is referred by snd_seq_ev_is_xxx.
 *}
  snd_seq_event_types: Pcuint read get_snd_seq_event_types;
{$else          }
type
  cuint_256= array[0..255] of cuint;

var
{* Exported event type table
 *
This table is referred by snd_seq_ev_is_xxx.
 *}
  snd_seq_event_types: { Pcuint } cuint_256; LIBASOUND__
{$endif DYNAMIC }


function CLSASOUND__ _SND_SEQ_TYPE(x: TSND_SEQ_EVFLG): cuint; inline;

begin
  Result := 1 shl cint(x);
end;


//#define _SND_SEQ_TYPE_OPT(x)  ((x)<<24)       /**< optional type - 8bit */


(** check the event type *)
function CLSASOUND__ snd_seq_type_check(ev: Psnd_seq_event_t; x: TSND_SEQ_EVFLG): Boolean; inline;

begin
  Result := (snd_seq_event_types[ev^.type_] and _SND_SEQ_TYPE(x)) <> 0;
end;


(** event type check: result events *)
function CLSASOUND__ snd_seq_ev_is_result_type(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_type_check(ev, SND_SEQ_EVFLG_RESULT);
end;


(** event type check: note events *)
function CLSASOUND__ snd_seq_ev_is_note_type(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_type_check(ev, SND_SEQ_EVFLG_NOTE);
end;


(** event type check: control events *)
function CLSASOUND__ snd_seq_ev_is_control_type(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_type_check(ev, SND_SEQ_EVFLG_CONTROL);
end;


(** event type check: channel specific events *)
function CLSASOUND__ snd_seq_ev_is_channel_type(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := (snd_seq_event_types[ev^.type_] and
        (_SND_SEQ_TYPE(SND_SEQ_EVFLG_NOTE) or _SND_SEQ_TYPE(SND_SEQ_EVFLG_CONTROL))) <> 0;
end;


(** event type check: queue control events *)
function CLSASOUND__ snd_seq_ev_is_queue_type(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_type_check(ev, SND_SEQ_EVFLG_QUEUE);
end;


(** event type check: system status messages *)
function CLSASOUND__ snd_seq_ev_is_message_type(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_type_check(ev, SND_SEQ_EVFLG_MESSAGE);
end;


(** event type check: system status messages *)
function CLSASOUND__ snd_seq_ev_is_subscribe_type(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_type_check(ev, SND_SEQ_EVFLG_CONNECTION);
end;


(** event type check: sample messages *)
function CLSASOUND__ snd_seq_ev_is_sample_type(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_type_check(ev, SND_SEQ_EVFLG_SAMPLE);
end;


(** event type check: user-defined messages *)
function CLSASOUND__ snd_seq_ev_is_user_type(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_type_check(ev, SND_SEQ_EVFLG_USERS);
end;


(** event type check: instrument layer events *)
function CLSASOUND__ snd_seq_ev_is_instr_type(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_type_check(ev, SND_SEQ_EVFLG_INSTR);
end;


(** event type check: fixed length events *)
function CLSASOUND__ snd_seq_ev_is_fixed_type(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_type_check(ev, SND_SEQ_EVFLG_FIXED);
end;


(** event type check: variable length events *)
function CLSASOUND__ snd_seq_ev_is_variable_type(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_type_check(ev, SND_SEQ_EVFLG_VARIABLE);
end;


(** event type check: user pointer events *)
function CLSASOUND__ snd_seq_ev_is_varusr_type(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_type_check(ev, SND_SEQ_EVFLG_VARUSR);
end;


(** event type check: reserved for kernel *)
function CLSASOUND__ snd_seq_ev_is_reserved(ev: Psnd_seq_event_t): Boolean; inline;

(* For debugging: snd_seq_event_types is a pointer to an array which I believe  *)
(* is declared like this

const unsigned int snd_seq_event_types[256] = {
  [SND_SEQ_EVENT_SYSTEM ... SND_SEQ_EVENT_RESULT] = FIXED_EV(SND_SEQ_EVFLG_RESULT),
  [SND_SEQ_EVENT_NOTE] = FIXED_EV(SND_SEQ_EVFLG_NOTE) | _SND_SEQ_TYPE_OPT(SND_SEQ_EVFLG_NOTE_TWOARG),
...                                                                             *)

(* i.e. elements SND_SEQ_EVENT_SYSTEM through SND_SEQ_EVENT_RESULT (0..1) are   *)
(* both SND_SEQ_EVFLG_RESULT, (2..4) are undefined, and SND_SEQ_EVENT_NOTE (5)  *)
(* has some high bits set computed using _SND_SEQ_TYPE_OPT(x) ((x)<<24).        *)

{ var
  p: Pcuint;
  b, t: cuint;

begin
  p := snd_seq_event_types;
  b := p^;
  t := ev^.type_;
  b := snd_seq_event_types[t];
  result := b = 0; }

(* The debugging code above was added since I had significant problems with     *)
(* fpalsa's definition of the external snd_seq_event_types[] variable. Once     *)
(* that was corrected both static and dynamic linkage- the latter by way of a   *)
(* property and getter function- worked as intended... but I'm still leaving    *)
(* sanity checks here based on my inspection of the table contents.             *)

begin
  Assert(snd_seq_event_types[0] = $00002001, 'Bad access to snd_seq_event_types table[0]');
  Assert(snd_seq_event_types[5] >> 24 <> 0, 'Bad access to snd_seq_event_types table[5]');
  Result := snd_seq_event_types[ev^.type_] = 0;
end;


(**
macros to check event flags
 *)

(** prior events *)
function CLSASOUND__ snd_seq_ev_is_prior(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := (ev^.flags and SND_SEQ_PRIORITY_MASK) = SND_SEQ_PRIORITY_HIGH;
end;


(** get the data length type *)
function CLSASOUND__ snd_seq_ev_length_type(ev: Psnd_seq_event_t): cuchar; inline;

begin
  Result := ev^.flags and SND_SEQ_EVENT_LENGTH_MASK;
end;


(** fixed length events *)
function CLSASOUND__ snd_seq_ev_is_fixed(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_ev_length_type(ev) = SND_SEQ_EVENT_LENGTH_FIXED;
end;


(** variable length events *)
function CLSASOUND__ snd_seq_ev_is_variable(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_ev_length_type(ev) = SND_SEQ_EVENT_LENGTH_VARIABLE;
end;


(** variable length on user-space *)
function CLSASOUND__ snd_seq_ev_is_varusr(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_ev_length_type(ev) = SND_SEQ_EVENT_LENGTH_VARUSR;
end;


(** time-stamp type *)
function CLSASOUND__ snd_seq_ev_timestamp_type(ev: Psnd_seq_event_t): cuchar; inline;

begin
  Result := ev^.flags and SND_SEQ_TIME_STAMP_MASK;
end;


(** event is in tick time *)
function CLSASOUND__ snd_seq_ev_is_tick(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_ev_timestamp_type(ev) = SND_SEQ_TIME_STAMP_TICK;
end;


(** event is in real-time *)
function CLSASOUND__ snd_seq_ev_is_real(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_ev_timestamp_type(ev) = SND_SEQ_TIME_STAMP_REAL;
end;


(** time-mode type *)
function CLSASOUND__ snd_seq_ev_timemode_type(ev: Psnd_seq_event_t): cuchar; inline;

begin
  Result := ev^.flags and SND_SEQ_TIME_MODE_MASK;
end;


(** scheduled in absolute time *)
function CLSASOUND__ snd_seq_ev_is_abstime(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_ev_timemode_type(ev) = SND_SEQ_TIME_MODE_ABS;
end;


(** scheduled in relative time *)
function CLSASOUND__ snd_seq_ev_is_reltime(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := snd_seq_ev_timemode_type(ev) = SND_SEQ_TIME_MODE_REL;
end;


(** direct dispatched events *)
function CLSASOUND__ snd_seq_ev_is_direct(ev: Psnd_seq_event_t): Boolean; inline;

begin
  Result := ev^.queue = SND_SEQ_QUEUE_DIRECT;
end;


// fpalsa defines these in seqmid.inc:

(* initialize event record

Parameters
    ev	        event record pointer

This macro clears the given event record pointer to the default status.
*)
procedure CLSASOUND__ snd_seq_ev_clear(ev: Psnd_seq_event_t); inline; // Macro, not in library

begin
  FillChar(ev^, SizeOf(snd_seq_event_t), 0);
end;


(* set the tag for given event

Parameters
    ev          event record
    t           event tag

This macro sets the tag to the given event record.
*)
procedure CLSASOUND__ snd_seq_ev_set_tag(ev: Psnd_seq_event_t; t: cuchar); inline;

begin
  ev^.tag := t;
end;


(* set the explicit destination

Parameters
    ev          event record
    c           destination client id
    p           destination port id

This macro sets the client and port id numbers to the given event record.
*)
procedure CLSASOUND__ snd_seq_ev_set_dest(ev: Psnd_seq_event_t; c, p: cuchar); inline;

begin
  ev^.dest.client := c;
  ev^.dest.port := p;
end;


(* set broadcasting to subscribers

Parameters
    ev          event record

This macro sets the destination as the subscribers.
*)
procedure CLSASOUND__ snd_seq_ev_set_subs(ev: Psnd_seq_event_t); inline;

begin
  ev^.dest.client := SND_SEQ_ADDRESS_SUBSCRIBERS;
  ev^.dest.port := SND_SEQ_ADDRESS_UNKNOWN;
end;


(* set broadcasting to all clients/ports

Parameters
    ev          event record

This macro sets the destination as the broadcasting.
*)
procedure CLSASOUND__ snd_seq_ev_set_broadcast(ev: Psnd_seq_event_t); inline;

begin
  ev^.dest.client := SND_SEQ_ADDRESS_BROADCAST;
  ev^.dest.port := SND_SEQ_ADDRESS_BROADCAST;
end;


(* set the source port

Parameters
    ev          event record
    p           source port id

This macro sets the source port id number.
*)
procedure CLSASOUND__ snd_seq_ev_set_source(ev: Psnd_seq_event_t; p: cuchar); inline;

begin
  ev^.source.port := p;
end;


(* set direct passing mode (without queued)

Parameters
    ev          event instance

This macro sets the event to the direct passing mode to be delivered immediately without queueing.
*)
procedure CLSASOUND__ snd_seq_ev_set_direct(ev: Psnd_seq_event_t); inline;

begin
  ev^.queue := SND_SEQ_QUEUE_DIRECT;
end;


(* set tick-scheduling mode on queue

Parameters
    ev          event instance
    q           queue id to schedule
    relative    relative time-stamp if non-zero
    ttick       tick time-stamp to be delivered

This macro sets the scheduling of the event in the MIDI tick mode.
*)
procedure CLSASOUND__ snd_seq_ev_schedule_tick(ev: Psnd_seq_event_t; q: cuchar; relative: Boolean; ttick: snd_seq_tick_time_t); inline;

begin
  ev^.flags := ev^.flags and not (SND_SEQ_TIME_STAMP_MASK or SND_SEQ_TIME_MODE_MASK);
  ev^.flags := ev^.flags or SND_SEQ_TIME_STAMP_TICK;
  if relative then
    ev^.flags := ev^.flags or SND_SEQ_TIME_MODE_REL
  else
    ev^.flags := ev^.flags or SND_SEQ_TIME_MODE_ABS;
  ev^.time.tick := ttick;
  ev^.queue := q;
end;


(* set real-time-scheduling mode on queue

Parameters
    ev          event instance
    q           queue id to schedule
    relative    relative time-stamp if non-zero
    rtime       time-stamp to be delivered

This macro sets the scheduling of the event in the realtime mode.
*)
procedure CLSASOUND__ snd_seq_ev_schedule_real(ev: Psnd_seq_event_t; q: cuchar; relative: Boolean; rtime: Psnd_seq_real_time_t); inline;

begin
  ev^.flags := ev^.flags and not (SND_SEQ_TIME_STAMP_MASK or SND_SEQ_TIME_MODE_MASK);
  ev^.flags := ev^.flags or SND_SEQ_TIME_STAMP_REAL;
  if relative then
    ev^.flags := ev^.flags or SND_SEQ_TIME_MODE_REL
  else
    ev^.flags := ev^.flags or SND_SEQ_TIME_MODE_ABS;
  ev^.time.time := rtime^;
  ev^.queue := q;
end;


(* set event priority

Parameters
    ev          event instance
    high_prior  1 for high priority mode
*)
procedure CLSASOUND__ snd_seq_ev_set_priority(ev: Psnd_seq_event_t; high_prior: Boolean); inline;

begin
  ev^.flags := ev^.flags and not SND_SEQ_PRIORITY_MASK;
  if high_prior then
    ev^.flags := ev^.flags or SND_SEQ_PRIORITY_HIGH
  else
    ev^.flags := ev^.flags or SND_SEQ_PRIORITY_NORMAL;
end;


(* set fixed data

Parameters
    ev          event instance

Sets the event length mode as fixed size.
*)
procedure CLSASOUND__ snd_seq_ev_set_fixed(ev: Psnd_seq_event_t); inline;

begin
  ev^.flags := ev^.flags and not SND_SEQ_EVENT_LENGTH_MASK;
  ev^.flags := ev^.flags or SND_SEQ_EVENT_LENGTH_FIXED;
end;


(* set variable data

Parameters
    ev          event instance
    datalen     length of the external data
    dataptr     pointer of the external data

Sets the event length mode as variable length and stores the data.
*)
procedure CLSASOUND__ snd_seq_ev_set_variable(ev: Psnd_seq_event_t; datalen: cuint; dataptr: Pointer); inline;

begin
  ev^.flags := ev^.flags and not SND_SEQ_EVENT_LENGTH_MASK;
  ev^.flags := ev^.flags or SND_SEQ_EVENT_LENGTH_VARIABLE;
  ev^.data.ext.len := datalen;
  ev^.data.ext.ptr := dataptr;
end;


(* set varusr data

Parameters
    ev          event instance
    datalen     length of the external data
    dataptr     pointer of the external data

Sets the event length mode as variable user-space data and stores the data.
*)
procedure CLSASOUND__ snd_seq_ev_set_varusr(ev: Psnd_seq_event_t; datalen: cuint; dataptr: Pointer); inline;

begin
  ev^.flags := ev^.flags and not SND_SEQ_EVENT_LENGTH_MASK;
  ev^.flags := ev^.flags or SND_SEQ_EVENT_LENGTH_VARUSR;
  ev^.data.ext.len := datalen;
  ev^.data.ext.ptr := dataptr;
end;


(* set queue controls

Parameters
    ev          event record
    typ         event type
    q           queue id
    val         control value
*)
procedure CLSASOUND__ snd_seq_ev_set_queue_control(ev: Psnd_seq_event_t; typ: snd_seq_event_type; q: cuchar; val: cint); inline;

begin
  ev^.type_ := snd_seq_event_type_t(typ);
  snd_seq_ev_set_dest(ev, SND_SEQ_CLIENT_SYSTEM, SND_SEQ_PORT_SYSTEM_TIMER);
  ev^.data.queue.queue := q;
  ev^.data.queue.param.value := val;
end;


(* set the start queue event

Parameters
    ev          event record
    q           queue id to start
*)
procedure CLSASOUND__ snd_seq_ev_set_queue_start(ev: Psnd_seq_event_t; q: cuchar); inline;

begin
  snd_seq_ev_set_queue_control(ev, SND_SEQ_EVENT_START, q, 0);
end;


(* set the stop queue event

Parameters
    ev          event record
    q           queue id to stop
*)
procedure CLSASOUND__ snd_seq_ev_set_queue_stop(ev: Psnd_seq_event_t; q: cuchar); inline;

begin
  snd_seq_ev_set_queue_control(ev, SND_SEQ_EVENT_STOP, q, 0);
end;


(* set the stop queue event

Parameters
    ev          event record
    q           queue id to continue
*)
procedure CLSASOUND__ snd_seq_ev_set_queue_continue(ev: Psnd_seq_event_t; q: cuchar); inline;

begin
  snd_seq_ev_set_queue_control(ev, SND_SEQ_EVENT_CONTINUE, q, 0);
end;


(* set the stop queue event

Parameters
    ev          event record
    q           queue id to change tempo
    val         the new tempo value
*)
procedure CLSASOUND__ snd_seq_ev_set_queue_tempo(ev: Psnd_seq_event_t; q: cuchar; val: cint); inline;

begin
  snd_seq_ev_set_queue_control(ev, SND_SEQ_EVENT_TEMPO, q, val);
end;


(* set the real-time position of a queue

Parameters
    ev          event record
    q           queue id to change tempo
    rtime       the new real-time pointer
*)
procedure CLSASOUND__ snd_seq_ev_set_queue_pos_real(ev: Psnd_seq_event_t; q: cuchar; rtime: Psnd_seq_real_time_t); inline;

begin
  ev^.type_ := snd_seq_event_type_t(SND_SEQ_EVENT_SETPOS_TIME);
  snd_seq_ev_set_dest(ev, SND_SEQ_CLIENT_SYSTEM, SND_SEQ_PORT_SYSTEM_TIMER);
  ev^.data.queue.queue := q;
  ev^.data.queue.param.time.time := rtime^;
end;


(* set the tick-time position of a queue

Parameters
    ev          event record
    q           queue id to change tempo
    ttime       the new tick-time
*)
procedure CLSASOUND__ snd_seq_ev_set_queue_pos_tick(ev: Psnd_seq_event_t; q: cuchar; ttime: snd_seq_tick_time_t); inline;

begin
  ev^.type_ := snd_seq_event_type_t(SND_SEQ_EVENT_SETPOS_TICK);
  snd_seq_ev_set_dest(ev, SND_SEQ_CLIENT_SYSTEM, SND_SEQ_PORT_SYSTEM_TIMER);
  ev^.data.queue.queue := q;
  ev^.data.queue.param.time.tick := ttime;
end;


(* start the specified queue

Parameters
    seq	        sequencer handle
    q	        queue id to start
    ev	        optional event record (see snd_seq_control_queue)
*)
function CLSASOUND__ snd_seq_start_queue(seq: Psnd_seq_t; q: cint; ev: Psnd_seq_event_t): cint; inline; // Macro, not in library

begin
  Result := snd_seq_control_queue(seq, q, cint(SND_SEQ_EVENT_START), 0, ev);
end;


(* stop the specified queue

Parameters
    seq         sequencer handle
    q           queue id to stop
    ev          optional event record (see #snd_seq_control_queue)
*)
function CLSASOUND__ snd_seq_stop_queue(seq: Psnd_seq_t; q: cint; ev: Psnd_seq_event_t): cint; inline;

begin
  Result := snd_seq_control_queue(seq, q, cint(SND_SEQ_EVENT_STOP), 0, ev);
end;


(* continue the specified queue

Parameters
    seq         sequencer handle
    q           queue id to continue
    ev          optional event record (see #snd_seq_control_queue)
*)
function CLSASOUND__ snd_seq_continue_queue(seq: Psnd_seq_t; q: cint; ev: Psnd_seq_event_t): cint; inline;

begin
  Result := snd_seq_control_queue(seq, q, cint(SND_SEQ_EVENT_CONTINUE), 0, ev);
end;


(* change the tempo of the specified queue

Parameters
    seq         sequencer handle
    q           queue id
    tempo       the new tempo value
    ev          optional event record (see #snd_seq_control_queue)
*)
function CLSASOUND__ snd_seq_change_queue_tempo(seq: Psnd_seq_t; q, tempo: cint; ev: Psnd_seq_event_t): cint; inline;

begin
  Result := snd_seq_control_queue(seq, q, cint(SND_SEQ_EVENT_TEMPO), tempo, ev);
end;


(* set note event

Parameters
    ev          event record
    ch          channel number
    key         note key
    vel         velocity
    dur         duration (in tick or msec)
*)
procedure CLSASOUND__ snd_seq_ev_set_note(ev: Psnd_seq_event_t; ch, key, vel: cuchar; dur: cuint); inline;

begin
  ev^.type_ := snd_seq_event_type_t(SND_SEQ_EVENT_NOTE);
  snd_seq_ev_set_fixed(ev);
  ev^.data.note.channel := ch;
  ev^.data.note.note := key;
  ev^.data.note.velocity := vel;
  ev^.data.note.duration := dur;
end;


(* set note-on event

Parameters
    ev          event record
    ch          channel number
    key         note key
    vel         velocity
*)
procedure CLSASOUND__ snd_seq_ev_set_noteon(ev: Psnd_seq_event_t; ch, key, vel: cuchar); inline;

begin
  ev^.type_ := snd_seq_event_type_t(SND_SEQ_EVENT_NOTEON);
  snd_seq_ev_set_fixed(ev);
  ev^.data.note.channel := ch;
  ev^.data.note.note := key;
  ev^.data.note.velocity := vel;
end;


(* set note-off event

Parameters
    ev          event record
    ch          channel number
    key         note key
    vel         velocity
*)
procedure CLSASOUND__ snd_seq_ev_set_noteoff(ev: Psnd_seq_event_t; ch, key, vel: cuchar); inline;

begin
  ev^.type_ := snd_seq_event_type_t(SND_SEQ_EVENT_NOTEOFF);
  snd_seq_ev_set_fixed(ev);
  ev^.data.note.channel := ch;
  ev^.data.note.note := key;
  ev^.data.note.velocity := vel;
end;


(* set key-pressure event

Parameters
    ev          event record
    ch          channel number
    key         note key
    vel         velocity
*)
procedure CLSASOUND__ snd_seq_ev_set_keypress(ev: Psnd_seq_event_t; ch, key, vel: cuchar); inline;

begin
  ev^.type_ := snd_seq_event_type_t(SND_SEQ_EVENT_KEYPRESS);
  snd_seq_ev_set_fixed(ev);
  ev^.data.note.channel := ch;
  ev^.data.note.note := key;
  ev^.data.note.velocity := vel;
end;


(* set MIDI controller event

Parameters
    ev          event record
    ch          channel number
    cc          controller number
    val         control value
*)
procedure CLSASOUND__ snd_seq_ev_set_controller(ev: Psnd_seq_event_t; ch: cuchar; cc: cuint; val: cint); inline;

begin
  ev^.type_ := snd_seq_event_type_t(SND_SEQ_EVENT_CONTROLLER);
  snd_seq_ev_set_fixed(ev);
  ev^.data.control.channel := ch;
  ev^.data.control.param := cc;
  ev^.data.control.value := val;
end;


(* set program change event

Parameters
    ev          event record
    ch          channel number
    val         program number
*)
procedure CLSASOUND__ snd_seq_ev_set_pgmchange(ev: Psnd_seq_event_t; ch: cuchar; val: cint); inline;

begin
  ev^.type_ := snd_seq_event_type_t(SND_SEQ_EVENT_PGMCHANGE);
  snd_seq_ev_set_fixed(ev);
  ev^.data.control.channel := ch;
  ev^.data.control.value := val;
end;


(* set pitch-bend event

Parameters
    ev          event record
    ch          channel number
    val         pitch bend; zero centered from -8192 to 8191
*)
procedure CLSASOUND__ snd_seq_ev_set_pitchbend(ev: Psnd_seq_event_t; ch: cuchar; val: cint); inline;

begin
  ev^.type_ := snd_seq_event_type_t(SND_SEQ_EVENT_PITCHBEND);
  snd_seq_ev_set_fixed(ev);
  ev^.data.control.channel := ch;
  ev^.data.control.value := val;
end;


(* set channel pressure event

Parameters
    ev          event record
    ch          channel number
    val         channel pressure value
*)
procedure CLSASOUND__ snd_seq_ev_set_chanpress(ev: Psnd_seq_event_t; ch: cuchar; val: cint); inline;

begin
  ev^.type_ := snd_seq_event_type_t(SND_SEQ_EVENT_CHANPRESS);
  snd_seq_ev_set_fixed(ev);
  ev^.data.control.channel := ch;
  ev^.data.control.value := val;
end;


(* set sysex event

Parameters
    ev          event record
    datalen     length of sysex data
    dataptr     sysex data pointer

the sysex data must contain the start byte 0xf0 and the end byte 0xf7.
*)
procedure CLSASOUND__ snd_seq_ev_set_sysex(ev: Psnd_seq_event_t; datalen: cuint; dataptr: Pointer); inline;

begin
  ev^.type_ := snd_seq_event_type_t(SND_SEQ_EVENT_SYSEX);
  snd_seq_ev_set_variable(ev, datalen, dataptr);
end;


{* Exported event type table
 *
This table is referred by snd_seq_ev_is_xxx.
 *}
function CLSASOUND__ get_snd_seq_event_types(): Pcuint; inline;

const
  Fsnd_seq_event_types: Pcuint= nil; (* Static variable                      *)

begin
{$ifdef DYNAMIC }
  if Fsnd_seq_event_types = nil then
    Fsnd_seq_event_types := AsoundSeq.LoadRoutine('snd_seq_event_types');
  result := Fsnd_seq_event_types
{$endif DYNAMIC }
end;

