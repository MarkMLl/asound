
(********************************************************************************)
(********************************************************************************)
(**                                                                            **)
(** FORMATTING NOTE: This file might be post-processed to generate Pascal      **)
(** units describing the static and dynamic interfaces to an external library. **)
(** Subroutine declarations MUST start with case-insensitive "function" or     **)
(** "procedure" as appropriate, and MUST end either with a Pascal macro name   **)
(** with at least one trailing underscore or with a semicolon. The style of    **)
(** termination is used to distinguish between external entry points and local **)
(** routines implemented as functional equivalents to C-style macros           **)
(** respectively.                                                              **)
(**                                                                            **)
(********************************************************************************)
(********************************************************************************)

(* This file contains the list of procedures/functions, either exported by a    *)
(* shared library or implemented by a statically-linked library. This might     *)
(* also double as the description of a list of procedures/functions exported by *)
(* a unit in cases where a library is written as part of a project group rather *)
(* than being provided by the host system.                                      *)
(*                                                                              *)
(* As such it is the master description of parameters and calling conventions,  *)
(* and all method type definitions etc. should comply with it.  MarkMLl.        *)

(* In the specific case of an interface to an ALSA subsystem (i.e. pcm, seq     *)
(* etc.), this supports only a small part of the overall API and should be      *)
(* extended with reference to the fpalsa project as required.                   *)

{*
 *   This library is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Lesser General Public License as
 *   published by the Free Software Foundation; either version 2.1 of
 *   the License, or (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Lesser General Public License for more details.
 *
 *   You should have received a copy of the GNU Lesser General Public
 *   License along with this library; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 *
 *}

// Documentation from https://www.alsa-project.org/alsa-doc/alsa-lib/seq.html,
// https://www.alsa-project.org/alsa-doc/alsa-lib/group___seq_client.html,
// https://www.alsa-project.org/alsa-doc/alsa-lib/group___seq_port.html,
// https://www.alsa-project.org/alsa-doc/alsa-lib/group___seq_queue.html,
// https://www.alsa-project.org/alsa-doc/alsa-lib/group___seq_event.html,
// https://www.alsa-project.org/alsa-doc/alsa-lib/group___seq_middle.html

{
#include <UnixType>
}

{$ifdef CONSTS }

// fpalsa defines these in seq.inc:


const
(**
Sequencer opening stream types
 *)
  SND_SEQ_OPEN_OUTPUT = 1;  (**< open for output (write) *)
  SND_SEQ_OPEN_INPUT  = 2;  (**< open for input (read) *)
  SND_SEQ_OPEN_DUPLEX = (SND_SEQ_OPEN_OUTPUT or SND_SEQ_OPEN_INPUT);  (**< open for both input and output (read/write) *)

(**
Sequencer opening mode

   NOTE: fpalsa and the C API refer to this as SND_SEQ_NONBLOCK.
 *)
  SND_SEQ_OPEN_NONBLOCK = $0001;  (**< non-blocking mode (flag to open mode) *)
{$INFO SND_SEQ_NONBLOCK renamed to SND_SEQ_OPEN_NONBLOCK, because pascal isn't case sensitive. }

(** Special client (port) ids *)
  SND_SEQ_ADDRESS_UNKNOWN     = 253;  (**< unknown source *)
  SND_SEQ_ADDRESS_SUBSCRIBERS = 254;  (**< send event to all subscribed ports *)
  SND_SEQ_ADDRESS_BROADCAST   = 255;  (**< send event to all queues/clients/ports/channels *)

(** Known client numbers *)
  SND_SEQ_CLIENT_SYSTEM       = 0;  (**< system client *)

(** Known port numbers *)
  SND_SEQ_PORT_SYSTEM_TIMER    = 0;  (**< system timer port *)
  SND_SEQ_PORT_SYSTEM_ANNOUNCE = 1;  (**< system announce port *)

(** Port capabilities (32 bits) *)
  SND_SEQ_PORT_CAP_READ        = 1 shl 0;  (**< readable from this port *)
  SND_SEQ_PORT_CAP_WRITE       = 1 shl 1;  (**< writable to this port *)

  SND_SEQ_PORT_CAP_SYNC_READ   = 1 shl 2;  (**< allow read subscriptions *)
  SND_SEQ_PORT_CAP_SYNC_WRITE  = 1 shl 3;  (**< allow write subscriptions *)

  SND_SEQ_PORT_CAP_DUPLEX      = 1 shl 4;  (**< allow read/write duplex *)

  SND_SEQ_PORT_CAP_SUBS_READ   = 1 shl 5;  (**< allow read subscription *)
  SND_SEQ_PORT_CAP_SUBS_WRITE  = 1 shl 6;  (**< allow write subscription *)
  SND_SEQ_PORT_CAP_NO_EXPORT   = 1 shl 7;  (**< routing not allowed *)

(* Port type *)
(** Messages sent from/to this port have device-specific semantics. *)
  SND_SEQ_PORT_TYPE_SPECIFIC      = 1 shl 0;
(** This port understands MIDI messages. *)
  SND_SEQ_PORT_TYPE_MIDI_GENERIC  = 1 shl 1;
(** This port is compatible with the General MIDI specification. *)
  SND_SEQ_PORT_TYPE_MIDI_GM       = 1 shl 2;
(** This port is compatible with the Roland GS standard. *)
  SND_SEQ_PORT_TYPE_MIDI_GS       = 1 shl 3;
(** This port is compatible with the Yamaha XG specification. *)
  SND_SEQ_PORT_TYPE_MIDI_XG       = 1 shl 4;
(** This port is compatible with the Roland MT-32. *)
  SND_SEQ_PORT_TYPE_MIDI_MT32     = 1 shl 5;
(** This port is compatible with the General MIDI 2 specification. *)
  SND_SEQ_PORT_TYPE_MIDI_GM2      = 1 shl 6;
(** This port understands SND_SEQ_EVENT_SAMPLE_xxx messages
    (these are not MIDI messages). *)
  SND_SEQ_PORT_TYPE_SYNTH         = 1 shl 10;
(** Instruments can be downloaded to this port
    (with SND_SEQ_EVENT_INSTR_xxx messages sent directly). *)
  SND_SEQ_PORT_TYPE_DIRECT_SAMPLE = 1 shl 11;
(** Instruments can be downloaded to this port
    (with SND_SEQ_EVENT_INSTR_xxx messages sent directly or through a queue). *)
  SND_SEQ_PORT_TYPE_SAMPLE        = 1 shl 12;
(** This port is implemented in hardware. *)
  SND_SEQ_PORT_TYPE_HARDWARE      = 1 shl 16;
(** This port is implemented in software. *)
  SND_SEQ_PORT_TYPE_SOFTWARE      = 1 shl 17;
(** Messages sent to this port will generate sounds. *)
  SND_SEQ_PORT_TYPE_SYNTHESIZER   = 1 shl 18;
(** This port may connect to other devices
    (whose characteristics are not known). *)
  SND_SEQ_PORT_TYPE_PORT          = 1 shl 19;
(** This port belongs to an application, such as a sequencer or editor. *)
  SND_SEQ_PORT_TYPE_APPLICATION   = 1 shl 20;

(* Port type *)
  SND_SEQ_QUEUE_DIRECT = 253;  (**< direct dispatch *)

(** Remove conditional flags *)
  SND_SEQ_REMOVE_INPUT        = 1 shl 0;  (**< Flush input queues *)
  SND_SEQ_REMOVE_OUTPUT       = 1 shl 1;  (**< Flush output queues *)
  SND_SEQ_REMOVE_DEST         = 1 shl 2;  (**< Restrict by destination q:client:port *)
  SND_SEQ_REMOVE_DEST_CHANNEL = 1 shl 3;  (**< Restrict by channel *)
  SND_SEQ_REMOVE_TIME_BEFORE  = 1 shl 4;  (**< Restrict to before time *)
  SND_SEQ_REMOVE_TIME_AFTER   = 1 shl 5;  (**< Restrict to time or after *)
  SND_SEQ_REMOVE_TIME_TICK    = 1 shl 6;  (**< Time is in ticks *)
  SND_SEQ_REMOVE_EVENT_TYPE   = 1 shl 7;  (**< Restrict to event type *)
  SND_SEQ_REMOVE_IGNORE_OFF   = 1 shl 8;  (**< Do not flush off events *)
  SND_SEQ_REMOVE_TAG_MATCH    = 1 shl 9;  (**< Restrict to events with given tag *)

(**
Event mode flags
 *
NOTE: only 8 bits available!
 *)
  SND_SEQ_TIME_STAMP_TICK       = 0 shl 0;  (**< timestamp in clock ticks *)
  SND_SEQ_TIME_STAMP_REAL       = 1 shl 0;  (**< timestamp in real time *)
  SND_SEQ_TIME_STAMP_MASK       = 1 shl 0;  (**< mask for timestamp bits *)

  SND_SEQ_TIME_MODE_ABS         = 0 shl 1;  (**< absolute timestamp *)
  SND_SEQ_TIME_MODE_REL         = 1 shl 1;  (**< relative to current time *)
  SND_SEQ_TIME_MODE_MASK        = 1 shl 1;  (**< mask for time mode bits *)

  SND_SEQ_EVENT_LENGTH_FIXED    = 0 shl 2;  (**< fixed event size *)
  SND_SEQ_EVENT_LENGTH_VARIABLE = 1 shl 2;  (**< variable event size *)
  SND_SEQ_EVENT_LENGTH_VARUSR   = 2 shl 2;  (**< variable event size - user memory space *)
  SND_SEQ_EVENT_LENGTH_MASK     = 3 shl 2;  (**< mask for event length bits *)

  SND_SEQ_PRIORITY_NORMAL       = 0 shl 4;  (**< normal priority *)
  SND_SEQ_PRIORITY_HIGH         = 1 shl 4;  (**< event should be processed before others *)
  SND_SEQ_PRIORITY_MASK         = 1 shl 4;  (**< mask for priority bits *)
{$endif CONSTS }

{$ifdef TYPES  }

// fpalsa defines these in seq.inc:

type
(** Sequencer handle *)
  PPsnd_seq_t = ^Psnd_seq_t;
  Psnd_seq_t = ^snd_seq_t;
  snd_seq_t = record
  end;

(** Sequencer handle type *)
  Psnd_seq_type_t = ^snd_seq_type_t;
  snd_seq_type_t = (
        SND_SEQ_TYPE_HW,  (**< hardware *)
        SND_SEQ_TYPE_SHM,  (**< shared memory (NYI) *)
        SND_SEQ_TYPE_INET);  (**< network (NYI) *)

(** System information container *)
  PPsnd_seq_system_info_t = ^Psnd_seq_system_info_t;
  Psnd_seq_system_info_t = ^snd_seq_system_info_t;
  snd_seq_system_info_t = record
  end;

(** Client information container *)
  PPsnd_seq_client_info_t = ^Psnd_seq_client_info_t;
  Psnd_seq_client_info_t = ^snd_seq_client_info_t;
  snd_seq_client_info_t = record
  end;

(** Client types *)
  Psnd_seq_client_type_t = ^snd_seq_client_type_t;
  snd_seq_client_type_t = (
        SND_SEQ_USER_CLIENT     = 1,  (**< user client *)
        SND_SEQ_KERNEL_CLIENT   = 2);  (**< kernel client *)

(** Client pool information container *)
  PPsnd_seq_client_pool_t = ^Psnd_seq_client_pool_t;
  Psnd_seq_client_pool_t = ^snd_seq_client_pool_t;
  snd_seq_client_pool_t = record
  end;

(** Port information container *)
  PPsnd_seq_port_info_t = ^Psnd_seq_port_info_t;
  Psnd_seq_port_info_t = ^snd_seq_port_info_t;
  snd_seq_port_info_t = record
  end;

(** Port subscription container *)
  PPsnd_seq_port_subscribe_t = ^Psnd_seq_port_subscribe_t;
  Psnd_seq_port_subscribe_t = ^snd_seq_port_subscribe_t;
  snd_seq_port_subscribe_t = record
  end;

(** Subscription query container *)
  PPsnd_seq_query_subscribe_t = ^Psnd_seq_query_subscribe_t;
  Psnd_seq_query_subscribe_t = ^snd_seq_query_subscribe_t;
  snd_seq_query_subscribe_t = record
  end;

(** Type of query subscription *)
  Psnd_seq_query_subs_type_t = ^snd_seq_query_subs_type_t;
  snd_seq_query_subs_type_t = (
        SND_SEQ_QUERY_SUBS_READ,  (**< query read subscriptions *)
        SND_SEQ_QUERY_SUBS_WRITE);  (**< query write subscriptions *)

(** Queue information container *)
  PPsnd_seq_queue_info_t = ^Psnd_seq_queue_info_t;
  Psnd_seq_queue_info_t = ^snd_seq_queue_info_t;
  snd_seq_queue_info_t = record
  end;

(** Queue status container *)
  PPsnd_seq_queue_status_t = ^Psnd_seq_queue_status_t;
  Psnd_seq_queue_status_t = ^snd_seq_queue_status_t;
  snd_seq_queue_status_t = record
  end;

(** Queue tempo container *)
  PPsnd_seq_queue_tempo_t = ^Psnd_seq_queue_tempo_t;
  Psnd_seq_queue_tempo_t = ^snd_seq_queue_tempo_t;
  snd_seq_queue_tempo_t = record
  end;

(** Queue timer information container *)
  PPsnd_seq_queue_timer_t = ^Psnd_seq_queue_timer_t;
  Psnd_seq_queue_timer_t = ^snd_seq_queue_timer_t;
  snd_seq_queue_timer_t = record
  end;

(** Sequencer timer sources *)
  PPsnd_seq_queue_timer_type_t = ^Psnd_seq_queue_timer_type_t;
  Psnd_seq_queue_timer_type_t = ^snd_seq_queue_timer_type_t;
  snd_seq_queue_timer_type_t = (
        SND_SEQ_TIMER_ALSA = 0,  (* ALSA timer *)
        SND_SEQ_TIMER_MIDI_CLOCK = 1, (* Midi Clock (CLOCK event) *)
        SND_SEQ_TIMER_MIDI_TICK = 2);  (* Midi Timer Tick (TICK event *)

(** Event removal conditionals *)
  PPsnd_seq_remove_events_t = ^Psnd_seq_remove_events_t;
  Psnd_seq_remove_events_t = ^snd_seq_remove_events_t;
  snd_seq_remove_events_t = record
  end;

(* Event type macros *)
  TSND_SEQ_EVFLG = (
        SND_SEQ_EVFLG_RESULT,
        SND_SEQ_EVFLG_NOTE,
        SND_SEQ_EVFLG_CONTROL,
        SND_SEQ_EVFLG_QUEUE,
        SND_SEQ_EVFLG_SYSTEM,
        SND_SEQ_EVFLG_MESSAGE,
        SND_SEQ_EVFLG_CONNECTION,
        SND_SEQ_EVFLG_SAMPLE,
        SND_SEQ_EVFLG_USERS,
        SND_SEQ_EVFLG_INSTR,
        SND_SEQ_EVFLG_QUOTE,
        SND_SEQ_EVFLG_NONE,
        SND_SEQ_EVFLG_RAW,
        SND_SEQ_EVFLG_FIXED,
        SND_SEQ_EVFLG_VARIABLE,
        SND_SEQ_EVFLG_VARUSR);

(* Event type macros *)
  TSND_SEQ_EVFLG_NOTE = (
        SND_SEQ_EVFLG_NOTE_ONEARG,
        SND_SEQ_EVFLG_NOTE_TWOARG);

(* Event type macros *)
  TSND_SEQ_EVFLG_QUEUE = (
        SND_SEQ_EVFLG_QUEUE_NOARG,
        SND_SEQ_EVFLG_QUEUE_TICK,
        SND_SEQ_EVFLG_QUEUE_TIME,
        SND_SEQ_EVFLG_QUEUE_VALUE);

(**
Sequencer event data type
 *)
  Psnd_seq_event_type_t = ^snd_seq_event_type_t;
  snd_seq_event_type_t = cuchar;

(** Sequencer event type *)
  Psnd_seq_event_type = ^snd_seq_event_type;
  snd_seq_event_type = (
        (** system status; event data type = #snd_seq_result_t *)
        SND_SEQ_EVENT_SYSTEM = 0,
        (** returned result status; event data type = #snd_seq_result_t *)
        SND_SEQ_EVENT_RESULT,

        (** note on and off with duration; event data type = #snd_seq_ev_note_t *)
        SND_SEQ_EVENT_NOTE = 5,
        (** note on; event data type = #snd_seq_ev_note_t *)
        SND_SEQ_EVENT_NOTEON,
        (** note off; event data type = #snd_seq_ev_note_t *)
        SND_SEQ_EVENT_NOTEOFF,
        (** key pressure change (aftertouch); event data type = #snd_seq_ev_note_t *)
        SND_SEQ_EVENT_KEYPRESS,

        (** controller; event data type = #snd_seq_ev_ctrl_t *)
        SND_SEQ_EVENT_CONTROLLER = 10,
        (** program change; event data type = #snd_seq_ev_ctrl_t *)
        SND_SEQ_EVENT_PGMCHANGE,
        (** channel pressure; event data type = #snd_seq_ev_ctrl_t *)
        SND_SEQ_EVENT_CHANPRESS,
        (** pitchwheel; event data type = #snd_seq_ev_ctrl_t; data is from -8192 to 8191) *)
        SND_SEQ_EVENT_PITCHBEND,
        (** 14 bit controller value; event data type = #snd_seq_ev_ctrl_t *)
        SND_SEQ_EVENT_CONTROL14,
        (** 14 bit NRPN;  event data type = #snd_seq_ev_ctrl_t *)
        SND_SEQ_EVENT_NONREGPARAM,
        (** 14 bit RPN; event data type = #snd_seq_ev_ctrl_t *)
        SND_SEQ_EVENT_REGPARAM,

        (** SPP with LSB and MSB values; event data type = #snd_seq_ev_ctrl_t *)
        SND_SEQ_EVENT_SONGPOS = 20,
        (** Song Select with song ID number; event data type = #snd_seq_ev_ctrl_t *)
        SND_SEQ_EVENT_SONGSEL,
        (** midi time code quarter frame; event data type = #snd_seq_ev_ctrl_t *)
        SND_SEQ_EVENT_QFRAME,
        (** SMF Time Signature event; event data type = #snd_seq_ev_ctrl_t *)
        SND_SEQ_EVENT_TIMESIGN,
        (** SMF Key Signature event; event data type = #snd_seq_ev_ctrl_t *)
        SND_SEQ_EVENT_KEYSIGN,

        (** MIDI Real Time Start message; event data type = #snd_seq_ev_queue_control_t *)
        SND_SEQ_EVENT_START = 30,
        (** MIDI Real Time Continue message; event data type = #snd_seq_ev_queue_control_t *)
        SND_SEQ_EVENT_CONTINUE,
        (** MIDI Real Time Stop message; event data type = #snd_seq_ev_queue_control_t *)
        SND_SEQ_EVENT_STOP,
        (** Set tick queue position; event data type = #snd_seq_ev_queue_control_t *)
        SND_SEQ_EVENT_SETPOS_TICK,
        (** Set real-time queue position; event data type = #snd_seq_ev_queue_control_t *)
        SND_SEQ_EVENT_SETPOS_TIME,
        (** (SMF) Tempo event; event data type = #snd_seq_ev_queue_control_t *)
        SND_SEQ_EVENT_TEMPO,
        (** MIDI Real Time Clock message; event data type = #snd_seq_ev_queue_control_t *)
        SND_SEQ_EVENT_CLOCK,
        (** MIDI Real Time Tick message; event data type = #snd_seq_ev_queue_control_t *)
        SND_SEQ_EVENT_TICK,
        (** Queue timer skew; event data type = #snd_seq_ev_queue_control_t *)
        SND_SEQ_EVENT_QUEUE_SKEW,
        (** Sync position changed; event data type = #snd_seq_ev_queue_control_t *)
        SND_SEQ_EVENT_SYNC_POS,

        (** Tune request; event data type = none *)
        SND_SEQ_EVENT_TUNE_REQUEST = 40,
        (** Reset to power-on state; event data type = none *)
        SND_SEQ_EVENT_RESET,
        (** Active sensing event; event data type = none *)
        SND_SEQ_EVENT_SENSING,

        (** Echo-back event; event data type = any type *)
        SND_SEQ_EVENT_ECHO = 50,
        (** OSS emulation raw event; event data type = any type *)
        SND_SEQ_EVENT_OSS,

        (** New client has connected; event data type = #snd_seq_addr_t *)
        SND_SEQ_EVENT_CLIENT_START = 60,
        (** Client has left the system; event data type = #snd_seq_addr_t *)
        SND_SEQ_EVENT_CLIENT_EXIT,
        (** Client status/info has changed; event data type = #snd_seq_addr_t *)
        SND_SEQ_EVENT_CLIENT_CHANGE,
        (** New port was created; event data type = #snd_seq_addr_t *)
        SND_SEQ_EVENT_PORT_START,
        (** Port was deleted from system; event data type = #snd_seq_addr_t *)
        SND_SEQ_EVENT_PORT_EXIT,
        (** Port status/info has changed; event data type = #snd_seq_addr_t *)
        SND_SEQ_EVENT_PORT_CHANGE,

        (** Ports connected; event data type = #snd_seq_connect_t *)
        SND_SEQ_EVENT_PORT_SUBSCRIBED,
        (** Ports disconnected; event data type = #snd_seq_connect_t *)
        SND_SEQ_EVENT_PORT_UNSUBSCRIBED,

        (** user-defined event; event data type = any (fixed size) *)
        SND_SEQ_EVENT_USR0 = 90,
        (** user-defined event; event data type = any (fixed size) *)
        SND_SEQ_EVENT_USR1,
        (** user-defined event; event data type = any (fixed size) *)
        SND_SEQ_EVENT_USR2,
        (** user-defined event; event data type = any (fixed size) *)
        SND_SEQ_EVENT_USR3,
        (** user-defined event; event data type = any (fixed size) *)
        SND_SEQ_EVENT_USR4,
        (** user-defined event; event data type = any (fixed size) *)
        SND_SEQ_EVENT_USR5,
        (** user-defined event; event data type = any (fixed size) *)
        SND_SEQ_EVENT_USR6,
        (** user-defined event; event data type = any (fixed size) *)
        SND_SEQ_EVENT_USR7,
        (** user-defined event; event data type = any (fixed size) *)
        SND_SEQ_EVENT_USR8,
        (** user-defined event; event data type = any (fixed size) *)
        SND_SEQ_EVENT_USR9,

        (** system exclusive data (variable length);  event data type = #snd_seq_ev_ext_t *)
        SND_SEQ_EVENT_SYSEX = 130,
        (** error event;  event data type = #snd_seq_ev_ext_t *)
        SND_SEQ_EVENT_BOUNCE,
        (** reserved for user apps;  event data type = #snd_seq_ev_ext_t *)
        SND_SEQ_EVENT_USR_VAR0 = 135,
        (** reserved for user apps; event data type = #snd_seq_ev_ext_t *)
        SND_SEQ_EVENT_USR_VAR1,
        (** reserved for user apps; event data type = #snd_seq_ev_ext_t *)
        SND_SEQ_EVENT_USR_VAR2,
        (** reserved for user apps; event data type = #snd_seq_ev_ext_t *)
        SND_SEQ_EVENT_USR_VAR3,
        (** reserved for user apps; event data type = #snd_seq_ev_ext_t *)
        SND_SEQ_EVENT_USR_VAR4,

        (** NOP; ignored in any case *)
        SND_SEQ_EVENT_NONE = 255);

(** Sequencer event address *)
  Psnd_seq_addr_t = ^snd_seq_addr_t;
  snd_seq_addr_t = record
        client: cuchar;  (**< Client id *)
        port: cuchar;  (**< Port id *)
  end;

(** Connection (subscription) between ports *)
  Psnd_seq_connect_t = ^snd_seq_connect_t;
  snd_seq_connect_t = record
        sender: snd_seq_addr_t;  (**< sender address *)
        dest: snd_seq_addr_t;   (**< destination address *)
  end;

(** Real-time data record *)
  Psnd_seq_real_time_t = ^snd_seq_real_time_t;
  snd_seq_real_time_t = record
        tv_sec: cuint;  (**< seconds *)
        tv_nsec: cuint;  (**< nanoseconds *)
  end;

(** (MIDI) Tick-time data record *)
  Psnd_seq_tick_time_t = ^snd_seq_tick_time_t;
  snd_seq_tick_time_t = cuint;

(** Unioned time stamp *)
  Psnd_seq_timestamp_t = ^snd_seq_timestamp_t;
  snd_seq_timestamp_t = record
    case Integer of
      0: (
          tick: snd_seq_tick_time_t;  (**< tick-time *)
        );
      1: (
          time: snd_seq_real_time_t;  (**< real-time *)
        );
  end;

(** Note event *)
  Psnd_seq_ev_note_t = ^snd_seq_ev_note_t;
  snd_seq_ev_note_t = record
    channel: cuchar;  (**< channel number *)
    note: cuchar;  (**< note *)
    velocity: cuchar;  (**< velocity *)
    off_velocity: cuchar;  (**< note-off velocity; only for #SND_SEQ_EVENT_NOTE *)
    duration: cuint;  (**< duration until note-off; only for #SND_SEQ_EVENT_NOTE *)
  end;

(** Controller event *)
  Psnd_seq_ev_ctrl_t = ^snd_seq_ev_ctrl_t;
  snd_seq_ev_ctrl_t = record
    channel: cuchar;  (**< channel number *)
    unused: array [0..2] of cuchar;  (**< reserved *)
    param: cuint;  (**< control parameter *)
    value: cint;  (**< control value *)
  end;

(** Generic set of bytes (12x8 bit) *)
  Psnd_seq_ev_raw8_t = ^snd_seq_ev_raw8_t;
  snd_seq_ev_raw8_t = record
    d: array [0..11] of cuchar;  (**< 8 bit value *)
  end;

(** Generic set of integers (3x32 bit) *)
  Psnd_seq_ev_raw32_t = ^snd_seq_ev_raw32_t;
  snd_seq_ev_raw32_t = record
    d: array [0..2] of cuint;  (**< 32 bit value *)
  end;

(** External stored data *)
  Psnd_seq_ev_ext_t = ^snd_seq_ev_ext_t;
  snd_seq_ev_ext_t = {__attribute__((packed))} packed record
    len: cuint;  (**< length of data *)
    ptr: Pointer;  (**< pointer to data (note: can be 64-bit) *)
  end;

(** Result events *)
  Psnd_seq_result_t = ^snd_seq_result_t;
  snd_seq_result_t = record
    event: cint;  (**< processed event type *)
    result: cint;  (**< status *)
  end;

(** Queue skew values *)
  Psnd_seq_queue_skew_t = ^snd_seq_queue_skew_t;
  snd_seq_queue_skew_t = record
    value: cuint;  (**< skew value *)
    base: cuint;  (**< skew base *)
  end;

(** Queue timer control *)
  Psnd_seq_ev_queue_control_t = ^snd_seq_ev_queue_control_t;
  snd_seq_ev_queue_control_t = record
    queue: cuchar;  (**< affected queue *)
    unused: array [0..2] of cuchar;  (**< reserved *)
    param: record  (**< data value union *)
      case Integer of
        0: (
          value: cint;  (**< affected value (e.g. tempo) *)
        );
        1: (
          time: snd_seq_timestamp_t;  (**< time *)
        );
        2: (
          position: cuint;  (**< sync position *)
        );
        3: (
          skew: snd_seq_queue_skew_t;  (**< queue skew *)
        );
        4: (
          d32: array [0..1] of cuint;  (**< any data *)
        );
        5: (
          d8: array [0..7] of cuchar;  (**< any data *)
        );
    end;
  end;

(** Sequencer event *)
  PPsnd_seq_event_t = ^Psnd_seq_event_t;
  Psnd_seq_event_t = ^snd_seq_event_t;
  snd_seq_event_t = record
    type_: snd_seq_event_type_t;  (**< event type *)
    flags: cuchar;  (**< event flags *)
    tag: cuchar;  (**< tag *)
    queue: cuchar;  (**< schedule queue *)
    time: snd_seq_timestamp_t;  (**< schedule time *)

    source: snd_seq_addr_t;  (**< source address *)
    dest: snd_seq_addr_t;  (**< destination address *)

    data: record  (**< event data... *)
      case Integer of
        0: (
          note: snd_seq_ev_note_t;  (**< note information *)
        );
        1: (
          control: snd_seq_ev_ctrl_t;  (**< MIDI control information *)
        );
        2: (
          raw8: snd_seq_ev_raw8_t;  (**< raw8 data *)
        );
        3: (
          raw32: snd_seq_ev_raw32_t;  (**< raw32 data *)
        );
        4: (
          ext: snd_seq_ev_ext_t;  (**< external data *)
        );
        5: (
          queue: snd_seq_ev_queue_control_t;  (**< queue control *)
        );
        6: (
          time: snd_seq_timestamp_t;  (**< timestamp *)
        );
        7: (
          addr: snd_seq_addr_t;  (**< address *)
        );
        8: (
          connect: snd_seq_connect_t;  (**< connect information *)
        );
        9: (
          result: snd_seq_result_t;  (**< operation result code *)
        );
    end;
  end;

(** Internal structure for a configuration node object.
 *
The ALSA library uses a pointer to this structure as a handle to a
configuration node. Applications don't access its contents directly.
 *)
  PPsnd_config_t = ^Psnd_config_t;
  Psnd_config_t = ^snd_config_t;
  snd_config_t = record
  end;

{ timer identification structure }
  PPsnd_timer_id_t = ^Psnd_timer_id_t;
  Psnd_timer_id_t = ^snd_timer_id_t;
  snd_timer_id_t = record
  end;

{$endif TYPES  }

{$ifdef PROCS  }

// fpalsa defines these in seq.inc:


(* Open the ALSA sequencer.

Parameters
    seqp	Pointer to a snd_seq_t pointer. This pointer must be kept and passed to most of the other sequencer functions.
    name	The sequencer's "name". This is not a name you make up for your own purposes; it has special significance to the ALSA library. Usually you need to pass "default" here.
    streams	The read/write mode of the sequencer. Can be one of three values:

        SND_SEQ_OPEN_OUTPUT - open the sequencer for output only
        SND_SEQ_OPEN_INPUT - open the sequencer for input only
        SND_SEQ_OPEN_DUPLEX - open the sequencer for output and input

Note
    Internally, these are translated to O_WRONLY, O_RDONLY and O_RDWR respectively and used as the second argument to the C library open() call.

Parameters
    mode	Optional modifier. Can be either 0, or SND_SEQ_NONBLOCK, which will make read/write operations non-blocking. This can also be set later using snd_seq_nonblock().

Returns
    0 on success otherwise a negative error code

Creates a new handle and opens a connection to the kernel sequencer interface. After a client is created successfully, an event with SND_SEQ_EVENT_CLIENT_START is broadcast to announce port.
*)
function snd_seq_open(handle: PPsnd_seq_t; name: PChar; streams: cint; mode: cint): cint; cdecl; LIBASOUND__


(* Open the ALSA sequencer using local configuration.

Parameters
    seqp	Pointer to a snd_seq_t pointer.
    name	The name to open
    streams	The read/write mode of the sequencer.
    mode	Optional modifier
    lconf	Local configuration

Returns
    0 on success otherwise a negative error code

See the snd_seq_open() function for further details. The extension is that the given configuration is used to resolve abstract name.
*)
function snd_seq_open_lconf(handle: PPsnd_seq_t; name: PChar; streams: cint; mode: cint; lconf: Psnd_config_t): cint; cdecl; LIBASOUND__


(* Get identifier of sequencer handle.

Parameters
    seq	        sequencer handle

Returns
    ASCII identifier of sequencer handle

Returns the ASCII identifier of the given sequencer handle. It's the same identifier specified in snd_seq_open().
*)
function snd_seq_name(seq: Psnd_seq_t): PChar; cdecl; LIBASOUND__


(* Get type of sequencer handle

Parameters
    seq	        sequencer handle

Returns
    Type of sequencer handle

Returns the type snd_seq_type_t of the given sequencer handle.
*)
function snd_seq_type(seq: Psnd_seq_t): snd_seq_type_t; cdecl; LIBASOUND__


(* Close the sequencer.

Parameters
    seq	Handle returned from snd_seq_open()

Returns
    0 on success otherwise a negative error code

Closes the sequencer client and releases its resources. After a client is closed, an event with SND_SEQ_EVENT_CLIENT_EXIT is broadcast to announce port. The connection between other clients are disconnected. Call this just before exiting your program.
*)
function snd_seq_close(handle: Psnd_seq_t): cint; cdecl; LIBASOUND__


(* Returns the number of poll descriptors.

Parameters
    seq	        sequencer handle
    events	the poll events to be checked (POLLIN and POLLOUT)

Returns
    The number of poll descriptors.

Get the number of poll descriptors. The polling events to be checked can be specified by the second argument. When both input and output are checked, pass POLLIN|POLLOUT
*)
function snd_seq_poll_descriptors_count(handle: Psnd_seq_t; events: cshort): cint; cdecl; LIBASOUND__


(* Get poll descriptors.

Parameters
    seq	        sequencer handle
    pfds	array of poll descriptors
    space	space in the poll descriptor array
    events	polling events to be checked (POLLIN and POLLOUT)

Returns
    count of filled descriptors

Get poll descriptors assigned to the sequencer handle. Since a sequencer handle can duplex streams, you need to set which direction(s) is/are polled in events argument. When POLLIN bit is specified, the incoming events to the ports are checked.

To check the returned poll-events, call snd_seq_poll_descriptors_revents() instead of reading the pollfd structs directly.
*)
function snd_seq_poll_descriptors(handle: Psnd_seq_t; pfds: {struct pollfd*}Pointer; space: cuint; events: cshort): cint; cdecl; LIBASOUND__
{$INFO pollfd?}


(* Get returned events from poll descriptors

Parameters
    seq	        sequencer handle
    pfds	array of poll descriptors
    nfds	count of poll descriptors
    revents	returned events

Returns
    zero if success, otherwise a negative error code
*)
function snd_seq_poll_descriptors_revents(seq: Psnd_seq_t; pfds: {struct pollfd*}Pointer; nfds: cuint; revents: Pcushort): cint; cdecl; LIBASOUND__
{$INFO pollfd?}


(* Set nonblock mode.

Parameters
    seq	        sequencer handle
    nonblock	0 = block, 1 = nonblock mode

Returns
    0 on success otherwise a negative error code

Change the blocking mode of the given client. In block mode, the client falls into sleep when it fills the output memory pool with full events. The client will be woken up after a certain amount of free space becomes available.

NOTE: fpalsa refers to this as snd_seq_set_nonblock().
*)
function snd_seq_nonblock(handle: Psnd_seq_t; nonblock: cint): cint; cdecl; LIBASOUND__
{$INFO Fpalsa calls this snd_seq_set_nonblock(), because pascal isn't case sensitive, }
{$INFO However the defToSDUnits utility does not have support for explicit external names. }


(* Get the client id.

Parameters
    seq	        sequencer handle

Returns
  the client id

Returns the id of the specified client. If an error occurs, function returns the negative error code. A client id is necessary to inquiry or to set the client information. A user client is assigned from 128 to 191.
*)
function snd_seq_client_id(handle: Psnd_seq_t): cint; cdecl; LIBASOUND__


(* Return the size of output buffer.

Parameters
    seq	        sequencer handle

Returns
    the size of output buffer in bytes

Obtains the size of output buffer. This buffer is used to store decoded byte-stream of output events before transferring to sequencer.
*)
function snd_seq_get_output_buffer_size(handle: Psnd_seq_t): size_t; cdecl; LIBASOUND__


(* Return the size of input buffer.

Parameters
    seq	        sequencer handle

Returns
    The size of input buffer in bytes

Obtains the size of input buffer. This buffer is used to read byte-stream of input events from sequencer.
*)
function snd_seq_get_input_buffer_size(handle: Psnd_seq_t): size_t; cdecl; LIBASOUND__


(* Change the size of output buffer.

Parameters
    seq	        sequencer handle
    size	the size of output buffer to be changed in bytes

Returns
    0 on success otherwise a negative error code

Changes the size of output buffer.
*)
function snd_seq_set_output_buffer_size(handle: Psnd_seq_t; size: size_t): cint; cdecl; LIBASOUND__


(* Resize the input buffer.

Parameters
    seq	        sequencer handle
    size	the size of input buffer to be changed in bytes

Returns
    0 on success otherwise a negative error code

Changes the size of input buffer.
*)
function snd_seq_set_input_buffer_size(handle: Psnd_seq_t; size: size_t): cint; cdecl; LIBASOUND__


(* Get size of snd_seq_system_info_t.

Returns
    size in bytes
*)
function snd_seq_system_info_sizeof: size_t; cdecl; LIBASOUND__


(*Allocate an empty snd_seq_system_info_t using standard malloc.

Parameters
    ptr	        returned pointer

Returns
    0 on success otherwise negative error code
*)
function snd_seq_system_info_malloc(ptr: PPsnd_seq_system_info_t): cint; cdecl; LIBASOUND__

(* Frees a previously allocated snd_seq_system_info_t.

Parameters
    obj	        pointer to object to free
*)
procedure snd_seq_system_info_free(ptr: Psnd_seq_system_info_t); cdecl; LIBASOUND__


(* Copy one snd_seq_system_info_t to another.

Parameters
    dst	        pointer to destination
    src	        pointer to source
*)
procedure snd_seq_system_info_copy(dst: Psnd_seq_system_info_t; src: Psnd_seq_system_info_t); cdecl; LIBASOUND__


(* Get maximum number of queues.

Parameters
    info	snd_seq_system_info_t container

Returns
    Maximum number of queues
*)
function snd_seq_system_info_get_queues(info: Psnd_seq_system_info_t): cint; cdecl; LIBASOUND__


(* Get maximum number of clients.

Parameters
    info	snd_seq_system_info_t container

Returns
    Maximum number of clients
*)
function snd_seq_system_info_get_clients(info: Psnd_seq_system_info_t): cint; cdecl; LIBASOUND__


(* Get maximum number of ports.

Parameters
    info	snd_seq_system_info_t container

Returns
    Maximum number of ports
*)
function snd_seq_system_info_get_ports(info: Psnd_seq_system_info_t): cint; cdecl; LIBASOUND__


(*Get maximum number of channels.

Parameters
    info	snd_seq_system_info_t container

Returns
    Maximum number of channels
*)
function snd_seq_system_info_get_channels(info: Psnd_seq_system_info_t): cint; cdecl; LIBASOUND__


(* Get the current number of clients.

Parameters
    info	snd_seq_system_info_t container

Returns
    Current number of clients
*)
function snd_seq_system_info_get_cur_clients(info: Psnd_seq_system_info_t): cint; cdecl; LIBASOUND__


(* Get the current number of queues.

Parameters
    info	snd_seq_system_info_t container

Returns
    Current number of queues
*)
function snd_seq_system_info_get_cur_queues(info: Psnd_seq_system_info_t): cint; cdecl; LIBASOUND__


(* Obtain the sequencer system information

Parameters
    seq	        sequencer handle
    info	the pointer to be stored

Returns
    0 on success otherwise a negative error code
*)
function snd_seq_system_info(handle: Psnd_seq_t; info: Psnd_seq_system_info_t): cint; cdecl; LIBASOUND__


(* Get size of snd_seq_client_info_t

Returns
    size in bytes
*)
function snd_seq_client_info_sizeof: size_t; cdecl; LIBASOUND__


(* Allocate an empty snd_seq_client_info_t using standard malloc

Parameters
    ptr	returned pointer

Returns
    0 on success otherwise negative error code
*)
function snd_seq_client_info_malloc(ptr: PPsnd_seq_client_info_t): cint; cdecl; LIBASOUND__


(* Frees a previously allocated snd_seq_client_info_t

Parameters
    obj	pointer to object to free
*)
procedure snd_seq_client_info_free(ptr: Psnd_seq_client_info_t); cdecl; LIBASOUND__


(* Copy one snd_seq_client_info_t to another

Parameters
    dst	        pointer to destination
    src	        pointer to source
*)
procedure snd_seq_client_info_copy(dst: Psnd_seq_client_info_t; src: Psnd_seq_client_info_t); cdecl; LIBASOUND__


(* Get client id of a client_info container.

Parameters
    info	client_info container

Returns
    client id
*)
function snd_seq_client_info_get_client(info: Psnd_seq_client_info_t): cint; cdecl; LIBASOUND__


(* Get client type of a client_info container.

Parameters
    info	client_info container

Returns
    client type

The client type is either SND_SEQ_KERNEL_CLIENT or SND_SEQ_USER_CLIENT for kernel or user client respectively.
*)
function snd_seq_client_info_get_type(info: Psnd_seq_client_info_t): snd_seq_client_type_t; cdecl; LIBASOUND__


(* Get the name of a client_info container.

Parameters
    info	client_info container

Returns
    name string
*)
function snd_seq_client_info_get_name(info: Psnd_seq_client_info_t): PChar; cdecl; LIBASOUND__


(* Get the broadcast filter usage of a client_info container.

Parameters
    info	client_info container

Returns
    1 if broadcast is accepted
*)
function snd_seq_client_info_get_broadcast_filter(info: Psnd_seq_client_info_t): cint; cdecl; LIBASOUND__


(* Get the error-bounce usage of a client_info container.

Parameters
    info	client_info container

Returns
    1 if error-bounce is enabled
*)
function snd_seq_client_info_get_error_bounce(info: Psnd_seq_client_info_t): cint; cdecl; LIBASOUND__


(* (DEPRECATED) Get the event filter bitmap of a client_info container

Parameters
    info	client_info container

Returns
    NULL if no event filter, or pointer to event filter bitmap

    Use snd_seq_client_info_event_filter_check() instead.
*)
function snd_seq_client_info_get_event_filter(info: Psnd_seq_client_info_t): Pcuchar; cdecl; LIBASOUND__


(* Get the number of opened ports of a client_info container.

Parameters
    info	client_info container

Returns
    Number of opened ports
*)
function snd_seq_client_info_get_num_ports(info: Psnd_seq_client_info_t): cint; cdecl; LIBASOUND__


(* Get the number of lost events of a client_info container.

Parameters
    info	client_info container

Returns
    Number of lost events
*)
function snd_seq_client_info_get_event_lost(info: Psnd_seq_client_info_t): cint; cdecl; LIBASOUND__


(* Set the client id of a client_info container.

Parameters
    info	client_info container
    client	client id
*)
procedure snd_seq_client_info_set_client(info: Psnd_seq_client_info_t; client: cint); cdecl; LIBASOUND__


(* Set the name of a client_info container.

Parameters
    info	client_info container
    name	name string
*)
procedure snd_seq_client_info_set_name(info: Psnd_seq_client_info_t; name: PChar); cdecl; LIBASOUND__


(* Set the broadcast filter usage of a client_info container.

Parameters
    info	client_info container
    val	non-zero if broadcast is accepted
*)
procedure snd_seq_client_info_set_broadcast_filter(info: Psnd_seq_client_info_t; val: cint); cdecl; LIBASOUND__


(* Set the error-bounce usage of a client_info container.

Parameters
    info	client_info container
    val	non-zero if error is bounced
*)
procedure snd_seq_client_info_set_error_bounce(info: Psnd_seq_client_info_t; val: cint); cdecl; LIBASOUND__


(* (DEPRECATED) Set the event filter bitmap of a client_info container

Parameters
    info	client_info container
    filter	event filter bitmap, pass NULL for no event filtering

Use snd_seq_client_info_event_filter_add instead.
*)
procedure snd_seq_client_info_set_event_filter(info: Psnd_seq_client_info_t; filter: Pcuchar); cdecl; LIBASOUND__


(* Disable event filtering of a client_info container.

Parameters
    info	client_info container

Remove all event types added with snd_seq_client_info_event_filter_add and clear the event filtering flag of this client_info container.
*)
procedure snd_seq_client_info_event_filter_clear(info: Psnd_seq_client_info_t); cdecl; LIBASOUND__


(* Add an event type to the event filtering of a client_info container.

Parameters
    info	client_info container
    event_type	event type to be added

Set the event filtering flag of this client_info and add the specified event type to the filter bitmap of this client_info container.
*)
procedure snd_seq_client_info_event_filter_add(info: Psnd_seq_client_info_t; event_type: cint); cdecl; LIBASOUND__


(* Remove an event type from the event filtering of a client_info container.

Parameters
    info	client_info container
    event_type	event type to be removed

Removes the specified event from the filter bitmap of this client_info container. It will not clear the event filtering flag, use snd_seq_client_info_event_filter_clear instead.
*)
procedure snd_seq_client_info_event_filter_del(info: Psnd_seq_client_info_t; event_type: cint); cdecl; LIBASOUND__


(* Check if an event type is present in the event filtering of a client_info container.

Parameters
    info	client_info container
    event_type	event type to be checked

Returns
    1 if the event type is present, 0 otherwise

Test if the event type is in the filter bitmap of this client_info container.
*)
function snd_seq_client_info_event_filter_check(info: Psnd_seq_client_info_t; event_type: cint): cint; cdecl; LIBASOUND__


(* Obtain the current client information

Parameters
    seq	        sequencer handle
    info	the pointer to be stored

Returns
    0 on success otherwise a negative error code

Obtains the information of the current client stored on info. client and type fields are ignored.
*)
function snd_seq_get_client_info(handle: Psnd_seq_t; info: Psnd_seq_client_info_t): cint; cdecl; LIBASOUND__


(* Obtain the information of the given client

Parameters
    seq	        sequencer handle
    client	client id
    info	the pointer to be stored

Returns
    0 on success otherwise a negative error code

Obtains the information of the client with a client id specified by info argument. The obtained information is written on info parameter.
*)
function snd_seq_get_any_client_info(handle: Psnd_seq_t; client: cint; info: Psnd_seq_client_info_t): cint; cdecl; LIBASOUND__


(* Set the current client information

Parameters
    seq	        sequencer handle
    info	the client info data to set

Returns
    0 on success otherwise a negative error code

Obtains the information of the current client stored on info. client and type fields are ignored.
*)
function snd_seq_set_client_info(handle: Psnd_seq_t; info: Psnd_seq_client_info_t): cint; cdecl; LIBASOUND__


(* Query the next client

Parameters
    seq	sequencer handle
    info	query pattern and result

Queries the next client. The search begins at the client with an id one greater than client field in info. If a client is found, its attributes are stored in info, and zero is returned. Otherwise returns a negative error code.
*)
function snd_seq_query_next_client(handle: Psnd_seq_t; info: Psnd_seq_client_info_t): cint; cdecl; LIBASOUND__


(* Get size of snd_seq_client_pool_t

Returns
    size in bytes
*)
function snd_seq_client_pool_sizeof: size_t; cdecl; LIBASOUND__


(* Allocate an empty snd_seq_client_pool_t using standard malloc

Parameters
    ptr	        returned pointer

Returns
    0 on success otherwise negative error code
*)
function snd_seq_client_pool_malloc(ptr: PPsnd_seq_client_pool_t): cint; cdecl; LIBASOUND__


(* Frees a previously allocated snd_seq_client_pool_t

Parameters
    obj	        pointer to object to free
*)
procedure snd_seq_client_pool_free(ptr: Psnd_seq_client_pool_t); cdecl; LIBASOUND__


(* Copy one snd_seq_client_pool_t to another

Parameters
    dst	        pointer to destination
    src	        pointer to source
*)
procedure snd_seq_client_pool_copy(dst: Psnd_seq_client_pool_t; src: Psnd_seq_client_pool_t); cdecl; LIBASOUND__


(* Get the client id of a queue_info container.

Parameters
    info	client_pool container

Returns
    client id
*)
function snd_seq_client_pool_get_client(info: Psnd_seq_client_pool_t): cint; cdecl; LIBASOUND__


(* Get the output pool size of a queue_info container.

Parameters
    info	client_pool container

Returns
    output pool size
*)
function snd_seq_client_pool_get_output_pool(info: Psnd_seq_client_pool_t): size_t; cdecl; LIBASOUND__


(*Get the input pool size of a queue_info container.

Parameters
    info	client_pool container

Returns
    input pool size
*)
function snd_seq_client_pool_get_input_pool(info: Psnd_seq_client_pool_t): size_t; cdecl; LIBASOUND__


(* Get the output room size of a queue_info container.

Parameters
    info	client_pool container

Returns
    output room size
*)
function snd_seq_client_pool_get_output_room(info: Psnd_seq_client_pool_t): size_t; cdecl; LIBASOUND__


(* Get the available size on output pool of a queue_info container.

Parameters
    info	client_pool container

Returns
    available output size
*)
function snd_seq_client_pool_get_output_free(info: Psnd_seq_client_pool_t): size_t; cdecl; LIBASOUND__


(* Get the available size on input pool of a queue_info container.

Parameters
    info	client_pool container

Returns
    available input size
*)
function snd_seq_client_pool_get_input_free(info: Psnd_seq_client_pool_t): size_t; cdecl; LIBASOUND__


(* Set the output pool size of a queue_info container.

Parameters
    info	client_pool container
    size	output pool size
*)
procedure snd_seq_client_pool_set_output_pool(info: Psnd_seq_client_pool_t; size: size_t); cdecl; LIBASOUND__


(* Set the input pool size of a queue_info container.

Parameters
    info	client_pool container
    size	input pool size
*)
procedure snd_seq_client_pool_set_input_pool(info: Psnd_seq_client_pool_t; size: size_t); cdecl; LIBASOUND__


(* Set the output room size of a queue_info container.

Parameters
    info	client_pool container
    size	output room size
*)
procedure snd_seq_client_pool_set_output_room(info: Psnd_seq_client_pool_t; size: size_t); cdecl; LIBASOUND__


(* Obtain the pool information of the current client

Parameters
    seq	        sequencer handle
    info	information to be stored
*)
function snd_seq_get_client_pool(handle: Psnd_seq_t; info: Psnd_seq_client_pool_t): cint; cdecl; LIBASOUND__


(* Set the pool information

Parameters
    seq	        sequencer handle
    info	information to update

Sets the pool information of the current client. The client field in info is replaced automatically with the current id.
*)
function snd_seq_set_client_pool(handle: Psnd_seq_t; info: Psnd_seq_client_pool_t): cint; cdecl; LIBASOUND__


(* Get size of snd_seq_port_info_t

Returns
    size in bytes
*)
function snd_seq_port_info_sizeof: size_t; cdecl; LIBASOUND__


(* Allocate an empty snd_seq_port_info_t using standard malloc

Parameters
    ptr	returned pointer

Returns
    0 on success otherwise negative error code
*)
function snd_seq_port_info_malloc(ptr: PPsnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* Frees a previously allocated snd_seq_port_info_t

Parameters
    obj	pointer to object to free
*)
procedure snd_seq_port_info_free(ptr: Psnd_seq_port_info_t); cdecl; LIBASOUND__


(* Copy one snd_seq_port_info_t to another

Parameters
    dst	        pointer to destination
    src	        pointer to source
*)
procedure snd_seq_port_info_copy(dst: Psnd_seq_port_info_t; src: Psnd_seq_port_info_t); cdecl; LIBASOUND__


(* Get client id of a port_info container.

Parameters
    info	port_info container

Returns
    client id
*)
function snd_seq_port_info_get_client(info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* Get port id of a port_info container.

Parameters
    info	port_info container

Returns
    port id
*)
function snd_seq_port_info_get_port(info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* Get client/port address of a port_info container.

Parameters
    info	port_info container

Returns
    client/port address pointer
*)
function snd_seq_port_info_get_addr(info: Psnd_seq_port_info_t): Psnd_seq_addr_t; cdecl; LIBASOUND__


(* Get the name of a port_info container.

Parameters
    info	port_info container

Returns
    name string
*)
function snd_seq_port_info_get_name(info: Psnd_seq_port_info_t): PChar; cdecl; LIBASOUND__


(* Get the capability bits of a port_info container.

Parameters
    info	port_info container

Returns
    capability bits
*)
function snd_seq_port_info_get_capability(info: Psnd_seq_port_info_t): cuint; cdecl; LIBASOUND__


(* Get the type bits of a port_info container.

Parameters
    info	port_info container

Returns
    port type bits
*)
function snd_seq_port_info_get_type(info: Psnd_seq_port_info_t): cuint; cdecl; LIBASOUND__


(* Get the midi channels of a port_info container.

Parameters
    info	port_info container

Returns
    number of midi channels (default 0)
*)
function snd_seq_port_info_get_midi_channels(info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* Get the midi voices of a port_info container.

Parameters
    info	port_info container

Returns
    number of midi voices (default 0)
*)
function snd_seq_port_info_get_midi_voices(info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* Get the synth voices of a port_info container.

Parameters
    info	port_info container

Returns
    number of synth voices (default 0)
*)
function snd_seq_port_info_get_synth_voices(info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* Get the number of read subscriptions of a port_info container.

Parameters
    info	port_info container

Returns
    number of read subscriptions
*)
function snd_seq_port_info_get_read_use(info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* Get the number of write subscriptions of a port_info container.

Parameters
    info	port_info container

Returns
    number of write subscriptions
*)
function snd_seq_port_info_get_write_use(info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* Get the port-specified mode of a port_info container.

Parameters
    info	port_info container

Returns
    1 if port id is specified at creation
*)
function snd_seq_port_info_get_port_specified(info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* Get the time-stamping mode of the given port in a port_info container.

Parameters
    info	port_info container

Returns
    1 if the port updates timestamps of incoming events
*)
function snd_seq_port_info_get_timestamping(info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(*Get whether the time-stamping of the given port is real-time mode.

Parameters
    info	port_info container

Returns
    1 if the time-stamping is in the real-time mode
*)
function snd_seq_port_info_get_timestamp_real(info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* Get the queue id to update timestamps.

Parameters
    info	port_info container

Returns
    the queue id to get the timestamps
*)
function snd_seq_port_info_get_timestamp_queue(info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* Set the client id of a port_info container.

Parameters
    info	port_info container
    client	client id
*)
procedure snd_seq_port_info_set_client(info: Psnd_seq_port_info_t; client: cint); cdecl; LIBASOUND__


(* Set the port id of a port_info container.

Parameters
    info	port_info container
    port	port id
*)
procedure snd_seq_port_info_set_port(info: Psnd_seq_port_info_t; port: cint); cdecl; LIBASOUND__


(* Set the client/port address of a port_info container.

Parameters
    info	port_info container
    addr	client/port address
*)
procedure snd_seq_port_info_set_addr(info: Psnd_seq_port_info_t; addr: Psnd_seq_addr_t); cdecl; LIBASOUND__


(* Set the name of a port_info container.

Parameters
    info	port_info container
    name	name string
*)
procedure snd_seq_port_info_set_name(info: Psnd_seq_port_info_t; name: PChar); cdecl; LIBASOUND__


(* set the capability bits of a port_info container

Parameters
    info	port_info container
    capability	capability bits
*)
procedure snd_seq_port_info_set_capability(info: Psnd_seq_port_info_t; capability: cuint); cdecl; LIBASOUND__


(* Get the type bits of a port_info container.

Parameters
    info	port_info container
    type	port type bits
*)
procedure snd_seq_port_info_set_type(info: Psnd_seq_port_info_t; _type: cuint); cdecl; LIBASOUND__


(* Set the midi channels of a port_info container

Parameters
    info	port_info container
    channels	midi channels (default 0)
*)
procedure snd_seq_port_info_set_midi_channels(info: Psnd_seq_port_info_t; channels: cint); cdecl; LIBASOUND__


(* Set the midi voices of a port_info container

Parameters
    info	port_info container
    voices	midi voices (default 0)
*)
procedure snd_seq_port_info_set_midi_voices(info: Psnd_seq_port_info_t; voices: cint); cdecl; LIBASOUND__


(* Set the synth voices of a port_info container

Parameters
    info	port_info container
    voices	synth voices (default 0)
*)
procedure snd_seq_port_info_set_synth_voices(info: Psnd_seq_port_info_t; voices: cint); cdecl; LIBASOUND__


(* Set the port-specified mode of a port_info container.

Parameters
    info	port_info container
    val	non-zero if specifying the port id at creation
*)
procedure snd_seq_port_info_set_port_specified(info: Psnd_seq_port_info_t; val: cint); cdecl; LIBASOUND__


(* Set the time-stamping mode of the given port.

Parameters
    info	port_info container
    enable	non-zero if updating the timestamps of incoming events
*)
procedure snd_seq_port_info_set_timestamping(info: Psnd_seq_port_info_t; enable: cint); cdecl; LIBASOUND__


(* Set whether the timestime is updated in the real-time mode.

Parameters
    info	port_info container
    enable	non-zero if updating the timestamps in real-time mode
*)
procedure snd_seq_port_info_set_timestamp_real(info: Psnd_seq_port_info_t; realtime: cint); cdecl; LIBASOUND__


(* Set the queue id for timestamping.

Parameters
    info	port_info container
    queue	the queue id to get timestamps
*)
procedure snd_seq_port_info_set_timestamp_queue(info: Psnd_seq_port_info_t; queue: cint); cdecl; LIBASOUND__


(* create a sequencer port on the current client

Parameters
    seq	sequencer handle
    port	port information for the new port

Returns
    0 on success otherwise a negative error code

Creates a sequencer port on the current client. The attributes of created port is specified in info argument.

The client field in info argument is overwritten with the current client id. The port id to be created can be specified via snd_seq_port_info_set_port_specified. You can get the created port id by reading the port pointer via snd_seq_port_info_get_port.

Each port has the capability bit-masks to specify the access capability of the port from other clients. The capability bit flags are defined as follows:

    SND_SEQ_PORT_CAP_READ Readable from this port
    SND_SEQ_PORT_CAP_WRITE Writable to this port.
    SND_SEQ_PORT_CAP_SYNC_READ For synchronization (not implemented)
    SND_SEQ_PORT_CAP_SYNC_WRITE For synchronization (not implemented)
    SND_SEQ_PORT_CAP_DUPLEX Read/write duplex access is supported
    SND_SEQ_PORT_CAP_SUBS_READ Read subscription is allowed
    SND_SEQ_PORT_CAP_SUBS_WRITE Write subscription is allowed
    SND_SEQ_PORT_CAP_NO_EXPORT Subscription management from 3rd client is disallowed

Each port has also the type bitmasks defined as follows:

    SND_SEQ_PORT_TYPE_SPECIFIC Hardware specific port
    SND_SEQ_PORT_TYPE_MIDI_GENERIC Generic MIDI device
    SND_SEQ_PORT_TYPE_MIDI_GM General MIDI compatible device
    SND_SEQ_PORT_TYPE_MIDI_GM2 General MIDI 2 compatible device
    SND_SEQ_PORT_TYPE_MIDI_GS GS compatible device
    SND_SEQ_PORT_TYPE_MIDI_XG XG compatible device
    SND_SEQ_PORT_TYPE_MIDI_MT32 MT-32 compatible device
    SND_SEQ_PORT_TYPE_HARDWARE Implemented in hardware
    SND_SEQ_PORT_TYPE_SOFTWARE Implemented in software
    SND_SEQ_PORT_TYPE_SYNTHESIZER Generates sound
    SND_SEQ_PORT_TYPE_PORT Connects to other device(s)
    SND_SEQ_PORT_TYPE_APPLICATION Application (sequencer/editor)

A port may contain specific midi channels, midi voices and synth voices. These values could be zero as default.
*)
function snd_seq_create_port(handle: Psnd_seq_t; info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* Delete a sequencer port on the current client

Parameters
    seq	        sequencer handle
    port	port to be deleted

Returns
    0 on success otherwise a negative error code

Deletes the existing sequencer port on the current client.
*)
function snd_seq_delete_port(handle: Psnd_seq_t; port: cint): cint; cdecl; LIBASOUND__


(* Obtain the information of a port on the current client

Parameters
    seq	        sequencer handle
    port	port id to get
    info	pointer information returns

Returns
    0 on success otherwise a negative error code
*)
function snd_seq_get_port_info(handle: Psnd_seq_t; port: cint; info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* Obtain the information of a port on an arbitrary client

Parameters
    seq	        sequencer handle
    client	client id to get
    port	port id to get
    info	pointer information returns

Returns
    0 on success otherwise a negative error code
*)
function snd_seq_get_any_port_info(handle: Psnd_seq_t; client: cint; port: cint; info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* Set the information of a port on the current client

Parameters
    seq	        sequencer handle
    port	port to be set
    info	port information to be set

Returns
    0 on success otherwise a negative error code
*)
function snd_seq_set_port_info(handle: Psnd_seq_t; port: cint; info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* Query the next matching port

Parameters
    seq	sequencer handle
    info	query pattern and result

Queries the next matching port on the client specified in info argument. The search begins at the next port specified in port field of info argument. For finding the first port at a certain client, give -1.

If a matching port is found, its attributes are stored on info and function returns zero. Otherwise, a negative error code is returned.
*)
function snd_seq_query_next_port(handle: Psnd_seq_t; info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* Get size of snd_seq_port_subscribe_t

Returns
    size in bytes
*)
function snd_seq_port_subscribe_sizeof: size_t; cdecl; LIBASOUND__


(* Allocate an empty snd_seq_port_subscribe_t using standard malloc

Parameters
    ptr	        returned pointer

Returns
    0 on success otherwise negative error code
*)
function snd_seq_port_subscribe_malloc(ptr: PPsnd_seq_port_subscribe_t): cint; cdecl; LIBASOUND__


(* Frees a previously allocated snd_seq_port_subscribe_t

Parameters
    obj	        pointer to object to free
*)
procedure snd_seq_port_subscribe_free(ptr: Psnd_seq_port_subscribe_t); cdecl; LIBASOUND__


(* Copy one snd_seq_port_subscribe_t to another

Parameters
    dst	        pointer to destination
    src	        pointer to source
*)
procedure snd_seq_port_subscribe_copy(dst: Psnd_seq_port_subscribe_t; src: Psnd_seq_port_subscribe_t); cdecl; LIBASOUND__


(* Get sender address of a port_subscribe container.

Parameters
    info	port_subscribe container
*)
function snd_seq_port_subscribe_get_sender(info: Psnd_seq_port_subscribe_t): Psnd_seq_addr_t; cdecl; LIBASOUND__


(* Get destination address of a port_subscribe container.

Parameters
    info	port_subscribe container
*)
function snd_seq_port_subscribe_get_dest(info: Psnd_seq_port_subscribe_t): Psnd_seq_addr_t; cdecl; LIBASOUND__


(* Get the queue id of a port_subscribe container.

Parameters
    info	port_subscribe container

Returns
    queue id
*)
function snd_seq_port_subscribe_get_queue(info: Psnd_seq_port_subscribe_t): cint; cdecl; LIBASOUND__


(* Get the exclusive mode of a port_subscribe container.

Parameters
    info	port_subscribe container

Returns
    1 if exclusive mode
*)
function snd_seq_port_subscribe_get_exclusive(info: Psnd_seq_port_subscribe_t): cint; cdecl; LIBASOUND__


(* Get the time-update mode of a port_subscribe container.

Parameters
    info	port_subscribe container

Returns
    1 if update timestamp
*)
function snd_seq_port_subscribe_get_time_update(info: Psnd_seq_port_subscribe_t): cint; cdecl; LIBASOUND__


(* Get the real-time update mode of a port_subscribe container.

Parameters
    info	port_subscribe container

Returns
    1 if real-time update mode
*)
function snd_seq_port_subscribe_get_time_real(info: Psnd_seq_port_subscribe_t): cint; cdecl; LIBASOUND__


(* Set sender address of a port_subscribe container.

Parameters
    info	port_subscribe container
    addr	sender address
*)
procedure snd_seq_port_subscribe_set_sender(info: Psnd_seq_port_subscribe_t; addr: Psnd_seq_addr_t); cdecl; LIBASOUND__


(* Set destination address of a port_subscribe container.

Parameters
    info	port_subscribe container
    addr	destination address
*)
procedure snd_seq_port_subscribe_set_dest(info: Psnd_seq_port_subscribe_t; addr: Psnd_seq_addr_t); cdecl; LIBASOUND__


(* Set the queue id of a port_subscribe container.

Parameters
    info	port_subscribe container
    q	        queue id
*)
procedure snd_seq_port_subscribe_set_queue(info: Psnd_seq_port_subscribe_t; q: cint); cdecl; LIBASOUND__


(* Set the exclusive mode of a port_subscribe container.

Parameters
    info	port_subscribe container
    val	        non-zero to enable
*)
procedure snd_seq_port_subscribe_set_exclusive(info: Psnd_seq_port_subscribe_t; val: cint); cdecl; LIBASOUND__


(* Set the time-update mode of a port_subscribe container.

Parameters
    info	port_subscribe container
    val	        non-zero to enable
*)
procedure snd_seq_port_subscribe_set_time_update(info: Psnd_seq_port_subscribe_t; val: cint); cdecl; LIBASOUND__


(* Set the real-time mode of a port_subscribe container.

Parameters
    info	port_subscribe container
    val	        non-zero to enable
*)
procedure snd_seq_port_subscribe_set_time_real(info: Psnd_seq_port_subscribe_t; val: cint); cdecl; LIBASOUND__


(* Obtain subscription information

Parameters
    seq	        sequencer handle
    sub	        pointer to return the subscription information

Returns
    0 on success otherwise a negative error code
*)
function snd_seq_get_port_subscription(handle: Psnd_seq_t; sub: Psnd_seq_port_subscribe_t): cint; cdecl; LIBASOUND__


(* Subscribe a port connection

Parameters
    seq	        sequencer handle
    sub	        subscription information
*)
function snd_seq_subscribe_port(handle: Psnd_seq_t; sub: Psnd_seq_port_subscribe_t): cint; cdecl; LIBASOUND__


(* Unsubscribe a connection between ports

Parameters
    seq	        sequencer handle
    sub	        subscription information to disconnect

Returns
    0 on success otherwise a negative error code

Unsubscribes a connection between two ports, described in sender and dest fields in sub argument.
*)
function snd_seq_unsubscribe_port(handle: Psnd_seq_t; sub: Psnd_seq_port_subscribe_t): cint; cdecl; LIBASOUND__


(* Get size of snd_seq_query_subscribe_t

Returns
    size in bytes
*)
function snd_seq_query_subscribe_sizeof: size_t; cdecl; LIBASOUND__


(* Allocate an empty snd_seq_query_subscribe_t using standard malloc

Parameters
    ptr	        returned pointer

Returns
    0 on success otherwise negative error code
*)
function snd_seq_query_subscribe_malloc(ptr: PPsnd_seq_query_subscribe_t): cint; cdecl; LIBASOUND__


(* Frees a previously allocated snd_seq_query_subscribe_t

Parameters
    obj	        pointer to object to free
*)
procedure snd_seq_query_subscribe_free(ptr: Psnd_seq_query_subscribe_t); cdecl; LIBASOUND__


(* Copy one snd_seq_query_subscribe_t to another

Parameters
    dst	        pointer to destination
    src	        pointer to source
*)
procedure snd_seq_query_subscribe_copy(dst: Psnd_seq_query_subscribe_t; src: Psnd_seq_query_subscribe_t); cdecl; LIBASOUND__


(* Get the client id of a query_subscribe container.

Parameters
    info	query_subscribe container

Returns
    client id
*)
function snd_seq_query_subscribe_get_client(info: Psnd_seq_query_subscribe_t): cint; cdecl; LIBASOUND__


(* Get the port id of a query_subscribe container.

Parameters
    info	query_subscribe container

Returns
    port id
*)
function snd_seq_query_subscribe_get_port(info: Psnd_seq_query_subscribe_t): cint; cdecl; LIBASOUND__


(* Get the client/port address of a query_subscribe container.

Parameters
    info	query_subscribe container

Returns
    client/port address pointer
*)
function snd_seq_query_subscribe_get_root(info: Psnd_seq_query_subscribe_t): Psnd_seq_addr_t; cdecl; LIBASOUND__


(* Get the query type of a query_subscribe container.

Parameters
    info	query_subscribe container

Returns
    query type
*)
function snd_seq_query_subscribe_get_type(info: Psnd_seq_query_subscribe_t): snd_seq_query_subs_type_t; cdecl; LIBASOUND__


(* Get the index of subscriber of a query_subscribe container.

Parameters
    info	query_subscribe container

Returns
    subscriber's index
*)
function snd_seq_query_subscribe_get_index(info: Psnd_seq_query_subscribe_t): cint; cdecl; LIBASOUND__


(* Get the number of subscriptions of a query_subscribe container.

Parameters
    info	query_subscribe container

Returns
    number of subscriptions
*)
function snd_seq_query_subscribe_get_num_subs(info: Psnd_seq_query_subscribe_t): cint; cdecl; LIBASOUND__


(* Get the address of subscriber of a query_subscribe container.

Parameters
    info	query_subscribe container

Returns
    subscriber's address pointer
*)
function snd_seq_query_subscribe_get_addr(info: Psnd_seq_query_subscribe_t): Psnd_seq_addr_t; cdecl; LIBASOUND__


(* Get the queue id of subscriber of a query_subscribe container.

Parameters
    info	query_subscribe container

Returns
    subscriber's queue id
*)
function snd_seq_query_subscribe_get_queue(info: Psnd_seq_query_subscribe_t): cint; cdecl; LIBASOUND__


(* Get the exclusive mode of a query_subscribe container.

Parameters
    info	query_subscribe container

Returns
    1 if exclusive mode
*)
function snd_seq_query_subscribe_get_exclusive(info: Psnd_seq_query_subscribe_t): cint; cdecl; LIBASOUND__


(* Get the time-update mode of a query_subscribe container.

Parameters
    info	query_subscribe container

Returns
    1 if update timestamp
*)
function snd_seq_query_subscribe_get_time_update(info: Psnd_seq_query_subscribe_t): cint; cdecl; LIBASOUND__


(* Get the real-time update mode of a query_subscribe container.

Parameters
    info	query_subscribe container

Returns
    1 if real-time update mode
*)
function snd_seq_query_subscribe_get_time_real(info: Psnd_seq_query_subscribe_t): cint; cdecl; LIBASOUND__


(* Set the client id of a query_subscribe container.

Parameters
    info	query_subscribe container
    client	client id
*)
procedure snd_seq_query_subscribe_set_client(info: Psnd_seq_query_subscribe_t; client: cint); cdecl; LIBASOUND__


(* Set the port id of a query_subscribe container.

Parameters
    info	query_subscribe container
    port	port id
*)
procedure snd_seq_query_subscribe_set_port(info: Psnd_seq_query_subscribe_t; port: cint); cdecl; LIBASOUND__


(* Set the client/port address of a query_subscribe container.

Parameters
    info	query_subscribe container
    addr	client/port address pointer
*)
procedure snd_seq_query_subscribe_set_root(info: Psnd_seq_query_subscribe_t; addr: Psnd_seq_addr_t); cdecl; LIBASOUND__


(* Set the query type of a query_subscribe container.

Parameters
    info	query_subscribe container
    type	query type
*)
procedure snd_seq_query_subscribe_set_type(info: Psnd_seq_query_subscribe_t; _type: snd_seq_query_subs_type_t); cdecl; LIBASOUND__


(* Set the subscriber's index to be queried.

Parameters
    info	query_subscribe container
    index	index to be queried
*)
procedure snd_seq_query_subscribe_set_index(info: Psnd_seq_query_subscribe_t; _index: cint); cdecl; LIBASOUND__


(* Query port subscriber list

Parameters
    seq        sequencer handle
    subs	subscription to query

Returns
    0 on success otherwise a negative error code
*)
function snd_seq_query_port_subscribers(seq: Psnd_seq_t; subs: Psnd_seq_query_subscribe_t): cint; cdecl; LIBASOUND__


(* Get size of snd_seq_queue_info_t

Returns
    size in bytes
*)
function snd_seq_queue_info_sizeof: size_t; cdecl; LIBASOUND__


(* Allocate an empty snd_seq_queue_info_t using standard malloc

Parameters
    ptr 	returned pointer

Returns
    0 on success otherwise negative error code
*)
function snd_seq_queue_info_malloc(ptr: PPsnd_seq_queue_info_t): cint; cdecl; LIBASOUND__


(* Frees a previously allocated snd_seq_queue_info_t

Parameters
    obj 	pointer to object to free
*)
procedure snd_seq_queue_info_free(ptr: Psnd_seq_queue_info_t); cdecl; LIBASOUND__


(* Copy one snd_seq_queue_info_t to another

Parameters
    dst 	pointer to destination
    src 	pointer to source
*)
procedure snd_seq_queue_info_copy(dst: Psnd_seq_queue_info_t; src: Psnd_seq_queue_info_t); cdecl; LIBASOUND__


(*
Get the queue id of a queue_info container.

Parameters
    info	queue_info container

Returns
    queue id
*)
function snd_seq_queue_info_get_queue(info: Psnd_seq_queue_info_t): cint; cdecl; LIBASOUND__


(* Get the name of a queue_info container.

Parameters
    info	queue_info container

Returns
    name string
*)
function snd_seq_queue_info_get_name(info: Psnd_seq_queue_info_t): PChar; cdecl; LIBASOUND__


(* Get the owner client id of a queue_info container.

Parameters
    info	queue_info container

Returns
    owner client id
*)
function snd_seq_queue_info_get_owner(info: Psnd_seq_queue_info_t): cint; cdecl; LIBASOUND__


(* Get the lock status of a queue_info container.

Parameters
    info	queue_info container

Returns
    lock status — non-zero = locked
*)
function snd_seq_queue_info_get_locked(info: Psnd_seq_queue_info_t): cint; cdecl; LIBASOUND__


(* Get the conditional bit flags of a queue_info container.

Parameters
    info	queue_info container

Returns
    conditional bit flags
*)
function snd_seq_queue_info_get_flags(info: Psnd_seq_queue_info_t): cuint; cdecl; LIBASOUND__


(* Set the name of a queue_info container.

Parameters
    info	queue_info container
    name	name string
*)
procedure snd_seq_queue_info_set_name(info: Psnd_seq_queue_info_t; name: PChar); cdecl; LIBASOUND__


(* Set the owner client id of a queue_info container.

Parameters
    info	queue_info container
    owner	client id
*)
procedure snd_seq_queue_info_set_owner(info: Psnd_seq_queue_info_t; owner: cint); cdecl; LIBASOUND__


(* Set the lock status of a queue_info container.

Parameters
    info	queue_info container
    locked	lock status
*)
procedure snd_seq_queue_info_set_locked(info: Psnd_seq_queue_info_t; locked: cint); cdecl; LIBASOUND__


(* Set the conditional bit flags of a queue_info container.

Parameters
    info	queue_info container
    flags	conditional bit flags
*)
procedure snd_seq_queue_info_set_flags(info: Psnd_seq_queue_info_t; flags: cuint); cdecl; LIBASOUND__


(* Create a queue

Parameters
    seq 	sequencer handle
    info	queue information to initialize

Returns
    the queue id (zero or positive) on success otherwise a negative error code
*)
function snd_seq_create_queue(seq: Psnd_seq_t; info: Psnd_seq_queue_info_t): cint; cdecl; LIBASOUND__


(* allocate a queue with the specified name

Parameters
    seq	sequencer handle
    name	the name of the new queue

Returns
    the queue id (zero or positive) on success otherwise a negative error code
*)
function snd_seq_alloc_named_queue(seq: Psnd_seq_t; name: PChar): cint; cdecl; LIBASOUND__


(* Allocate a queue

Parameters
    seq 	sequencer handle

Returns
    the queue id (zero or positive) on success otherwise a negative error code
*)
function snd_seq_alloc_queue(handle: Psnd_seq_t): cint; cdecl; LIBASOUND__


(* Delete the specified queue

Parameters
    seq	sequencer handle
    q	queue id to delete

Returns
    0 on success otherwise a negative error code
*)
function snd_seq_free_queue(handle: Psnd_seq_t; q: cint): cint; cdecl; LIBASOUND__


(* Obtain queue attributes

Parameters
   seq  	sequencer handle
   q    	queue id to query
   info 	information returned

Returns
    0 on success otherwise a negative error code
*)
function snd_seq_get_queue_info(seq: Psnd_seq_t; q: cint; info: Psnd_seq_queue_info_t): cint; cdecl; LIBASOUND__


(* Change the queue attributes

Parameters
    seq 	sequencer handle
    q   	queue id to change
    info	information changed

Returns
    0 on success otherwise a negative error code
*)
function snd_seq_set_queue_info(seq: Psnd_seq_t; q: cint; info: Psnd_seq_queue_info_t): cint; cdecl; LIBASOUND__


(* Query the matching queue with the specified name

Parameters
    seq 	sequencer handle
    name	the name string to query

Returns
    the queue id if found or negative error code

Searches the matching queue with the specified name string.
*)
function snd_seq_query_named_queue(seq: Psnd_seq_t; name: PChar): cint; cdecl; LIBASOUND__

function snd_seq_get_queue_usage(handle: Psnd_seq_t; q: cint): cint; cdecl; LIBASOUND__
function snd_seq_set_queue_usage(handle: Psnd_seq_t; q: cint; used: cint): cint; cdecl; LIBASOUND__


(* Get the queue usage flag to the client.

Parameters
    seq 	sequencer handle
    q   	queue id

Returns
    1 = client is allowed to access the queue, 0 = not allowed, otherwise a negative error code
*)
function snd_seq_queue_status_sizeof: size_t; cdecl; LIBASOUND__


(* Allocate an empty snd_seq_queue_status_t using standard malloc

Parameters
    ptr 	returned pointer

Returns
    0 on success otherwise negative error code
*)
function snd_seq_queue_status_malloc(ptr: PPsnd_seq_queue_status_t): cint; cdecl; LIBASOUND__


(* Frees a previously allocated snd_seq_queue_status_t

Parameters
    obj 	pointer to object to free
*)
procedure snd_seq_queue_status_free(ptr: Psnd_seq_queue_status_t); cdecl; LIBASOUND__


(* Copy one snd_seq_queue_status_t to another

Parameters
    dst 	pointer to destination
    src 	pointer to source
*)
procedure snd_seq_queue_status_copy(dst: Psnd_seq_queue_status_t; src: Psnd_seq_queue_status_t); cdecl; LIBASOUND__


(* Get the queue id of a queue_status container.

Parameters
    info	queue_status container

Returns
    queue id
*)
function snd_seq_queue_status_get_queue(info: Psnd_seq_queue_status_t): cint; cdecl; LIBASOUND__


(* Get the number of events of a queue_status container.

Parameters
    info	queue_status container

Returns
    number of events
*)
function snd_seq_queue_status_get_events(info: Psnd_seq_queue_status_t): cint; cdecl; LIBASOUND__


(* Get the tick time of a queue_status container.

Parameters
    info	queue_status container

Returns
    tick time
*)
function snd_seq_queue_status_get_tick_time(info: Psnd_seq_queue_status_t): snd_seq_tick_time_t; cdecl; LIBASOUND__


(* Get the real time of a queue_status container.

Parameters
    info	queue_status container
*)
function snd_seq_queue_status_get_real_time(info: Psnd_seq_queue_status_t): Psnd_seq_real_time_t; cdecl; LIBASOUND__


(* Get the running status bits of a queue_status container.

Parameters
    info	queue_status container

Returns
    running status bits
*)
function snd_seq_queue_status_get_status(info: Psnd_seq_queue_status_t): cuint; cdecl; LIBASOUND__


(* Obtain the running state of the queue

Parameters
    seq 	sequencer handle
    q   	queue id to query
    status	pointer to store the current status

Returns
    0 on success otherwise a negative error code

Obtains the running state of the specified queue q.
*)
function snd_seq_get_queue_status(handle: Psnd_seq_t; q: cint; status: Psnd_seq_queue_status_t): cint; cdecl; LIBASOUND__


(* Get size of snd_seq_queue_tempo_t

Returns
    size in bytes
*)
function snd_seq_queue_tempo_sizeof: size_t; cdecl; LIBASOUND__


(* Allocate an empty snd_seq_queue_tempo_t using standard malloc

Parameters
    ptr 	returned pointer

Returns
    0 on success otherwise negative error code
*)
function snd_seq_queue_tempo_malloc(ptr: PPsnd_seq_queue_tempo_t): cint; cdecl; LIBASOUND__


(* Frees a previously allocated snd_seq_queue_tempo_t

Parameters
    obj 	pointer to object to free
*)
procedure snd_seq_queue_tempo_free(ptr: Psnd_seq_queue_tempo_t); cdecl; LIBASOUND__


(* Copy one snd_seq_queue_tempo_t to another

Parameters
    dst 	pointer to destination
    src 	pointer to source
*)
procedure snd_seq_queue_tempo_copy(dst: Psnd_seq_queue_tempo_t; src: Psnd_seq_queue_tempo_t); cdecl; LIBASOUND__


(*Get the queue id of a queue_status container.

Parameters
    info	queue_status container

Returns
    queue id
*)
function snd_seq_queue_tempo_get_queue(info: Psnd_seq_queue_tempo_t): cint; cdecl; LIBASOUND__


(* Get the tempo of a queue_status container.

Parameters
    info	queue_status container

Returns
    tempo value
*)
function snd_seq_queue_tempo_get_tempo(info: Psnd_seq_queue_tempo_t): cuint; cdecl; LIBASOUND__


(* Get the ppq of a queue_status container.

Parameters
    info	queue_status container

Returns
    ppq value
*)
function snd_seq_queue_tempo_get_ppq(info: Psnd_seq_queue_tempo_t): cint; cdecl; LIBASOUND__


(* Get the timer skew value of a queue_status container.

Parameters
    info	queue_status container

Returns
    timer skew value
*)
function snd_seq_queue_tempo_get_skew(info: Psnd_seq_queue_tempo_t): cuint; cdecl; LIBASOUND__


(* Get the timer skew base value of a queue_status container.

Parameters
    info	queue_status container

Returns
    timer skew base value
*)
function snd_seq_queue_tempo_get_skew_base(info: Psnd_seq_queue_tempo_t): cuint; cdecl; LIBASOUND__


(* Set the tempo of a queue_status container.

Parameters
    info	queue_status container
    tempo	tempo value
*)
procedure snd_seq_queue_tempo_set_tempo(info: Psnd_seq_queue_tempo_t; tempo: cuint); cdecl; LIBASOUND__


(* Set the ppq of a queue_status container.

Parameters
    info	queue_status container
    ppq 	ppq value
*)
procedure snd_seq_queue_tempo_set_ppq(info: Psnd_seq_queue_tempo_t; ppq: cint); cdecl; LIBASOUND__


(* Set the timer skew value of a queue_status container.

Parameters
    info	queue_status container
    skew	timer skew value

The skew of timer is calculated as skew / base. For example, to play with double speed, pass base2 as the skew value.
*)
procedure snd_seq_queue_tempo_set_skew(info: Psnd_seq_queue_tempo_t; skew: cuint); cdecl; LIBASOUND__


(* Set the timer skew base value of a queue_status container.

Parameters
    info	queue_status container
    base	timer skew base value
*)
procedure snd_seq_queue_tempo_set_skew_base(info: Psnd_seq_queue_tempo_t; base: cuint); cdecl; LIBASOUND__


(* Obtain the current tempo of the queue

Parameters
    seq 	sequencer handle
    q   	queue id to be queried
    tempo	pointer to store the current tempo

Returns
    0 on success otherwise a negative error code
*)
function snd_seq_get_queue_tempo(handle: Psnd_seq_t; q: cint; tempo: Psnd_seq_queue_tempo_t): cint; cdecl; LIBASOUND__


(* Set the tempo of the queue

Parameters
    seq 	sequencer handle
    q   	queue id to change the tempo
    tempo	tempo information

Returns
    0 on success otherwise a negative error code
*)
function snd_seq_set_queue_tempo(handle: Psnd_seq_t; q: cint; tempo: Psnd_seq_queue_tempo_t): cint; cdecl; LIBASOUND__


(* Get size of snd_seq_queue_timer_t

Returns
    size in bytes
*)
function snd_seq_queue_timer_sizeof: size_t; cdecl; LIBASOUND__


(* Allocate an empty snd_seq_queue_timer_t using standard malloc

Parameters
    ptr 	returned pointer

Returns
    0 on success otherwise negative error code
*)
function snd_seq_queue_timer_malloc(ptr: PPsnd_seq_queue_timer_t): cint; cdecl; LIBASOUND__


(* Frees a previously allocated snd_seq_queue_timer_t

Parameters
    obj 	pointer to object to free
*)
procedure snd_seq_queue_timer_free(ptr: Psnd_seq_queue_timer_t); cdecl; LIBASOUND__


(* Copy one snd_seq_queue_timer_t to another

Parameters
    dst 	pointer to destination
    src 	pointer to source
*)
procedure snd_seq_queue_timer_copy(dst: Psnd_seq_queue_timer_t; src: Psnd_seq_queue_timer_t); cdecl; LIBASOUND__


(* Get the queue id of a queue_timer container.

Parameters
    info	queue_timer container

Returns
    queue id
*)
function snd_seq_queue_timer_get_queue(info: Psnd_seq_queue_timer_t): cint; cdecl; LIBASOUND__


(* Get the timer type of a queue_timer container.

Parameters
    info	queue_timer container

Returns
    timer type
*)
function snd_seq_queue_timer_get_type(info: Psnd_seq_queue_timer_t): snd_seq_queue_timer_type_t; cdecl; LIBASOUND__


(* Get the timer id of a queue_timer container.

Parameters
    info	queue_timer container

Returns
    timer id pointer
*)
function snd_seq_queue_timer_get_id(info: Psnd_seq_queue_timer_t): Psnd_timer_id_t; cdecl; LIBASOUND__


(* Get the timer resolution of a queue_timer container.

Parameters
    info	queue_timer container

Returns
    timer resolution
*)
function snd_seq_queue_timer_get_resolution(info: Psnd_seq_queue_timer_t): cuint; cdecl; LIBASOUND__


(* Set the timer type of a queue_timer container.

Parameters
    info	queue_timer container
    type	timer type
*)
procedure snd_seq_queue_timer_set_type(info: Psnd_seq_queue_timer_t; type_: snd_seq_queue_timer_type_t); cdecl; LIBASOUND__


(* Set the timer id of a queue_timer container.

Parameters
    info	queue_timer container
    id  	timer id pointer
*)
procedure snd_seq_queue_timer_set_id(info: Psnd_seq_queue_timer_t; id: Psnd_timer_id_t); cdecl; LIBASOUND__


(* Set the timer resolution of a queue_timer container.

Parameters
    info	queue_timer container
    resolution	timer resolution
*)
procedure snd_seq_queue_timer_set_resolution(info: Psnd_seq_queue_timer_t; resolution: cuint); cdecl; LIBASOUND__


(* Obtain the queue timer information

Parameters
    seq 	sequencer handle
    q   	queue id to query
    timer	pointer to store the timer information

Returns
    0 on success otherwise a negative error code
*)
function snd_seq_get_queue_timer(handle: Psnd_seq_t; q: cint; timer: Psnd_seq_queue_timer_t): cint; cdecl; LIBASOUND__


(* Set the queue timer information

Parameters
    seq 	sequencer handle
    q   	queue id to change the timer
    timer	timer information

Returns
    0 on success otherwise a negative error code
*)
function snd_seq_set_queue_timer(handle: Psnd_seq_t; q: cint; timer: Psnd_seq_queue_timer_t): cint; cdecl; LIBASOUND__


(* (DEPRECATED) free an event

In the former version, this function was used to release the event pointer which was allocated by snd_seq_event_input(). In the current version, the event record is not allocated, so you don't have to call this function any more.
*)
function snd_seq_free_event(ev: Psnd_seq_event_t): cint; cdecl; LIBASOUND__


(* (DEPRECATED) free an event

In the former version, this function was used to release the event pointer which was allocated by snd_seq_event_input(). In the current version, the event record is not allocated, so you don't have to call this function any more.
*)
function snd_seq_event_length(ev: Psnd_seq_event_t): ssize_t; cdecl; LIBASOUND__


(* Output an event

Parameters
    seq	sequencer handle
    ev	event to be output

Returns
    the number of remaining events or a negative error code

An event is once expanded on the output buffer. The output buffer will be drained automatically if it becomes full.

If events remain unprocessed on output buffer before drained, the size of total byte data on output buffer is returned. If the output buffer is empty, this returns zero.
*)
function snd_seq_event_output(handle: Psnd_seq_t; ev: Psnd_seq_event_t): cint; cdecl; LIBASOUND__


(* Output an event onto the lib buffer without draining buffer

Parameters
    seq 	sequencer handle
    ev  	event to be output

Returns
    the byte size of remaining events. -EAGAIN if the buffer becomes full.

This function doesn't drain buffer unlike snd_seq_event_output().
*)
function snd_seq_event_output_buffer(handle: Psnd_seq_t; ev: Psnd_seq_event_t): cint; cdecl; LIBASOUND__


(* output an event directly to the sequencer NOT through output buffer

Parameters
    seq 	sequencer handle
    ev  	event to be output

Returns
    the byte size sent to sequencer or a negative error code

This function sends an event to the sequencer directly not through the output buffer. When the event is a variable length event, a temporary buffer is allocated inside alsa-lib and the data is copied there before actually sent.
*)
function snd_seq_event_output_direct(handle: Psnd_seq_t; ev: Psnd_seq_event_t): cint; cdecl; LIBASOUND__


(* Retrieve an event from sequencer

Parameters
    seq 	sequencer handle
    ev  	event pointer to be stored

Returns
    Obtains an input event from sequencer. The event is created via snd_seq_create_event(), and its pointer is stored on ev argument.

This function firstly receives the event byte-stream data from sequencer as much as possible at once. Then it retrieves the first event record and store the pointer on ev. By calling this function sequentially, events are extracted from the input buffer.

If there is no input from sequencer, function falls into sleep in blocking mode until an event is received, or returns -EAGAIN error in non-blocking mode. Occasionally, this function may return -ENOSPC error. This means that the input FIFO of sequencer overran, and some events are lost. Once this error is returned, the input FIFO is cleared automatically.

Function returns the byte size of remaining events on the input buffer if an event is successfully received. Application can determine from the returned value whether to call input once more or not.
*)
function snd_seq_event_input(handle: Psnd_seq_t; ev: PPsnd_seq_event_t): cint; cdecl; LIBASOUND__


(* Check events in input buffer

Returns
    the byte size of remaining input events on input buffer.

If events remain on the input buffer of user-space, function returns the total byte size of events on it. If fetch_sequencer argument is non-zero, this function checks the presence of events on sequencer FIFO When events exist, they are transferred to the input buffer, and the number of received events are returned. If fetch_sequencer argument is zero and no events remain on the input buffer, function simply returns zero.
*)
function snd_seq_event_input_pending(seq: Psnd_seq_t; fetch_sequencer: cint): cint; cdecl; LIBASOUND__


(* drain output buffer to sequencer

Parameters
    seq	sequencer handle

Returns
    0 when all events are drained and sent to sequencer. When events still remain on the buffer, the byte size of remaining events are returned. On error a negative error code is returned.

This function drains all pending events on the output buffer. The function returns immediately after the events are sent to the queues regardless whether the events are processed or not. To get synchronization with the all event processes, use snd_seq_sync_output_queue() after calling this function.
*)
function snd_seq_drain_output(handle: Psnd_seq_t): cint; cdecl; LIBASOUND__


(* Return the size of pending events on output buffer

Parameters
    seq 	sequencer handle

Returns
    the byte size of total of pending events
*)
function snd_seq_event_output_pending(seq: Psnd_seq_t): cint; cdecl; LIBASOUND__


(* Extract the first event in output buffer

Parameters
    seq 	sequencer handle
    ev_res	event pointer to be extracted

Returns
    0 on success otherwise a negative error code

Extracts the first event in output buffer. If ev_res is NULL, just remove the event.
*)
function snd_seq_extract_output(handle: Psnd_seq_t; ev: PPsnd_seq_event_t): cint; cdecl; LIBASOUND__


(* Remove all events on output buffer

Parameters
    seq 	sequencer handle

Removes all events on both user-space output buffer and output memory pool on kernel.
*)
function snd_seq_drop_output(handle: Psnd_seq_t): cint; cdecl; LIBASOUND__


(* Remove all events on user-space output buffer

Parameters
    seq 	sequencer handle

Removes all events on user-space output buffer. Unlike snd_seq_drain_output(), this function doesn't remove events on output memory pool of sequencer.
*)
function snd_seq_drop_output_buffer(handle: Psnd_seq_t): cint; cdecl; LIBASOUND__


(* Clear input buffer and and remove events in sequencer queue

Parameters
    seq 	sequencer handle
*)
function snd_seq_drop_input(handle: Psnd_seq_t): cint; cdecl; LIBASOUND__


(* Remove all events on user-space input FIFO

Parameters
    seq 	sequencer handle
*)
function snd_seq_drop_input_buffer(handle: Psnd_seq_t): cint; cdecl; LIBASOUND__


(* Get size of snd_seq_remove_events_t

Returns
    size in bytes
*)
function snd_seq_remove_events_sizeof: size_t; cdecl; LIBASOUND__


(* Allocate an empty snd_seq_remove_events_t using standard malloc

Parameters
    ptr 	returned pointer

Returns
    0 on success otherwise negative error code
*)
function snd_seq_remove_events_malloc(ptr: PPsnd_seq_remove_events_t): cint; cdecl; LIBASOUND__


(* Frees a previously allocated snd_seq_remove_events_t

Parameters
    obj 	pointer to object to free
*)
procedure snd_seq_remove_events_free(ptr: Psnd_seq_remove_events_t); cdecl; LIBASOUND__


(* Copy one snd_seq_remove_events_t to another

Parameters
    dst 	pointer to destination
    src 	pointer to source
*)
procedure snd_seq_remove_events_copy(dst: Psnd_seq_remove_events_t; src: Psnd_seq_remove_events_t); cdecl; LIBASOUND__


(* Get the removal condition bits.

Parameters
    info	remove_events container

Returns
    removal condition bits
*)
function snd_seq_remove_events_get_condition(info: Psnd_seq_remove_events_t): cuint; cdecl; LIBASOUND__


(* Get the queue as removal condition.

Parameters
    info	remove_events container

Returns
    queue id
*)
function snd_seq_remove_events_get_queue(info: Psnd_seq_remove_events_t): cint; cdecl; LIBASOUND__


(* Get the event timestamp as removal condition.

Parameters
    info	remove_events container

Returns
    time stamp
*)
function snd_seq_remove_events_get_time(info: Psnd_seq_remove_events_t): Psnd_seq_timestamp_t; cdecl; LIBASOUND__


(* Get the event destination address as removal condition.

Parameters
    info	remove_events container

Returns
    destination address
*)
function snd_seq_remove_events_get_dest(info: Psnd_seq_remove_events_t): Psnd_seq_addr_t; cdecl; LIBASOUND__


(* Get the event channel as removal condition.

Parameters
    info	remove_events container

Returns
    channel number
*)
function snd_seq_remove_events_get_channel(info: Psnd_seq_remove_events_t): cint; cdecl; LIBASOUND__


(* Get the event type as removal condition.

Parameters
    info	remove_events container

Returns
    event type
*)
function snd_seq_remove_events_get_event_type(info: Psnd_seq_remove_events_t): cint; cdecl; LIBASOUND__


(* Get the event tag id as removal condition.

Parameters
    info	remove_events container

Returns
    tag id
*)
function snd_seq_remove_events_get_tag(info: Psnd_seq_remove_events_t): cint; cdecl; LIBASOUND__


(* Set the removal condition bits.

Parameters
    info	remove_events container
    flags	removal condition bits
*)
procedure snd_seq_remove_events_set_condition(info: Psnd_seq_remove_events_t; flags: cuint); cdecl; LIBASOUND__


(* Set the queue as removal condition.

Parameters
    info	remove_events container
    queue	queue id
*)
procedure snd_seq_remove_events_set_queue(info: Psnd_seq_remove_events_t; queue: cint); cdecl; LIBASOUND__


(* Set the timestamp as removal condition.

Parameters
    info	remove_events container
    time	timestamp pointer
*)
procedure snd_seq_remove_events_set_time(info: Psnd_seq_remove_events_t; time: Psnd_seq_timestamp_t); cdecl; LIBASOUND__


(*Set the destination address as removal condition.

Parameters
    info	remove_events container
    addr	destination address
*)
procedure snd_seq_remove_events_set_dest(info: Psnd_seq_remove_events_t; addr: Psnd_seq_addr_t); cdecl; LIBASOUND__


(* Set the channel as removal condition.

Parameters
    info	remove_events container
    channel	channel number
*)
procedure snd_seq_remove_events_set_channel(info: Psnd_seq_remove_events_t; channel: cint); cdecl; LIBASOUND__


(* Set the event type as removal condition.

Parameters
    info	remove_events container
    type	event type
*)
procedure snd_seq_remove_events_set_event_type(info: Psnd_seq_remove_events_t; type_: cint); cdecl; LIBASOUND__


(* Set the event tag as removal condition.

Parameters
    info	remove_events container
    tag	tag id
*)
procedure snd_seq_remove_events_set_tag(info: Psnd_seq_remove_events_t; tag: cint); cdecl; LIBASOUND__


(* Remove events on input/output buffers and pools

Parameters
    seq 	sequencer handle
    rmp 	remove event container

Removes matching events with the given condition from input/output buffers and pools. The removal condition is specified in rmp argument.
*)
function snd_seq_remove_events(handle: Psnd_seq_t; info: Psnd_seq_remove_events_t): cint; cdecl; LIBASOUND__


(* Set a bit flag
*)
procedure snd_seq_set_bit(nr: cint; array_: Pointer); cdecl; LIBASOUND__


(* Unset a bit flag
*)
procedure snd_seq_unset_bit(nr: cint; array_: Pointer); cdecl; LIBASOUND__


(* Change a bit flag
*)
function snd_seq_change_bit(nr: cint; array_: Pointer): cint; cdecl; LIBASOUND__


(* Get a bit flag state
*)
function snd_seq_get_bit(nr: cint; array_: Pointer): cint; cdecl; LIBASOUND__


(* Create a port - simple version

Parameters
    seq 	sequencer handle
    name	the name of the port
    caps	capability bits
    type	type bits

Returns
    the created port number or negative error code

Creates a port with the given capability and type bits.
*)
function snd_seq_create_simple_port(seq: Psnd_seq_t; name: PChar;
                                    caps, type_: cuint): cint; cdecl; LIBASOUND__


(* Delete the port

Parameters
    seq 	sequencer handle
    port	port id

Returns
    0 on success or negative error code
*)
function snd_seq_delete_simple_port(seq: Psnd_seq_t; port: cint): cint; cdecl; LIBASOUND__


(* Simple subscription (w/o exclusive & time conversion)

Parameters
    seq 	sequencer handle
    myport	the port id as receiver
    src_client	sender client id
    src_port	sender port id

Returns
    0 on success or negative error code

Connect from the given sender client:port to the given destination port in the current client.
*)
function snd_seq_connect_from(seq: Psnd_seq_t; my_port, src_client, src_port: cint): cint; cdecl; LIBASOUND__


(* simple subscription (w/o exclusive & time conversion)

Parameters
    seq	sequencer handle
    myport	the port id as sender
    dest_client	destination client id
    dest_port	destination port id

Returns
    0 on success or negative error code

Connect from the given receiver port in the current client to the given destination client:port.
*)
function snd_seq_connect_to(seq: Psnd_seq_t; my_port, dest_client, dest_port: cint): cint; cdecl; LIBASOUND__


(* Simple disconnection

Parameters
    seq 	sequencer handle
    myport	the port id as receiver
    src_client	sender client id
    src_port	sender port id

Returns
    0 on success or negative error code

Remove connection from the given sender client:port to the given destination port in the current client.
*)
function snd_seq_disconnect_from(seq: Psnd_seq_t; my_port, src_client, src_port: cint): cint; cdecl; LIBASOUND__


(* Simple disconnection

Parameters
    seq 	sequencer handle
    myport	the port id as sender
    dest_client	destination client id
    dest_port	destination port id

Returns
    0 on success or negative error code

Remove connection from the given sender client:port to the given destination port in the current client.
*)
function snd_seq_disconnect_to(seq: Psnd_seq_t; my_port, dest_client, dest_port: cint): cint; cdecl; LIBASOUND__


(* Set client name

Parameters
    seq 	sequencer handle
    name	name string

Returns
    0 on success or negative error code
*)
function snd_seq_set_client_name(seq: Psnd_seq_t; name: PChar): cint; cdecl; LIBASOUND__


(* Add client event filter

Parameters
    seq 	sequencer handle
    event_type	event type to be added

Returns
    0 on success or negative error code
*)
function snd_seq_set_client_event_filter(seq: Psnd_seq_t; event_type: cint): cint; cdecl; LIBASOUND__


(* Change the output pool size of the given client

Parameters
    seq 	sequencer handle
    size	output pool size

Returns
    0 on success or negative error code
*)
function snd_seq_set_client_pool_output(seq: Psnd_seq_t; size: size_t): cint; cdecl; LIBASOUND__


(* Change the output room size of the given client

Parameters
    seq 	sequencer handle
    size	output room size

Returns
    0 on success or negative error code
*)
function snd_seq_set_client_pool_output_room(seq: Psnd_seq_t; size: size_t): cint; cdecl; LIBASOUND__


(* Change the input pool size of the given client

Parameters
    seq 	sequencer handle
    size	input pool size

Returns
    0 on success or negative error code
*)
function snd_seq_set_client_pool_input(seq: Psnd_seq_t; size: size_t): cint; cdecl; LIBASOUND__


(* Wait until all events are processed

Parameters
    seq 	sequencer handle

Returns
    0 on success or negative error code

This function waits until all events of this client are processed.
*)
function snd_seq_sync_output_queue(seq: Psnd_seq_t): cint; cdecl; LIBASOUND__


(* Parse the given string and get the sequencer address

Parameters
    seq 	sequencer handle
    addr	the address pointer to be returned
    arg 	the string to be parsed

Returns
    0 on success or negative error code

This function parses the sequencer client and port numbers from the given string. The client and port tokens are separated by either colon or period, e.g. 128:1. When seq is not NULL, the function accepts also a client name not only digit numbers. Actually arg need to be only a prefix of the wanted client. That is, if a client named "Foobar XXL Master 2012" with number 128 is available, then parsing "Foobar" will return the address 128:0 if no other client is an exact match.
*)
function snd_seq_parse_address(seq: Psnd_seq_t; addr: Psnd_seq_addr_t; str: PChar): cint; cdecl; LIBASOUND__


(* Reset client output pool

Parameters
    seq 	sequencer handle

Returns
    0 on success or negative error code

So far, this works identically like snd_seq_drop_output().
*)
function snd_seq_reset_pool_output(seq: Psnd_seq_t): cint; cdecl; LIBASOUND__


(* Reset client input pool

Parameters
    seq 	sequencer handle

Returns
    0 on success or negative error code

So far, this works identically like snd_seq_drop_input().
*)
function snd_seq_reset_pool_input(seq: Psnd_seq_t): cint; cdecl; LIBASOUND__


(* queue controls - start/stop/continue

Parameters
    seq 	sequencer handle
    q   	queue id to control
    type	event type
    value	event value
    ev  	event instance

This function sets up general queue control event and sends it. To send at scheduled time, set the schedule in ev. If ev is NULL, the event is composed locally and sent immediately to the specified queue. In any cases, you need to call snd_seq_drain_output() appropriately to feed the event.
*)
function snd_seq_control_queue(seq: Psnd_seq_t; q, type_, value: cint; ev: Psnd_seq_event_t): cint; cdecl; LIBASOUND__


// fpalsa defines these in error.inc:


(* Returns the message for an error code.

Parameters
    errnum	The error code number, which must be a system error code or an ALSA error code.

Returns
    The ASCII description of the given numeric error code.
*)
function snd_strerror(errnum: cint): PChar; cdecl; LIBASOUND__


// Formerly macros:

// TODO : Consider a macro to define snd_seq_set_nonblock().
{$INFO Fpalsa calls this snd_seq_set_nonblock(), because pascal isn't case sensitive, }
{$INFO However the defToSDUnits utility does not have support for explicit external names. }


function _SND_SEQ_TYPE(x: TSND_SEQ_EVFLG): cuint; inline;

//#define _SND_SEQ_TYPE_OPT(x)  ((x)<<24)       /**< optional type - 8bit */

(** check the event type *)
function snd_seq_type_check(ev: Psnd_seq_event_t; x: TSND_SEQ_EVFLG): Boolean; inline;

(** event type check: result events *)
function snd_seq_ev_is_result_type(ev: Psnd_seq_event_t): Boolean; inline;

(** event type check: note events *)
function snd_seq_ev_is_note_type(ev: Psnd_seq_event_t): Boolean; inline;

(** event type check: control events *)
function snd_seq_ev_is_control_type(ev: Psnd_seq_event_t): Boolean; inline;

(** event type check: channel specific events *)
function snd_seq_ev_is_channel_type(ev: Psnd_seq_event_t): Boolean; inline;

(** event type check: queue control events *)
function snd_seq_ev_is_queue_type(ev: Psnd_seq_event_t): Boolean; inline;

(** event type check: system status messages *)
function snd_seq_ev_is_message_type(ev: Psnd_seq_event_t): Boolean; inline;

(** event type check: system status messages *)
function snd_seq_ev_is_subscribe_type(ev: Psnd_seq_event_t): Boolean; inline;

(** event type check: sample messages *)
function snd_seq_ev_is_sample_type(ev: Psnd_seq_event_t): Boolean; inline;

(** event type check: user-defined messages *)
function snd_seq_ev_is_user_type(ev: Psnd_seq_event_t): Boolean; inline;

(** event type check: instrument layer events *)
function snd_seq_ev_is_instr_type(ev: Psnd_seq_event_t): Boolean; inline;

(** event type check: fixed length events *)
function snd_seq_ev_is_fixed_type(ev: Psnd_seq_event_t): Boolean; inline;

(** event type check: variable length events *)
function snd_seq_ev_is_variable_type(ev: Psnd_seq_event_t): Boolean; inline;

(** event type check: user pointer events *)
function snd_seq_ev_is_varusr_type(ev: Psnd_seq_event_t): Boolean; inline;

(** event type check: reserved for kernel *)
function snd_seq_ev_is_reserved(ev: Psnd_seq_event_t): Boolean; inline;


(**
macros to check event flags
 *)

(** prior events *)
function snd_seq_ev_is_prior(ev: Psnd_seq_event_t): Boolean; inline;

(** get the data length type *)
function snd_seq_ev_length_type(ev: Psnd_seq_event_t): cuchar; inline;

(** fixed length events *)
function snd_seq_ev_is_fixed(ev: Psnd_seq_event_t): Boolean; inline;

(** variable length events *)
function snd_seq_ev_is_variable(ev: Psnd_seq_event_t): Boolean; inline;

(** variable length on user-space *)
function snd_seq_ev_is_varusr(ev: Psnd_seq_event_t): Boolean; inline;

(** time-stamp type *)
function snd_seq_ev_timestamp_type(ev: Psnd_seq_event_t): cuchar; inline;

(** event is in tick time *)
function snd_seq_ev_is_tick(ev: Psnd_seq_event_t): Boolean; inline;

(** event is in real-time *)
function snd_seq_ev_is_real(ev: Psnd_seq_event_t): Boolean; inline;

(** time-mode type *)
function snd_seq_ev_timemode_type(ev: Psnd_seq_event_t): cuchar; inline;

(** scheduled in absolute time *)
function snd_seq_ev_is_abstime(ev: Psnd_seq_event_t): Boolean; inline;

(** scheduled in relative time *)
function snd_seq_ev_is_reltime(ev: Psnd_seq_event_t): Boolean; inline;

(** direct dispatched events *)
function snd_seq_ev_is_direct(ev: Psnd_seq_event_t): Boolean; inline;

// fpalsa defines these in seqmid.inc:

(* initialize event record

Parameters
    ev	event record pointer

This macro clears the given event record pointer to the default status.
*)
procedure snd_seq_ev_clear(ev: Psnd_seq_event_t); inline; // Macro, not in library

(* set the tag for given event

Parameters
    ev          event record
    t           event tag

This macro sets the tag to the given event record.
*)
procedure snd_seq_ev_set_tag(ev: Psnd_seq_event_t; t: cuchar); inline;

(* set the explicit destination

Parameters
    ev          event record
    c           destination client id
    p           destination port id

This macro sets the client and port id numbers to the given event record.
*)
procedure snd_seq_ev_set_dest(ev: Psnd_seq_event_t; c, p: cuchar); inline;

(* set broadcasting to subscribers

Parameters
    ev          event record

This macro sets the destination as the subscribers.
*)
procedure snd_seq_ev_set_subs(ev: Psnd_seq_event_t); inline;

(* set broadcasting to all clients/ports

Parameters
    ev          event record

This macro sets the destination as the broadcasting.
*)
procedure snd_seq_ev_set_broadcast(ev: Psnd_seq_event_t); inline;

(* set the source port

Parameters
    ev          event record
    p           source port id

This macro sets the source port id number.
*)
procedure snd_seq_ev_set_source(ev: Psnd_seq_event_t; p: cuchar); inline;

(* set direct passing mode (without queued)

Parameters
    ev          event instance

This macro sets the event to the direct passing mode
to be delivered immediately without queueing.
*)
procedure snd_seq_ev_set_direct(ev: Psnd_seq_event_t); inline;

(* set tick-scheduling mode on queue

Parameters
    ev          event instance
    q           queue id to schedule
    relative    relative time-stamp if non-zero
    ttick       tick time-stamp to be delivered

This macro sets the scheduling of the event in the MIDI tick mode.
*)
procedure snd_seq_ev_schedule_tick(ev: Psnd_seq_event_t; q: cuchar; relative: Boolean; ttick: snd_seq_tick_time_t); inline;

(* set real-time-scheduling mode on queue

Parameters
    ev          event instance
    q           queue id to schedule
    relative    relative time-stamp if non-zero
    rtime       time-stamp to be delivered

This macro sets the scheduling of the event in the realtime mode.
*)
procedure snd_seq_ev_schedule_real(ev: Psnd_seq_event_t; q: cuchar; relative: Boolean; rtime: Psnd_seq_real_time_t); inline;

(* set event priority

Parameters
    ev          event instance
    high_prior  1 for high priority mode
*)
procedure snd_seq_ev_set_priority(ev: Psnd_seq_event_t; high_prior: Boolean); inline;

(* set fixed data

Parameters
    ev          event instance

Sets the event length mode as fixed size.
*)
procedure snd_seq_ev_set_fixed(ev: Psnd_seq_event_t); inline;

(* set variable data

Parameters
    ev          event instance
    datalen     length of the external data
    dataptr     pointer of the external data

Sets the event length mode as variable length and stores the data.
*)
procedure snd_seq_ev_set_variable(ev: Psnd_seq_event_t; datalen: cuint; dataptr: Pointer); inline;

(* set varusr data

Parameters
    ev          event instance
    datalen     length of the external data
    dataptr     pointer of the external data

Sets the event length mode as variable user-space data and stores the data.
*)
procedure snd_seq_ev_set_varusr(ev: Psnd_seq_event_t; datalen: cuint; dataptr: Pointer); inline;

(* set queue controls

Parameters
    ev          event record
    typ         event type
    q           queue id
    val         control value
*)
procedure snd_seq_ev_set_queue_control(ev: Psnd_seq_event_t; typ: snd_seq_event_type; q: cuchar; val: cint); inline;

(* set the start queue event

Parameters
    ev          event record
    q           queue id to start
*)
procedure snd_seq_ev_set_queue_start(ev: Psnd_seq_event_t; q: cuchar); inline;

(* set the stop queue event

Parameters
    ev          event record
    q           queue id to stop
*)
procedure snd_seq_ev_set_queue_stop(ev: Psnd_seq_event_t; q: cuchar); inline;

(* set the stop queue event

Parameters
    ev          event record
    q           queue id to continue
*)
procedure snd_seq_ev_set_queue_continue(ev: Psnd_seq_event_t; q: cuchar); inline;

(* set the stop queue event

Parameters
    ev          event record
    q           queue id to change tempo
    val         the new tempo value
*)
procedure snd_seq_ev_set_queue_tempo(ev: Psnd_seq_event_t; q: cuchar; val: cint); inline;

(* set the real-time position of a queue

Parameters
    ev          event record
    q           queue id to change tempo
    rtime       the new real-time pointer
*)
procedure snd_seq_ev_set_queue_pos_real(ev: Psnd_seq_event_t; q: cuchar; rtime: Psnd_seq_real_time_t); inline;

(* set the tick-time position of a queue

Parameters
    ev          event record
    q           queue id to change tempo
    ttime       the new tick-time
*)
procedure snd_seq_ev_set_queue_pos_tick(ev: Psnd_seq_event_t; q: cuchar; ttime: snd_seq_tick_time_t); inline;

(* start the specified queue

Parameters
    seq	        sequencer handle
    q	        queue id to start
    ev	        optional event record (see snd_seq_control_queue)
*)
function snd_seq_start_queue(seq: Psnd_seq_t; q: cint; ev: Psnd_seq_event_t): cint; inline; // Macro, not in library

(* stop the specified queue

Parameters
    seq         sequencer handle
    q           queue id to stop
    ev          optional event record (see #snd_seq_control_queue)
*)
function snd_seq_stop_queue(seq: Psnd_seq_t; q: cint; ev: Psnd_seq_event_t): cint; inline;

(* continue the specified queue

Parameters
    seq         sequencer handle
    q           queue id to continue
    ev          optional event record (see #snd_seq_control_queue)
*)
function snd_seq_continue_queue(seq: Psnd_seq_t; q: cint; ev: Psnd_seq_event_t): cint; inline;

(* change the tempo of the specified queue

Parameters
    seq         sequencer handle
    q           queue id
    tempo       the new tempo value
    ev          optional event record (see #snd_seq_control_queue)
*)
function snd_seq_change_queue_tempo(seq: Psnd_seq_t; q, tempo: cint; ev: Psnd_seq_event_t): cint; inline;

(* set note event

Parameters
    ev          event record
    ch          channel number
    key         note key
    vel         velocity
    dur         duration (in tick or msec)
*)
procedure snd_seq_ev_set_note(ev: Psnd_seq_event_t; ch, key, vel: cuchar; dur: cuint); inline;

(* set note-on event

Parameters
    ev          event record
    ch          channel number
    key         note key
    vel         velocity
*)
procedure snd_seq_ev_set_noteon(ev: Psnd_seq_event_t; ch, key, vel: cuchar); inline;

(* set note-off event

Parameters
    ev          event record
    ch          channel number
    key         note key
    vel         velocity
*)
procedure snd_seq_ev_set_noteoff(ev: Psnd_seq_event_t; ch, key, vel: cuchar); inline;

(* set key-pressure event

Parameters
    ev          event record
    ch          channel number
    key         note key
    vel         velocity
*)
procedure snd_seq_ev_set_keypress(ev: Psnd_seq_event_t; ch, key, vel: cuchar); inline;

(* set MIDI controller event

Parameters
    ev          event record
    ch          channel number
    cc          controller number
    val         control value
*)
procedure snd_seq_ev_set_controller(ev: Psnd_seq_event_t; ch: cuchar; cc: cuint; val: cint); inline;

(* set program change event

Parameters
    ev          event record
    ch          channel number
    val         program number
*)
procedure snd_seq_ev_set_pgmchange(ev: Psnd_seq_event_t; ch: cuchar; val: cint); inline;

(* set pitch-bend event

Parameters
    ev          event record
    ch          channel number
    val         pitch bend; zero centered from -8192 to 8191
*)
procedure snd_seq_ev_set_pitchbend(ev: Psnd_seq_event_t; ch: cuchar; val: cint); inline;

(* set channel pressure event

Parameters
    ev          event record
    ch          channel number
    val         channel pressure value
*)
procedure snd_seq_ev_set_chanpress(ev: Psnd_seq_event_t; ch: cuchar; val: cint); inline;

(* set sysex event

Parameters
    ev          event record
    datalen     length of sysex data
    dataptr     sysex data pointer

the sysex data must contain the start byte 0xf0 and the end byte 0xf7.
*)
procedure snd_seq_ev_set_sysex(ev: Psnd_seq_event_t; datalen: cuint; dataptr: Pointer); inline;


{$ifdef DYNAMIC }

{* Exported event type table
 *
This table is referred by snd_seq_ev_is_xxx.
 *}
function get_snd_seq_event_types(): Pcuint; inline;

{$endif DYNAMIC }

{$endif PROCS }
