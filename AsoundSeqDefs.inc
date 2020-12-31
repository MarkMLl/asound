
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

{$ifdef CONSTS }
const
  SND_SEQ_OPEN_OUTPUT = 1;  (**< open for output (write) *)
  SND_SEQ_OPEN_INPUT  = 2;  (**< open for input (read) *)
  SND_SEQ_OPEN_DUPLEX = (SND_SEQ_OPEN_OUTPUT or SND_SEQ_OPEN_INPUT);  (**< open for both input and output (read/write) *)

  SND_SEQ_PORT_CAP_READ        = 1 shl 0;  (**< readable from this port *)
  SND_SEQ_PORT_CAP_WRITE       = 1 shl 1;  (**< writable to this port *)

  SND_SEQ_PORT_CAP_SYNC_READ   = 1 shl 2;  (**< allow read subscriptions *)
  SND_SEQ_PORT_CAP_SYNC_WRITE  = 1 shl 3;  (**< allow write subscriptions *)

  SND_SEQ_PORT_CAP_DUPLEX      = 1 shl 4;  (**< allow read/write duplex *)

  SND_SEQ_PORT_CAP_SUBS_READ   = 1 shl 5;  (**< allow read subscription *)
  SND_SEQ_PORT_CAP_SUBS_WRITE  = 1 shl 6;  (**< allow write subscription *)
  SND_SEQ_PORT_CAP_NO_EXPORT   = 1 shl 7;  (**< routing not allowed *)

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
type
(** Sequencer handle *)
  PPsnd_seq_t = ^Psnd_seq_t;
(** Sequencer handle *)
  Psnd_seq_t = ^snd_seq_t;
(** Sequencer handle *)
  snd_seq_t = record
  end;

(** client information container *)
  PPsnd_seq_client_info_t = ^Psnd_seq_client_info_t;
(** client information container *)
  Psnd_seq_client_info_t = ^snd_seq_client_info_t;
(** client information container *)
  snd_seq_client_info_t = record
  end;

(** client types *)
  Psnd_seq_client_type_t = ^snd_seq_client_type_t;
(** client types *)
  snd_seq_client_type_t = (
        SND_SEQ_USER_CLIENT     = 1,    (**< user client *)
        SND_SEQ_KERNEL_CLIENT   = 2     (**< kernel client *)
  );

(** port information container *)
  PPsnd_seq_port_info_t = ^Psnd_seq_port_info_t;
(** port information container *)
  Psnd_seq_port_info_t = ^snd_seq_port_info_t;
(** port information container *)
  snd_seq_port_info_t = record
  end;

(** Sequencer event address *)
  Psnd_seq_addr_t = ^snd_seq_addr_t;
(** Sequencer event address *)
  snd_seq_addr_t = record
        client: cuchar;                 (**< Client id *)
        port: cuchar;                   (**< Port id *)
  end;

(**
 * Sequencer event data type
 *)
  Psnd_seq_event_type_t = ^snd_seq_event_type_t;
(**
 * Sequencer event data type
 *)
  snd_seq_event_type_t = cuchar;

(** Sequencer event type *)
  Psnd_seq_event_type = ^snd_seq_event_type;
(** Sequencer event type *)
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

(** Connection (subscription) between ports *)
  Psnd_seq_connect_t = ^snd_seq_connect_t;
  snd_seq_connect_t = record
        sender: snd_seq_addr_t;         (**< sender address *)
        dest: snd_seq_addr_t;           (**< destination address *)
  end;

(** Real-time data record *)
  Psnd_seq_real_time_t = ^snd_seq_real_time_t;
  snd_seq_real_time_t = record
        tv_sec: cuint;                  (**< seconds *)
        tv_nsec: cuint;                 (**< nanoseconds *)
  end;

(** (MIDI) Tick-time data record *)
  Psnd_seq_tick_time_t = ^snd_seq_tick_time_t;
  snd_seq_tick_time_t = cuint;

(** unioned time stamp *)
  Psnd_seq_timestamp_t = ^snd_seq_timestamp_t;
  snd_seq_timestamp_t = record
    case Integer of
      0: (
          tick: snd_seq_tick_time_t;    (**< tick-time *)
        );
      1: (
          time: snd_seq_real_time_t;    (**< real-time *)
        );
  end;

(** Note event *)
  Psnd_seq_ev_note_t = ^snd_seq_ev_note_t;
(** Note event *)
  snd_seq_ev_note_t = record
    channel: cuchar;                    (**< channel number *)
    note: cuchar;                       (**< note *)
    velocity: cuchar;                   (**< velocity *)
    off_velocity: cuchar;               (**< note-off velocity; only for #SND_SEQ_EVENT_NOTE *)
    duration: cuint;                    (**< duration until note-off; only for #SND_SEQ_EVENT_NOTE *)
  end;

(** Controller event *)
  Psnd_seq_ev_ctrl_t = ^snd_seq_ev_ctrl_t;
(** Controller event *)
  snd_seq_ev_ctrl_t = record
    channel: cuchar;                    (**< channel number *)
    unused: array [0..2] of cuchar;     (**< reserved *)
    param: cuint;                       (**< control parameter *)
    value: cint;                        (**< control value *)
  end;

(** generic set of bytes (12x8 bit) *)
  Psnd_seq_ev_raw8_t = ^snd_seq_ev_raw8_t;
(** generic set of bytes (12x8 bit) *)
  snd_seq_ev_raw8_t = record
    d: array [0..11] of cuchar;         (**< 8 bit value *)
  end;

(** generic set of integers (3x32 bit) *)
  Psnd_seq_ev_raw32_t = ^snd_seq_ev_raw32_t;
(** generic set of integers (3x32 bit) *)
  snd_seq_ev_raw32_t = record
    d: array [0..2] of cuint;           (**< 32 bit value *)
  end;

(** external stored data *)
  Psnd_seq_ev_ext_t = ^snd_seq_ev_ext_t;
(** external stored data *)
  snd_seq_ev_ext_t = {__attribute__((packed))} packed record
    len: cuint;                         (**< length of data *)
    ptr: Pointer;                       (**< pointer to data (note: can be 64-bit) *)
  end;

(** Result events *)
  Psnd_seq_result_t = ^snd_seq_result_t;
(** Result events *)
  snd_seq_result_t = record
    event: cint;                        (**< processed event type *)
    result: cint;                       (**< status *)
  end;

(** Queue skew values *)
  Psnd_seq_queue_skew_t = ^snd_seq_queue_skew_t;
(** Queue skew values *)
  snd_seq_queue_skew_t = record
    value: cuint;                       (**< skew value *)
    base: cuint;                        (**< skew base *)
  end;

(** queue timer control *)
  Psnd_seq_ev_queue_control_t = ^snd_seq_ev_queue_control_t;
(** queue timer control *)
  snd_seq_ev_queue_control_t = record
    queue: cuchar;                      (**< affected queue *)
    unused: array [0..2] of cuchar;     (**< reserved *)
    param: record                       (**< data value union *)
      case Integer of
        0: (
          value: cint;                  (**< affected value (e.g. tempo) *)
        );
        1: (
          time: snd_seq_timestamp_t;    (**< time *)
        );
        2: (
          position: cuint;              (**< sync position *)
        );
        3: (
          skew: snd_seq_queue_skew_t;   (**< queue skew *)
        );
        4: (
          d32: array [0..1] of cuint;   (**< any data *)
        );
        5: (
          d8: array [0..7] of cuchar;   (**< any data *)
        );
    end;
  end;

(** Sequencer event *)
  PPsnd_seq_event_t = ^Psnd_seq_event_t;
(** Sequencer event *)
  Psnd_seq_event_t = ^snd_seq_event_t;
(** Sequencer event *)
  snd_seq_event_t = record
    type_: snd_seq_event_type_t;        (**< event type *)
    flags: cuchar;                      (**< event flags *)
    tag: cuchar;                        (**< tag *)
    queue: cuchar;                      (**< schedule queue *)
    time: snd_seq_timestamp_t;          (**< schedule time *)

    source: snd_seq_addr_t;             (**< source address *)
    dest: snd_seq_addr_t;               (**< destination address *)

    data: record                        (**< event data... *)
      case Integer of
        0: (
          note: snd_seq_ev_note_t;      (**< note information *)
        );
        1: (
          control: snd_seq_ev_ctrl_t;   (**< MIDI control information *)
        );
        2: (
          raw8: snd_seq_ev_raw8_t;      (**< raw8 data *)
        );
        3: (
          raw32: snd_seq_ev_raw32_t;    (**< raw32 data *)
        );
        4: (
          ext: snd_seq_ev_ext_t;        (**< external data *)
        );
        5: (
          queue: snd_seq_ev_queue_control_t; (**< queue control *)
        );
        6: (
          time: snd_seq_timestamp_t;    (**< timestamp *)
        );
        7: (
          addr: snd_seq_addr_t;         (**< address *)
        );
        8: (
          connect: snd_seq_connect_t;   (**< connect information *)
        );
        9: (
          result: snd_seq_result_t;     (**< operation result code *)
        );
    end;
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


(* Close the sequencer.

Parameters
    seq	Handle returned from snd_seq_open()

Returns
    0 on success otherwise a negative error code

Closes the sequencer client and releases its resources. After a client is closed, an event with SND_SEQ_EVENT_CLIENT_EXIT is broadcast to announce port. The connection between other clients are disconnected. Call this just before exiting your program.
*)
function snd_seq_close(handle: Psnd_seq_t): cint; cdecl; LIBASOUND__


(* allocate an empty snd_seq_client_info_t using standard malloc

Parameters
    ptr	returned pointer

Returns
    0 on success otherwise negative error code
*)
function snd_seq_client_info_malloc(ptr: PPsnd_seq_client_info_t): cint; cdecl; LIBASOUND__


(*
frees a previously allocated snd_seq_client_info_t

Parameters
    obj	pointer to object to free
*)
procedure snd_seq_client_info_free(ptr: Psnd_seq_client_info_t); cdecl; LIBASOUND__


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


(* query the next client

Parameters
    seq	sequencer handle
    info	query pattern and result

Queries the next client. The search begins at the client with an id one greater than client field in info. If a client is found, its attributes are stored in info, and zero is returned. Otherwise returns a negative error code.
*)
function snd_seq_query_next_client(handle: Psnd_seq_t; info: Psnd_seq_client_info_t): cint; cdecl; LIBASOUND__


(* allocate an empty snd_seq_port_info_t using standard malloc

Parameters
    ptr	returned pointer

Returns
    0 on success otherwise negative error code
*)
function snd_seq_port_info_malloc(ptr: PPsnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* frees a previously allocated snd_seq_port_info_t

Parameters
    obj	pointer to object to free
*)
procedure snd_seq_port_info_free(ptr: Psnd_seq_port_info_t); cdecl; LIBASOUND__


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


(* Set the port-specified mode of a port_info container.

Parameters
    info	port_info container
    val	non-zero if specifying the port id at creation
*)
procedure snd_seq_port_info_set_port_specified(info: Psnd_seq_port_info_t; val: cint); cdecl; LIBASOUND__

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


(* query the next matching port

Parameters
    seq	sequencer handle
    info	query pattern and result

Queries the next matching port on the client specified in info argument. The search begins at the next port specified in port field of info argument. For finding the first port at a certain client, give -1.

If a matching port is found, its attributes are stored on info and function returns zero. Otherwise, a negative error code is returned.
*)
function snd_seq_query_next_port(handle: Psnd_seq_t; info: Psnd_seq_port_info_t): cint; cdecl; LIBASOUND__


(* allocate a queue with the specified name

Parameters
    seq	sequencer handle
    name	the name of the new queue

Returns
    the queue id (zero or positive) on success otherwise a negative error code
*)
function snd_seq_alloc_named_queue(seq: Psnd_seq_t; name: PChar): cint; cdecl; LIBASOUND__


(* delete the specified queue

Parameters
    seq	sequencer handle
    q	queue id to delete

Returns
    0 on success otherwise a negative error code
*)
function snd_seq_free_queue(handle: Psnd_seq_t; q: cint): cint; cdecl; LIBASOUND__


(* output an event

Parameters
    seq	sequencer handle
    ev	event to be output

Returns
    the number of remaining events or a negative error code

An event is once expanded on the output buffer. The output buffer will be drained automatically if it becomes full.

If events remain unprocessed on output buffer before drained, the size of total byte data on output buffer is returned. If the output buffer is empty, this returns zero.
*)
function snd_seq_event_output(handle: Psnd_seq_t; ev: Psnd_seq_event_t): cint; cdecl; LIBASOUND__


(* drain output buffer to sequencer

Parameters
    seq	sequencer handle

Returns
    0 when all events are drained and sent to sequencer. When events still remain on the buffer, the byte size of remaining events are returned. On error a negative error code is returned.

This function drains all pending events on the output buffer. The function returns immediately after the events are sent to the queues regardless whether the events are processed or not. To get synchronization with the all event processes, use snd_seq_sync_output_queue() after calling this function.
*)
function snd_seq_drain_output(handle: Psnd_seq_t): cint; cdecl; LIBASOUND__


// fpalsa defines these in seqmid.inc:


(* initialize event record

Parameters
    ev	event record pointer

This macro clears the given event record pointer to the default status.
*)
procedure snd_seq_ev_clear(ev: Psnd_seq_event_t); inline; // Macro, not in library


(* start the specified queue

Parameters
    seq	sequencer handle
    q	queue id to start
    ev	optional event record (see snd_seq_control_queue)
*)
function snd_seq_start_queue(seq: Psnd_seq_t; q: cint; ev: Psnd_seq_event_t): cint; inline; // Macro, not in library


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


(* set fixed data

Parameters
    ev	event instance

Sets the event length mode as fixed size.
*)
procedure snd_seq_ev_set_fixed(ev: Psnd_seq_event_t); inline; // Macro, not in library


(* queue controls - start/stop/continue

Parameters
    seq	sequencer handle
    q	queue id to control
    type	event type
    value	event value
    ev	event instance

This function sets up general queue control event and sends it. To send at scheduled time, set the schedule in ev. If ev is NULL, the event is composed locally and sent immediately to the specified queue. In any cases, you need to call snd_seq_drain_output() appropriately to feed the event.
*)
function snd_seq_control_queue(seq: Psnd_seq_t; q, type_, value: cint; ev: Psnd_seq_event_t): cint; cdecl; LIBASOUND__


(* set client name

Parameters
    seq	sequencer handle
    name	name string

Returns
    0 on success or negative error code
*)
function snd_seq_set_client_name(seq: Psnd_seq_t; name: PChar): cint; cdecl; LIBASOUND__


(* wait until all events are processed

Parameters
    seq	sequencer handle

Returns
    0 on success or negative error code

This function waits until all events of this client are processed.
*)
function snd_seq_sync_output_queue(seq: Psnd_seq_t): cint; cdecl; LIBASOUND__

{$endif PROCS  }

