unit AsoundSeq_dynamic;

(********************************************************************************)
(*                                                                              *)
(* WARNING: This is a machine-generated file and manual changes will be lost.   *)
(*                                                                              *)
(********************************************************************************)

{$mode objfpc}{$H+}
{$packrecords C}

(*
 * Please refer to AsoundSeqDefs.inc and other accompanying files for
 * licensing and disclaimer information.
 *)

interface

uses
  Classes, SysUtils, UnixType, DynamicModule;

const
  DefaultModuleName= 'libasound.so';
  DefaultEarlyLoad= true;
  HasLoadVarargsRoutine= true;          (* Presence is implementation-defined   *)

{$define DYNAMIC }
{$define CONSTS }
{$undef TYPES   }
{$undef PROCS   }
{$undef VPROCS  }
{$i AsoundSeqDefs.inc }

{$undef CONSTS  }
{$define TYPES  }
{$undef PROCS   }
{$undef VPROCS  }
{$i AsoundSeqDefs.inc }

(* These are the type descriptions of fields used to hold references to the     *)
(* methods listed in AsoundSeqDefs.inc (below). It is important that these types  *)
(* be considered subordinate to the definitions in the include file, since as   *)
(* well as being used here the include file might potentially be treated by the *)
(* shared library as the authoritative list of what it is to export.            *)

type
  Tsnd_seq_open= function(handle: PPsnd_seq_t; name: PChar; streams: cint; mode: cint): cint; cdecl;
  Tsnd_seq_open_lconf= function(handle: PPsnd_seq_t; name: PChar; streams: cint; mode: cint; lconf: Psnd_config_t): cint; cdecl;
  Tsnd_seq_name= function(seq: Psnd_seq_t): PChar; cdecl;
  Tsnd_seq_type= function(seq: Psnd_seq_t): snd_seq_type_t; cdecl;
  Tsnd_seq_close= function(handle: Psnd_seq_t): cint; cdecl;
  Tsnd_seq_poll_descriptors_count= function(handle: Psnd_seq_t; events: cshort): cint; cdecl;
  Tsnd_seq_poll_descriptors= function(handle: Psnd_seq_t; pfds: {struct pollfd*}Pointer; space: cuint; events: cshort): cint; cdecl;
  Tsnd_seq_poll_descriptors_revents= function(seq: Psnd_seq_t; pfds: {struct pollfd*}Pointer; nfds: cuint; revents: Pcushort): cint; cdecl;
  Tsnd_seq_nonblock= function(handle: Psnd_seq_t; nonblock: cint): cint; cdecl;
  Tsnd_seq_client_id= function(handle: Psnd_seq_t): cint; cdecl;
  Tsnd_seq_get_output_buffer_size= function(handle: Psnd_seq_t): size_t; cdecl;
  Tsnd_seq_get_input_buffer_size= function(handle: Psnd_seq_t): size_t; cdecl;
  Tsnd_seq_set_output_buffer_size= function(handle: Psnd_seq_t; size: size_t): cint; cdecl;
  Tsnd_seq_set_input_buffer_size= function(handle: Psnd_seq_t; size: size_t): cint; cdecl;
  Tsnd_seq_system_info_sizeof= function: size_t; cdecl;
  Tsnd_seq_system_info_malloc= function(ptr: PPsnd_seq_system_info_t): cint; cdecl;
  Tsnd_seq_system_info_free= procedure(ptr: Psnd_seq_system_info_t); cdecl;
  Tsnd_seq_system_info_copy= procedure(dst: Psnd_seq_system_info_t; src: Psnd_seq_system_info_t); cdecl;
  Tsnd_seq_system_info_get_queues= function(info: Psnd_seq_system_info_t): cint; cdecl;
  Tsnd_seq_system_info_get_clients= function(info: Psnd_seq_system_info_t): cint; cdecl;
  Tsnd_seq_system_info_get_ports= function(info: Psnd_seq_system_info_t): cint; cdecl;
  Tsnd_seq_system_info_get_channels= function(info: Psnd_seq_system_info_t): cint; cdecl;
  Tsnd_seq_system_info_get_cur_clients= function(info: Psnd_seq_system_info_t): cint; cdecl;
  Tsnd_seq_system_info_get_cur_queues= function(info: Psnd_seq_system_info_t): cint; cdecl;
  Tsnd_seq_system_info= function(handle: Psnd_seq_t; info: Psnd_seq_system_info_t): cint; cdecl;
  Tsnd_seq_client_info_sizeof= function: size_t; cdecl;
  Tsnd_seq_client_info_malloc= function(ptr: PPsnd_seq_client_info_t): cint; cdecl;
  Tsnd_seq_client_info_free= procedure(ptr: Psnd_seq_client_info_t); cdecl;
  Tsnd_seq_client_info_copy= procedure(dst: Psnd_seq_client_info_t; src: Psnd_seq_client_info_t); cdecl;
  Tsnd_seq_client_info_get_client= function(info: Psnd_seq_client_info_t): cint; cdecl;
  Tsnd_seq_client_info_get_type= function(info: Psnd_seq_client_info_t): snd_seq_client_type_t; cdecl;
  Tsnd_seq_client_info_get_name= function(info: Psnd_seq_client_info_t): PChar; cdecl;
  Tsnd_seq_client_info_get_broadcast_filter= function(info: Psnd_seq_client_info_t): cint; cdecl;
  Tsnd_seq_client_info_get_error_bounce= function(info: Psnd_seq_client_info_t): cint; cdecl;
  Tsnd_seq_client_info_get_event_filter= function(info: Psnd_seq_client_info_t): Pcuchar; cdecl;
  Tsnd_seq_client_info_get_num_ports= function(info: Psnd_seq_client_info_t): cint; cdecl;
  Tsnd_seq_client_info_get_event_lost= function(info: Psnd_seq_client_info_t): cint; cdecl;
  Tsnd_seq_client_info_set_client= procedure(info: Psnd_seq_client_info_t; client: cint); cdecl;
  Tsnd_seq_client_info_set_name= procedure(info: Psnd_seq_client_info_t; name: PChar); cdecl;
  Tsnd_seq_client_info_set_broadcast_filter= procedure(info: Psnd_seq_client_info_t; val: cint); cdecl;
  Tsnd_seq_client_info_set_error_bounce= procedure(info: Psnd_seq_client_info_t; val: cint); cdecl;
  Tsnd_seq_client_info_set_event_filter= procedure(info: Psnd_seq_client_info_t; filter: Pcuchar); cdecl;
  Tsnd_seq_client_info_event_filter_clear= procedure(info: Psnd_seq_client_info_t); cdecl;
  Tsnd_seq_client_info_event_filter_add= procedure(info: Psnd_seq_client_info_t; event_type: cint); cdecl;
  Tsnd_seq_client_info_event_filter_del= procedure(info: Psnd_seq_client_info_t; event_type: cint); cdecl;
  Tsnd_seq_client_info_event_filter_check= function(info: Psnd_seq_client_info_t; event_type: cint): cint; cdecl;
  Tsnd_seq_get_client_info= function(handle: Psnd_seq_t; info: Psnd_seq_client_info_t): cint; cdecl;
  Tsnd_seq_get_any_client_info= function(handle: Psnd_seq_t; client: cint; info: Psnd_seq_client_info_t): cint; cdecl;
  Tsnd_seq_set_client_info= function(handle: Psnd_seq_t; info: Psnd_seq_client_info_t): cint; cdecl;
  Tsnd_seq_query_next_client= function(handle: Psnd_seq_t; info: Psnd_seq_client_info_t): cint; cdecl;
  Tsnd_seq_client_pool_sizeof= function: size_t; cdecl;
  Tsnd_seq_client_pool_malloc= function(ptr: PPsnd_seq_client_pool_t): cint; cdecl;
  Tsnd_seq_client_pool_free= procedure(ptr: Psnd_seq_client_pool_t); cdecl;
  Tsnd_seq_client_pool_copy= procedure(dst: Psnd_seq_client_pool_t; src: Psnd_seq_client_pool_t); cdecl;
  Tsnd_seq_client_pool_get_client= function(info: Psnd_seq_client_pool_t): cint; cdecl;
  Tsnd_seq_client_pool_get_output_pool= function(info: Psnd_seq_client_pool_t): size_t; cdecl;
  Tsnd_seq_client_pool_get_input_pool= function(info: Psnd_seq_client_pool_t): size_t; cdecl;
  Tsnd_seq_client_pool_get_output_room= function(info: Psnd_seq_client_pool_t): size_t; cdecl;
  Tsnd_seq_client_pool_get_output_free= function(info: Psnd_seq_client_pool_t): size_t; cdecl;
  Tsnd_seq_client_pool_get_input_free= function(info: Psnd_seq_client_pool_t): size_t; cdecl;
  Tsnd_seq_client_pool_set_output_pool= procedure(info: Psnd_seq_client_pool_t; size: size_t); cdecl;
  Tsnd_seq_client_pool_set_input_pool= procedure(info: Psnd_seq_client_pool_t; size: size_t); cdecl;
  Tsnd_seq_client_pool_set_output_room= procedure(info: Psnd_seq_client_pool_t; size: size_t); cdecl;
  Tsnd_seq_get_client_pool= function(handle: Psnd_seq_t; info: Psnd_seq_client_pool_t): cint; cdecl;
  Tsnd_seq_set_client_pool= function(handle: Psnd_seq_t; info: Psnd_seq_client_pool_t): cint; cdecl;
  Tsnd_seq_port_info_sizeof= function: size_t; cdecl;
  Tsnd_seq_port_info_malloc= function(ptr: PPsnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_port_info_free= procedure(ptr: Psnd_seq_port_info_t); cdecl;
  Tsnd_seq_port_info_copy= procedure(dst: Psnd_seq_port_info_t; src: Psnd_seq_port_info_t); cdecl;
  Tsnd_seq_port_info_get_client= function(info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_port_info_get_port= function(info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_port_info_get_addr= function(info: Psnd_seq_port_info_t): Psnd_seq_addr_t; cdecl;
  Tsnd_seq_port_info_get_name= function(info: Psnd_seq_port_info_t): PChar; cdecl;
  Tsnd_seq_port_info_get_capability= function(info: Psnd_seq_port_info_t): cuint; cdecl;
  Tsnd_seq_port_info_get_type= function(info: Psnd_seq_port_info_t): cuint; cdecl;
  Tsnd_seq_port_info_get_midi_channels= function(info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_port_info_get_midi_voices= function(info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_port_info_get_synth_voices= function(info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_port_info_get_read_use= function(info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_port_info_get_write_use= function(info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_port_info_get_port_specified= function(info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_port_info_get_timestamping= function(info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_port_info_get_timestamp_real= function(info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_port_info_get_timestamp_queue= function(info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_port_info_set_client= procedure(info: Psnd_seq_port_info_t; client: cint); cdecl;
  Tsnd_seq_port_info_set_port= procedure(info: Psnd_seq_port_info_t; port: cint); cdecl;
  Tsnd_seq_port_info_set_addr= procedure(info: Psnd_seq_port_info_t; addr: Psnd_seq_addr_t); cdecl;
  Tsnd_seq_port_info_set_name= procedure(info: Psnd_seq_port_info_t; name: PChar); cdecl;
  Tsnd_seq_port_info_set_capability= procedure(info: Psnd_seq_port_info_t; capability: cuint); cdecl;
  Tsnd_seq_port_info_set_type= procedure(info: Psnd_seq_port_info_t; _type: cuint); cdecl;
  Tsnd_seq_port_info_set_midi_channels= procedure(info: Psnd_seq_port_info_t; channels: cint); cdecl;
  Tsnd_seq_port_info_set_midi_voices= procedure(info: Psnd_seq_port_info_t; voices: cint); cdecl;
  Tsnd_seq_port_info_set_synth_voices= procedure(info: Psnd_seq_port_info_t; voices: cint); cdecl;
  Tsnd_seq_port_info_set_port_specified= procedure(info: Psnd_seq_port_info_t; val: cint); cdecl;
  Tsnd_seq_port_info_set_timestamping= procedure(info: Psnd_seq_port_info_t; enable: cint); cdecl;
  Tsnd_seq_port_info_set_timestamp_real= procedure(info: Psnd_seq_port_info_t; realtime: cint); cdecl;
  Tsnd_seq_port_info_set_timestamp_queue= procedure(info: Psnd_seq_port_info_t; queue: cint); cdecl;
  Tsnd_seq_create_port= function(handle: Psnd_seq_t; info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_delete_port= function(handle: Psnd_seq_t; port: cint): cint; cdecl;
  Tsnd_seq_get_port_info= function(handle: Psnd_seq_t; port: cint; info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_get_any_port_info= function(handle: Psnd_seq_t; client: cint; port: cint; info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_set_port_info= function(handle: Psnd_seq_t; port: cint; info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_query_next_port= function(handle: Psnd_seq_t; info: Psnd_seq_port_info_t): cint; cdecl;
  Tsnd_seq_port_subscribe_sizeof= function: size_t; cdecl;
  Tsnd_seq_port_subscribe_malloc= function(ptr: PPsnd_seq_port_subscribe_t): cint; cdecl;
  Tsnd_seq_port_subscribe_free= procedure(ptr: Psnd_seq_port_subscribe_t); cdecl;
  Tsnd_seq_port_subscribe_copy= procedure(dst: Psnd_seq_port_subscribe_t; src: Psnd_seq_port_subscribe_t); cdecl;
  Tsnd_seq_port_subscribe_get_sender= function(info: Psnd_seq_port_subscribe_t): Psnd_seq_addr_t; cdecl;
  Tsnd_seq_port_subscribe_get_dest= function(info: Psnd_seq_port_subscribe_t): Psnd_seq_addr_t; cdecl;
  Tsnd_seq_port_subscribe_get_queue= function(info: Psnd_seq_port_subscribe_t): cint; cdecl;
  Tsnd_seq_port_subscribe_get_exclusive= function(info: Psnd_seq_port_subscribe_t): cint; cdecl;
  Tsnd_seq_port_subscribe_get_time_update= function(info: Psnd_seq_port_subscribe_t): cint; cdecl;
  Tsnd_seq_port_subscribe_get_time_real= function(info: Psnd_seq_port_subscribe_t): cint; cdecl;
  Tsnd_seq_port_subscribe_set_sender= procedure(info: Psnd_seq_port_subscribe_t; addr: Psnd_seq_addr_t); cdecl;
  Tsnd_seq_port_subscribe_set_dest= procedure(info: Psnd_seq_port_subscribe_t; addr: Psnd_seq_addr_t); cdecl;
  Tsnd_seq_port_subscribe_set_queue= procedure(info: Psnd_seq_port_subscribe_t; q: cint); cdecl;
  Tsnd_seq_port_subscribe_set_exclusive= procedure(info: Psnd_seq_port_subscribe_t; val: cint); cdecl;
  Tsnd_seq_port_subscribe_set_time_update= procedure(info: Psnd_seq_port_subscribe_t; val: cint); cdecl;
  Tsnd_seq_port_subscribe_set_time_real= procedure(info: Psnd_seq_port_subscribe_t; val: cint); cdecl;
  Tsnd_seq_get_port_subscription= function(handle: Psnd_seq_t; sub: Psnd_seq_port_subscribe_t): cint; cdecl;
  Tsnd_seq_subscribe_port= function(handle: Psnd_seq_t; sub: Psnd_seq_port_subscribe_t): cint; cdecl;
  Tsnd_seq_unsubscribe_port= function(handle: Psnd_seq_t; sub: Psnd_seq_port_subscribe_t): cint; cdecl;
  Tsnd_seq_query_subscribe_sizeof= function: size_t; cdecl;
  Tsnd_seq_query_subscribe_malloc= function(ptr: PPsnd_seq_query_subscribe_t): cint; cdecl;
  Tsnd_seq_query_subscribe_free= procedure(ptr: Psnd_seq_query_subscribe_t); cdecl;
  Tsnd_seq_query_subscribe_copy= procedure(dst: Psnd_seq_query_subscribe_t; src: Psnd_seq_query_subscribe_t); cdecl;
  Tsnd_seq_query_subscribe_get_client= function(info: Psnd_seq_query_subscribe_t): cint; cdecl;
  Tsnd_seq_query_subscribe_get_port= function(info: Psnd_seq_query_subscribe_t): cint; cdecl;
  Tsnd_seq_query_subscribe_get_root= function(info: Psnd_seq_query_subscribe_t): Psnd_seq_addr_t; cdecl;
  Tsnd_seq_query_subscribe_get_type= function(info: Psnd_seq_query_subscribe_t): snd_seq_query_subs_type_t; cdecl;
  Tsnd_seq_query_subscribe_get_index= function(info: Psnd_seq_query_subscribe_t): cint; cdecl;
  Tsnd_seq_query_subscribe_get_num_subs= function(info: Psnd_seq_query_subscribe_t): cint; cdecl;
  Tsnd_seq_query_subscribe_get_addr= function(info: Psnd_seq_query_subscribe_t): Psnd_seq_addr_t; cdecl;
  Tsnd_seq_query_subscribe_get_queue= function(info: Psnd_seq_query_subscribe_t): cint; cdecl;
  Tsnd_seq_query_subscribe_get_exclusive= function(info: Psnd_seq_query_subscribe_t): cint; cdecl;
  Tsnd_seq_query_subscribe_get_time_update= function(info: Psnd_seq_query_subscribe_t): cint; cdecl;
  Tsnd_seq_query_subscribe_get_time_real= function(info: Psnd_seq_query_subscribe_t): cint; cdecl;
  Tsnd_seq_query_subscribe_set_client= procedure(info: Psnd_seq_query_subscribe_t; client: cint); cdecl;
  Tsnd_seq_query_subscribe_set_port= procedure(info: Psnd_seq_query_subscribe_t; port: cint); cdecl;
  Tsnd_seq_query_subscribe_set_root= procedure(info: Psnd_seq_query_subscribe_t; addr: Psnd_seq_addr_t); cdecl;
  Tsnd_seq_query_subscribe_set_type= procedure(info: Psnd_seq_query_subscribe_t; _type: snd_seq_query_subs_type_t); cdecl;
  Tsnd_seq_query_subscribe_set_index= procedure(info: Psnd_seq_query_subscribe_t; _index: cint); cdecl;
  Tsnd_seq_query_port_subscribers= function(seq: Psnd_seq_t; subs: Psnd_seq_query_subscribe_t): cint; cdecl;
  Tsnd_seq_queue_info_sizeof= function: size_t; cdecl;
  Tsnd_seq_queue_info_malloc= function(ptr: PPsnd_seq_queue_info_t): cint; cdecl;
  Tsnd_seq_queue_info_free= procedure(ptr: Psnd_seq_queue_info_t); cdecl;
  Tsnd_seq_queue_info_copy= procedure(dst: Psnd_seq_queue_info_t; src: Psnd_seq_queue_info_t); cdecl;
  Tsnd_seq_queue_info_get_queue= function(info: Psnd_seq_queue_info_t): cint; cdecl;
  Tsnd_seq_queue_info_get_name= function(info: Psnd_seq_queue_info_t): PChar; cdecl;
  Tsnd_seq_queue_info_get_owner= function(info: Psnd_seq_queue_info_t): cint; cdecl;
  Tsnd_seq_queue_info_get_locked= function(info: Psnd_seq_queue_info_t): cint; cdecl;
  Tsnd_seq_queue_info_get_flags= function(info: Psnd_seq_queue_info_t): cuint; cdecl;
  Tsnd_seq_queue_info_set_name= procedure(info: Psnd_seq_queue_info_t; name: PChar); cdecl;
  Tsnd_seq_queue_info_set_owner= procedure(info: Psnd_seq_queue_info_t; owner: cint); cdecl;
  Tsnd_seq_queue_info_set_locked= procedure(info: Psnd_seq_queue_info_t; locked: cint); cdecl;
  Tsnd_seq_queue_info_set_flags= procedure(info: Psnd_seq_queue_info_t; flags: cuint); cdecl;
  Tsnd_seq_create_queue= function(seq: Psnd_seq_t; info: Psnd_seq_queue_info_t): cint; cdecl;
  Tsnd_seq_alloc_named_queue= function(seq: Psnd_seq_t; name: PChar): cint; cdecl;
  Tsnd_seq_alloc_queue= function(handle: Psnd_seq_t): cint; cdecl;
  Tsnd_seq_free_queue= function(handle: Psnd_seq_t; q: cint): cint; cdecl;
  Tsnd_seq_get_queue_info= function(seq: Psnd_seq_t; q: cint; info: Psnd_seq_queue_info_t): cint; cdecl;
  Tsnd_seq_set_queue_info= function(seq: Psnd_seq_t; q: cint; info: Psnd_seq_queue_info_t): cint; cdecl;
  Tsnd_seq_query_named_queue= function(seq: Psnd_seq_t; name: PChar): cint; cdecl;
  Tsnd_seq_get_queue_usage= function(handle: Psnd_seq_t; q: cint): cint; cdecl;
  Tsnd_seq_set_queue_usage= function(handle: Psnd_seq_t; q: cint; used: cint): cint; cdecl;
  Tsnd_seq_queue_status_sizeof= function: size_t; cdecl;
  Tsnd_seq_queue_status_malloc= function(ptr: PPsnd_seq_queue_status_t): cint; cdecl;
  Tsnd_seq_queue_status_free= procedure(ptr: Psnd_seq_queue_status_t); cdecl;
  Tsnd_seq_queue_status_copy= procedure(dst: Psnd_seq_queue_status_t; src: Psnd_seq_queue_status_t); cdecl;
  Tsnd_seq_queue_status_get_queue= function(info: Psnd_seq_queue_status_t): cint; cdecl;
  Tsnd_seq_queue_status_get_events= function(info: Psnd_seq_queue_status_t): cint; cdecl;
  Tsnd_seq_queue_status_get_tick_time= function(info: Psnd_seq_queue_status_t): snd_seq_tick_time_t; cdecl;
  Tsnd_seq_queue_status_get_real_time= function(info: Psnd_seq_queue_status_t): Psnd_seq_real_time_t; cdecl;
  Tsnd_seq_queue_status_get_status= function(info: Psnd_seq_queue_status_t): cuint; cdecl;
  Tsnd_seq_get_queue_status= function(handle: Psnd_seq_t; q: cint; status: Psnd_seq_queue_status_t): cint; cdecl;
  Tsnd_seq_queue_tempo_sizeof= function: size_t; cdecl;
  Tsnd_seq_queue_tempo_malloc= function(ptr: PPsnd_seq_queue_tempo_t): cint; cdecl;
  Tsnd_seq_queue_tempo_free= procedure(ptr: Psnd_seq_queue_tempo_t); cdecl;
  Tsnd_seq_queue_tempo_copy= procedure(dst: Psnd_seq_queue_tempo_t; src: Psnd_seq_queue_tempo_t); cdecl;
  Tsnd_seq_queue_tempo_get_queue= function(info: Psnd_seq_queue_tempo_t): cint; cdecl;
  Tsnd_seq_queue_tempo_get_tempo= function(info: Psnd_seq_queue_tempo_t): cuint; cdecl;
  Tsnd_seq_queue_tempo_get_ppq= function(info: Psnd_seq_queue_tempo_t): cint; cdecl;
  Tsnd_seq_queue_tempo_get_skew= function(info: Psnd_seq_queue_tempo_t): cuint; cdecl;
  Tsnd_seq_queue_tempo_get_skew_base= function(info: Psnd_seq_queue_tempo_t): cuint; cdecl;
  Tsnd_seq_queue_tempo_set_tempo= procedure(info: Psnd_seq_queue_tempo_t; tempo: cuint); cdecl;
  Tsnd_seq_queue_tempo_set_ppq= procedure(info: Psnd_seq_queue_tempo_t; ppq: cint); cdecl;
  Tsnd_seq_queue_tempo_set_skew= procedure(info: Psnd_seq_queue_tempo_t; skew: cuint); cdecl;
  Tsnd_seq_queue_tempo_set_skew_base= procedure(info: Psnd_seq_queue_tempo_t; base: cuint); cdecl;
  Tsnd_seq_get_queue_tempo= function(handle: Psnd_seq_t; q: cint; tempo: Psnd_seq_queue_tempo_t): cint; cdecl;
  Tsnd_seq_set_queue_tempo= function(handle: Psnd_seq_t; q: cint; tempo: Psnd_seq_queue_tempo_t): cint; cdecl;
  Tsnd_seq_queue_timer_sizeof= function: size_t; cdecl;
  Tsnd_seq_queue_timer_malloc= function(ptr: PPsnd_seq_queue_timer_t): cint; cdecl;
  Tsnd_seq_queue_timer_free= procedure(ptr: Psnd_seq_queue_timer_t); cdecl;
  Tsnd_seq_queue_timer_copy= procedure(dst: Psnd_seq_queue_timer_t; src: Psnd_seq_queue_timer_t); cdecl;
  Tsnd_seq_queue_timer_get_queue= function(info: Psnd_seq_queue_timer_t): cint; cdecl;
  Tsnd_seq_queue_timer_get_type= function(info: Psnd_seq_queue_timer_t): snd_seq_queue_timer_type_t; cdecl;
  Tsnd_seq_queue_timer_get_id= function(info: Psnd_seq_queue_timer_t): Psnd_timer_id_t; cdecl;
  Tsnd_seq_queue_timer_get_resolution= function(info: Psnd_seq_queue_timer_t): cuint; cdecl;
  Tsnd_seq_queue_timer_set_type= procedure(info: Psnd_seq_queue_timer_t; type_: snd_seq_queue_timer_type_t); cdecl;
  Tsnd_seq_queue_timer_set_id= procedure(info: Psnd_seq_queue_timer_t; id: Psnd_timer_id_t); cdecl;
  Tsnd_seq_queue_timer_set_resolution= procedure(info: Psnd_seq_queue_timer_t; resolution: cuint); cdecl;
  Tsnd_seq_get_queue_timer= function(handle: Psnd_seq_t; q: cint; timer: Psnd_seq_queue_timer_t): cint; cdecl;
  Tsnd_seq_set_queue_timer= function(handle: Psnd_seq_t; q: cint; timer: Psnd_seq_queue_timer_t): cint; cdecl;
  Tsnd_seq_free_event= function(ev: Psnd_seq_event_t): cint; cdecl;
  Tsnd_seq_event_length= function(ev: Psnd_seq_event_t): ssize_t; cdecl;
  Tsnd_seq_event_output= function(handle: Psnd_seq_t; ev: Psnd_seq_event_t): cint; cdecl;
  Tsnd_seq_event_output_buffer= function(handle: Psnd_seq_t; ev: Psnd_seq_event_t): cint; cdecl;
  Tsnd_seq_event_output_direct= function(handle: Psnd_seq_t; ev: Psnd_seq_event_t): cint; cdecl;
  Tsnd_seq_event_input= function(handle: Psnd_seq_t; ev: PPsnd_seq_event_t): cint; cdecl;
  Tsnd_seq_event_input_pending= function(seq: Psnd_seq_t; fetch_sequencer: cint): cint; cdecl;
  Tsnd_seq_drain_output= function(handle: Psnd_seq_t): cint; cdecl;
  Tsnd_seq_event_output_pending= function(seq: Psnd_seq_t): cint; cdecl;
  Tsnd_seq_extract_output= function(handle: Psnd_seq_t; ev: PPsnd_seq_event_t): cint; cdecl;
  Tsnd_seq_drop_output= function(handle: Psnd_seq_t): cint; cdecl;
  Tsnd_seq_drop_output_buffer= function(handle: Psnd_seq_t): cint; cdecl;
  Tsnd_seq_drop_input= function(handle: Psnd_seq_t): cint; cdecl;
  Tsnd_seq_drop_input_buffer= function(handle: Psnd_seq_t): cint; cdecl;
  Tsnd_seq_remove_events_sizeof= function: size_t; cdecl;
  Tsnd_seq_remove_events_malloc= function(ptr: PPsnd_seq_remove_events_t): cint; cdecl;
  Tsnd_seq_remove_events_free= procedure(ptr: Psnd_seq_remove_events_t); cdecl;
  Tsnd_seq_remove_events_copy= procedure(dst: Psnd_seq_remove_events_t; src: Psnd_seq_remove_events_t); cdecl;
  Tsnd_seq_remove_events_get_condition= function(info: Psnd_seq_remove_events_t): cuint; cdecl;
  Tsnd_seq_remove_events_get_queue= function(info: Psnd_seq_remove_events_t): cint; cdecl;
  Tsnd_seq_remove_events_get_time= function(info: Psnd_seq_remove_events_t): Psnd_seq_timestamp_t; cdecl;
  Tsnd_seq_remove_events_get_dest= function(info: Psnd_seq_remove_events_t): Psnd_seq_addr_t; cdecl;
  Tsnd_seq_remove_events_get_channel= function(info: Psnd_seq_remove_events_t): cint; cdecl;
  Tsnd_seq_remove_events_get_event_type= function(info: Psnd_seq_remove_events_t): cint; cdecl;
  Tsnd_seq_remove_events_get_tag= function(info: Psnd_seq_remove_events_t): cint; cdecl;
  Tsnd_seq_remove_events_set_condition= procedure(info: Psnd_seq_remove_events_t; flags: cuint); cdecl;
  Tsnd_seq_remove_events_set_queue= procedure(info: Psnd_seq_remove_events_t; queue: cint); cdecl;
  Tsnd_seq_remove_events_set_time= procedure(info: Psnd_seq_remove_events_t; time: Psnd_seq_timestamp_t); cdecl;
  Tsnd_seq_remove_events_set_dest= procedure(info: Psnd_seq_remove_events_t; addr: Psnd_seq_addr_t); cdecl;
  Tsnd_seq_remove_events_set_channel= procedure(info: Psnd_seq_remove_events_t; channel: cint); cdecl;
  Tsnd_seq_remove_events_set_event_type= procedure(info: Psnd_seq_remove_events_t; type_: cint); cdecl;
  Tsnd_seq_remove_events_set_tag= procedure(info: Psnd_seq_remove_events_t; tag: cint); cdecl;
  Tsnd_seq_remove_events= function(handle: Psnd_seq_t; info: Psnd_seq_remove_events_t): cint; cdecl;
  Tsnd_seq_set_bit= procedure(nr: cint; array_: Pointer); cdecl;
  Tsnd_seq_unset_bit= procedure(nr: cint; array_: Pointer); cdecl;
  Tsnd_seq_change_bit= function(nr: cint; array_: Pointer): cint; cdecl;
  Tsnd_seq_get_bit= function(nr: cint; array_: Pointer): cint; cdecl;
  Tsnd_seq_create_simple_port= function(seq: Psnd_seq_t; name: PChar; caps, type_: cuint): cint; cdecl;
  Tsnd_seq_delete_simple_port= function(seq: Psnd_seq_t; port: cint): cint; cdecl;
  Tsnd_seq_connect_from= function(seq: Psnd_seq_t; my_port, src_client, src_port: cint): cint; cdecl;
  Tsnd_seq_connect_to= function(seq: Psnd_seq_t; my_port, dest_client, dest_port: cint): cint; cdecl;
  Tsnd_seq_disconnect_from= function(seq: Psnd_seq_t; my_port, src_client, src_port: cint): cint; cdecl;
  Tsnd_seq_disconnect_to= function(seq: Psnd_seq_t; my_port, dest_client, dest_port: cint): cint; cdecl;
  Tsnd_seq_set_client_name= function(seq: Psnd_seq_t; name: PChar): cint; cdecl;
  Tsnd_seq_set_client_event_filter= function(seq: Psnd_seq_t; event_type: cint): cint; cdecl;
  Tsnd_seq_set_client_pool_output= function(seq: Psnd_seq_t; size: size_t): cint; cdecl;
  Tsnd_seq_set_client_pool_output_room= function(seq: Psnd_seq_t; size: size_t): cint; cdecl;
  Tsnd_seq_set_client_pool_input= function(seq: Psnd_seq_t; size: size_t): cint; cdecl;
  Tsnd_seq_sync_output_queue= function(seq: Psnd_seq_t): cint; cdecl;
  Tsnd_seq_parse_address= function(seq: Psnd_seq_t; addr: Psnd_seq_addr_t; str: PChar): cint; cdecl;
  Tsnd_seq_reset_pool_output= function(seq: Psnd_seq_t): cint; cdecl;
  Tsnd_seq_reset_pool_input= function(seq: Psnd_seq_t): cint; cdecl;
  Tsnd_seq_control_queue= function(seq: Psnd_seq_t; q, type_, value: cint; ev: Psnd_seq_event_t): cint; cdecl;
  Tsnd_strerror= function(errnum: cint): PChar; cdecl;

type
  TAsoundSeq= class(TDynamicModule)
  strict private
    Fsnd_seq_open: Tsnd_seq_open;
    Fsnd_seq_open_lconf: Tsnd_seq_open_lconf;
    Fsnd_seq_name: Tsnd_seq_name;
    Fsnd_seq_type: Tsnd_seq_type;
    Fsnd_seq_close: Tsnd_seq_close;
    Fsnd_seq_poll_descriptors_count: Tsnd_seq_poll_descriptors_count;
    Fsnd_seq_poll_descriptors: Tsnd_seq_poll_descriptors;
    Fsnd_seq_poll_descriptors_revents: Tsnd_seq_poll_descriptors_revents;
    Fsnd_seq_nonblock: Tsnd_seq_nonblock;
    Fsnd_seq_client_id: Tsnd_seq_client_id;
    Fsnd_seq_get_output_buffer_size: Tsnd_seq_get_output_buffer_size;
    Fsnd_seq_get_input_buffer_size: Tsnd_seq_get_input_buffer_size;
    Fsnd_seq_set_output_buffer_size: Tsnd_seq_set_output_buffer_size;
    Fsnd_seq_set_input_buffer_size: Tsnd_seq_set_input_buffer_size;
    Fsnd_seq_system_info_sizeof: Tsnd_seq_system_info_sizeof;
    Fsnd_seq_system_info_malloc: Tsnd_seq_system_info_malloc;
    Fsnd_seq_system_info_free: Tsnd_seq_system_info_free;
    Fsnd_seq_system_info_copy: Tsnd_seq_system_info_copy;
    Fsnd_seq_system_info_get_queues: Tsnd_seq_system_info_get_queues;
    Fsnd_seq_system_info_get_clients: Tsnd_seq_system_info_get_clients;
    Fsnd_seq_system_info_get_ports: Tsnd_seq_system_info_get_ports;
    Fsnd_seq_system_info_get_channels: Tsnd_seq_system_info_get_channels;
    Fsnd_seq_system_info_get_cur_clients: Tsnd_seq_system_info_get_cur_clients;
    Fsnd_seq_system_info_get_cur_queues: Tsnd_seq_system_info_get_cur_queues;
    Fsnd_seq_system_info: Tsnd_seq_system_info;
    Fsnd_seq_client_info_sizeof: Tsnd_seq_client_info_sizeof;
    Fsnd_seq_client_info_malloc: Tsnd_seq_client_info_malloc;
    Fsnd_seq_client_info_free: Tsnd_seq_client_info_free;
    Fsnd_seq_client_info_copy: Tsnd_seq_client_info_copy;
    Fsnd_seq_client_info_get_client: Tsnd_seq_client_info_get_client;
    Fsnd_seq_client_info_get_type: Tsnd_seq_client_info_get_type;
    Fsnd_seq_client_info_get_name: Tsnd_seq_client_info_get_name;
    Fsnd_seq_client_info_get_broadcast_filter: Tsnd_seq_client_info_get_broadcast_filter;
    Fsnd_seq_client_info_get_error_bounce: Tsnd_seq_client_info_get_error_bounce;
    Fsnd_seq_client_info_get_event_filter: Tsnd_seq_client_info_get_event_filter;
    Fsnd_seq_client_info_get_num_ports: Tsnd_seq_client_info_get_num_ports;
    Fsnd_seq_client_info_get_event_lost: Tsnd_seq_client_info_get_event_lost;
    Fsnd_seq_client_info_set_client: Tsnd_seq_client_info_set_client;
    Fsnd_seq_client_info_set_name: Tsnd_seq_client_info_set_name;
    Fsnd_seq_client_info_set_broadcast_filter: Tsnd_seq_client_info_set_broadcast_filter;
    Fsnd_seq_client_info_set_error_bounce: Tsnd_seq_client_info_set_error_bounce;
    Fsnd_seq_client_info_set_event_filter: Tsnd_seq_client_info_set_event_filter;
    Fsnd_seq_client_info_event_filter_clear: Tsnd_seq_client_info_event_filter_clear;
    Fsnd_seq_client_info_event_filter_add: Tsnd_seq_client_info_event_filter_add;
    Fsnd_seq_client_info_event_filter_del: Tsnd_seq_client_info_event_filter_del;
    Fsnd_seq_client_info_event_filter_check: Tsnd_seq_client_info_event_filter_check;
    Fsnd_seq_get_client_info: Tsnd_seq_get_client_info;
    Fsnd_seq_get_any_client_info: Tsnd_seq_get_any_client_info;
    Fsnd_seq_set_client_info: Tsnd_seq_set_client_info;
    Fsnd_seq_query_next_client: Tsnd_seq_query_next_client;
    Fsnd_seq_client_pool_sizeof: Tsnd_seq_client_pool_sizeof;
    Fsnd_seq_client_pool_malloc: Tsnd_seq_client_pool_malloc;
    Fsnd_seq_client_pool_free: Tsnd_seq_client_pool_free;
    Fsnd_seq_client_pool_copy: Tsnd_seq_client_pool_copy;
    Fsnd_seq_client_pool_get_client: Tsnd_seq_client_pool_get_client;
    Fsnd_seq_client_pool_get_output_pool: Tsnd_seq_client_pool_get_output_pool;
    Fsnd_seq_client_pool_get_input_pool: Tsnd_seq_client_pool_get_input_pool;
    Fsnd_seq_client_pool_get_output_room: Tsnd_seq_client_pool_get_output_room;
    Fsnd_seq_client_pool_get_output_free: Tsnd_seq_client_pool_get_output_free;
    Fsnd_seq_client_pool_get_input_free: Tsnd_seq_client_pool_get_input_free;
    Fsnd_seq_client_pool_set_output_pool: Tsnd_seq_client_pool_set_output_pool;
    Fsnd_seq_client_pool_set_input_pool: Tsnd_seq_client_pool_set_input_pool;
    Fsnd_seq_client_pool_set_output_room: Tsnd_seq_client_pool_set_output_room;
    Fsnd_seq_get_client_pool: Tsnd_seq_get_client_pool;
    Fsnd_seq_set_client_pool: Tsnd_seq_set_client_pool;
    Fsnd_seq_port_info_sizeof: Tsnd_seq_port_info_sizeof;
    Fsnd_seq_port_info_malloc: Tsnd_seq_port_info_malloc;
    Fsnd_seq_port_info_free: Tsnd_seq_port_info_free;
    Fsnd_seq_port_info_copy: Tsnd_seq_port_info_copy;
    Fsnd_seq_port_info_get_client: Tsnd_seq_port_info_get_client;
    Fsnd_seq_port_info_get_port: Tsnd_seq_port_info_get_port;
    Fsnd_seq_port_info_get_addr: Tsnd_seq_port_info_get_addr;
    Fsnd_seq_port_info_get_name: Tsnd_seq_port_info_get_name;
    Fsnd_seq_port_info_get_capability: Tsnd_seq_port_info_get_capability;
    Fsnd_seq_port_info_get_type: Tsnd_seq_port_info_get_type;
    Fsnd_seq_port_info_get_midi_channels: Tsnd_seq_port_info_get_midi_channels;
    Fsnd_seq_port_info_get_midi_voices: Tsnd_seq_port_info_get_midi_voices;
    Fsnd_seq_port_info_get_synth_voices: Tsnd_seq_port_info_get_synth_voices;
    Fsnd_seq_port_info_get_read_use: Tsnd_seq_port_info_get_read_use;
    Fsnd_seq_port_info_get_write_use: Tsnd_seq_port_info_get_write_use;
    Fsnd_seq_port_info_get_port_specified: Tsnd_seq_port_info_get_port_specified;
    Fsnd_seq_port_info_get_timestamping: Tsnd_seq_port_info_get_timestamping;
    Fsnd_seq_port_info_get_timestamp_real: Tsnd_seq_port_info_get_timestamp_real;
    Fsnd_seq_port_info_get_timestamp_queue: Tsnd_seq_port_info_get_timestamp_queue;
    Fsnd_seq_port_info_set_client: Tsnd_seq_port_info_set_client;
    Fsnd_seq_port_info_set_port: Tsnd_seq_port_info_set_port;
    Fsnd_seq_port_info_set_addr: Tsnd_seq_port_info_set_addr;
    Fsnd_seq_port_info_set_name: Tsnd_seq_port_info_set_name;
    Fsnd_seq_port_info_set_capability: Tsnd_seq_port_info_set_capability;
    Fsnd_seq_port_info_set_type: Tsnd_seq_port_info_set_type;
    Fsnd_seq_port_info_set_midi_channels: Tsnd_seq_port_info_set_midi_channels;
    Fsnd_seq_port_info_set_midi_voices: Tsnd_seq_port_info_set_midi_voices;
    Fsnd_seq_port_info_set_synth_voices: Tsnd_seq_port_info_set_synth_voices;
    Fsnd_seq_port_info_set_port_specified: Tsnd_seq_port_info_set_port_specified;
    Fsnd_seq_port_info_set_timestamping: Tsnd_seq_port_info_set_timestamping;
    Fsnd_seq_port_info_set_timestamp_real: Tsnd_seq_port_info_set_timestamp_real;
    Fsnd_seq_port_info_set_timestamp_queue: Tsnd_seq_port_info_set_timestamp_queue;
    Fsnd_seq_create_port: Tsnd_seq_create_port;
    Fsnd_seq_delete_port: Tsnd_seq_delete_port;
    Fsnd_seq_get_port_info: Tsnd_seq_get_port_info;
    Fsnd_seq_get_any_port_info: Tsnd_seq_get_any_port_info;
    Fsnd_seq_set_port_info: Tsnd_seq_set_port_info;
    Fsnd_seq_query_next_port: Tsnd_seq_query_next_port;
    Fsnd_seq_port_subscribe_sizeof: Tsnd_seq_port_subscribe_sizeof;
    Fsnd_seq_port_subscribe_malloc: Tsnd_seq_port_subscribe_malloc;
    Fsnd_seq_port_subscribe_free: Tsnd_seq_port_subscribe_free;
    Fsnd_seq_port_subscribe_copy: Tsnd_seq_port_subscribe_copy;
    Fsnd_seq_port_subscribe_get_sender: Tsnd_seq_port_subscribe_get_sender;
    Fsnd_seq_port_subscribe_get_dest: Tsnd_seq_port_subscribe_get_dest;
    Fsnd_seq_port_subscribe_get_queue: Tsnd_seq_port_subscribe_get_queue;
    Fsnd_seq_port_subscribe_get_exclusive: Tsnd_seq_port_subscribe_get_exclusive;
    Fsnd_seq_port_subscribe_get_time_update: Tsnd_seq_port_subscribe_get_time_update;
    Fsnd_seq_port_subscribe_get_time_real: Tsnd_seq_port_subscribe_get_time_real;
    Fsnd_seq_port_subscribe_set_sender: Tsnd_seq_port_subscribe_set_sender;
    Fsnd_seq_port_subscribe_set_dest: Tsnd_seq_port_subscribe_set_dest;
    Fsnd_seq_port_subscribe_set_queue: Tsnd_seq_port_subscribe_set_queue;
    Fsnd_seq_port_subscribe_set_exclusive: Tsnd_seq_port_subscribe_set_exclusive;
    Fsnd_seq_port_subscribe_set_time_update: Tsnd_seq_port_subscribe_set_time_update;
    Fsnd_seq_port_subscribe_set_time_real: Tsnd_seq_port_subscribe_set_time_real;
    Fsnd_seq_get_port_subscription: Tsnd_seq_get_port_subscription;
    Fsnd_seq_subscribe_port: Tsnd_seq_subscribe_port;
    Fsnd_seq_unsubscribe_port: Tsnd_seq_unsubscribe_port;
    Fsnd_seq_query_subscribe_sizeof: Tsnd_seq_query_subscribe_sizeof;
    Fsnd_seq_query_subscribe_malloc: Tsnd_seq_query_subscribe_malloc;
    Fsnd_seq_query_subscribe_free: Tsnd_seq_query_subscribe_free;
    Fsnd_seq_query_subscribe_copy: Tsnd_seq_query_subscribe_copy;
    Fsnd_seq_query_subscribe_get_client: Tsnd_seq_query_subscribe_get_client;
    Fsnd_seq_query_subscribe_get_port: Tsnd_seq_query_subscribe_get_port;
    Fsnd_seq_query_subscribe_get_root: Tsnd_seq_query_subscribe_get_root;
    Fsnd_seq_query_subscribe_get_type: Tsnd_seq_query_subscribe_get_type;
    Fsnd_seq_query_subscribe_get_index: Tsnd_seq_query_subscribe_get_index;
    Fsnd_seq_query_subscribe_get_num_subs: Tsnd_seq_query_subscribe_get_num_subs;
    Fsnd_seq_query_subscribe_get_addr: Tsnd_seq_query_subscribe_get_addr;
    Fsnd_seq_query_subscribe_get_queue: Tsnd_seq_query_subscribe_get_queue;
    Fsnd_seq_query_subscribe_get_exclusive: Tsnd_seq_query_subscribe_get_exclusive;
    Fsnd_seq_query_subscribe_get_time_update: Tsnd_seq_query_subscribe_get_time_update;
    Fsnd_seq_query_subscribe_get_time_real: Tsnd_seq_query_subscribe_get_time_real;
    Fsnd_seq_query_subscribe_set_client: Tsnd_seq_query_subscribe_set_client;
    Fsnd_seq_query_subscribe_set_port: Tsnd_seq_query_subscribe_set_port;
    Fsnd_seq_query_subscribe_set_root: Tsnd_seq_query_subscribe_set_root;
    Fsnd_seq_query_subscribe_set_type: Tsnd_seq_query_subscribe_set_type;
    Fsnd_seq_query_subscribe_set_index: Tsnd_seq_query_subscribe_set_index;
    Fsnd_seq_query_port_subscribers: Tsnd_seq_query_port_subscribers;
    Fsnd_seq_queue_info_sizeof: Tsnd_seq_queue_info_sizeof;
    Fsnd_seq_queue_info_malloc: Tsnd_seq_queue_info_malloc;
    Fsnd_seq_queue_info_free: Tsnd_seq_queue_info_free;
    Fsnd_seq_queue_info_copy: Tsnd_seq_queue_info_copy;
    Fsnd_seq_queue_info_get_queue: Tsnd_seq_queue_info_get_queue;
    Fsnd_seq_queue_info_get_name: Tsnd_seq_queue_info_get_name;
    Fsnd_seq_queue_info_get_owner: Tsnd_seq_queue_info_get_owner;
    Fsnd_seq_queue_info_get_locked: Tsnd_seq_queue_info_get_locked;
    Fsnd_seq_queue_info_get_flags: Tsnd_seq_queue_info_get_flags;
    Fsnd_seq_queue_info_set_name: Tsnd_seq_queue_info_set_name;
    Fsnd_seq_queue_info_set_owner: Tsnd_seq_queue_info_set_owner;
    Fsnd_seq_queue_info_set_locked: Tsnd_seq_queue_info_set_locked;
    Fsnd_seq_queue_info_set_flags: Tsnd_seq_queue_info_set_flags;
    Fsnd_seq_create_queue: Tsnd_seq_create_queue;
    Fsnd_seq_alloc_named_queue: Tsnd_seq_alloc_named_queue;
    Fsnd_seq_alloc_queue: Tsnd_seq_alloc_queue;
    Fsnd_seq_free_queue: Tsnd_seq_free_queue;
    Fsnd_seq_get_queue_info: Tsnd_seq_get_queue_info;
    Fsnd_seq_set_queue_info: Tsnd_seq_set_queue_info;
    Fsnd_seq_query_named_queue: Tsnd_seq_query_named_queue;
    Fsnd_seq_get_queue_usage: Tsnd_seq_get_queue_usage;
    Fsnd_seq_set_queue_usage: Tsnd_seq_set_queue_usage;
    Fsnd_seq_queue_status_sizeof: Tsnd_seq_queue_status_sizeof;
    Fsnd_seq_queue_status_malloc: Tsnd_seq_queue_status_malloc;
    Fsnd_seq_queue_status_free: Tsnd_seq_queue_status_free;
    Fsnd_seq_queue_status_copy: Tsnd_seq_queue_status_copy;
    Fsnd_seq_queue_status_get_queue: Tsnd_seq_queue_status_get_queue;
    Fsnd_seq_queue_status_get_events: Tsnd_seq_queue_status_get_events;
    Fsnd_seq_queue_status_get_tick_time: Tsnd_seq_queue_status_get_tick_time;
    Fsnd_seq_queue_status_get_real_time: Tsnd_seq_queue_status_get_real_time;
    Fsnd_seq_queue_status_get_status: Tsnd_seq_queue_status_get_status;
    Fsnd_seq_get_queue_status: Tsnd_seq_get_queue_status;
    Fsnd_seq_queue_tempo_sizeof: Tsnd_seq_queue_tempo_sizeof;
    Fsnd_seq_queue_tempo_malloc: Tsnd_seq_queue_tempo_malloc;
    Fsnd_seq_queue_tempo_free: Tsnd_seq_queue_tempo_free;
    Fsnd_seq_queue_tempo_copy: Tsnd_seq_queue_tempo_copy;
    Fsnd_seq_queue_tempo_get_queue: Tsnd_seq_queue_tempo_get_queue;
    Fsnd_seq_queue_tempo_get_tempo: Tsnd_seq_queue_tempo_get_tempo;
    Fsnd_seq_queue_tempo_get_ppq: Tsnd_seq_queue_tempo_get_ppq;
    Fsnd_seq_queue_tempo_get_skew: Tsnd_seq_queue_tempo_get_skew;
    Fsnd_seq_queue_tempo_get_skew_base: Tsnd_seq_queue_tempo_get_skew_base;
    Fsnd_seq_queue_tempo_set_tempo: Tsnd_seq_queue_tempo_set_tempo;
    Fsnd_seq_queue_tempo_set_ppq: Tsnd_seq_queue_tempo_set_ppq;
    Fsnd_seq_queue_tempo_set_skew: Tsnd_seq_queue_tempo_set_skew;
    Fsnd_seq_queue_tempo_set_skew_base: Tsnd_seq_queue_tempo_set_skew_base;
    Fsnd_seq_get_queue_tempo: Tsnd_seq_get_queue_tempo;
    Fsnd_seq_set_queue_tempo: Tsnd_seq_set_queue_tempo;
    Fsnd_seq_queue_timer_sizeof: Tsnd_seq_queue_timer_sizeof;
    Fsnd_seq_queue_timer_malloc: Tsnd_seq_queue_timer_malloc;
    Fsnd_seq_queue_timer_free: Tsnd_seq_queue_timer_free;
    Fsnd_seq_queue_timer_copy: Tsnd_seq_queue_timer_copy;
    Fsnd_seq_queue_timer_get_queue: Tsnd_seq_queue_timer_get_queue;
    Fsnd_seq_queue_timer_get_type: Tsnd_seq_queue_timer_get_type;
    Fsnd_seq_queue_timer_get_id: Tsnd_seq_queue_timer_get_id;
    Fsnd_seq_queue_timer_get_resolution: Tsnd_seq_queue_timer_get_resolution;
    Fsnd_seq_queue_timer_set_type: Tsnd_seq_queue_timer_set_type;
    Fsnd_seq_queue_timer_set_id: Tsnd_seq_queue_timer_set_id;
    Fsnd_seq_queue_timer_set_resolution: Tsnd_seq_queue_timer_set_resolution;
    Fsnd_seq_get_queue_timer: Tsnd_seq_get_queue_timer;
    Fsnd_seq_set_queue_timer: Tsnd_seq_set_queue_timer;
    Fsnd_seq_free_event: Tsnd_seq_free_event;
    Fsnd_seq_event_length: Tsnd_seq_event_length;
    Fsnd_seq_event_output: Tsnd_seq_event_output;
    Fsnd_seq_event_output_buffer: Tsnd_seq_event_output_buffer;
    Fsnd_seq_event_output_direct: Tsnd_seq_event_output_direct;
    Fsnd_seq_event_input: Tsnd_seq_event_input;
    Fsnd_seq_event_input_pending: Tsnd_seq_event_input_pending;
    Fsnd_seq_drain_output: Tsnd_seq_drain_output;
    Fsnd_seq_event_output_pending: Tsnd_seq_event_output_pending;
    Fsnd_seq_extract_output: Tsnd_seq_extract_output;
    Fsnd_seq_drop_output: Tsnd_seq_drop_output;
    Fsnd_seq_drop_output_buffer: Tsnd_seq_drop_output_buffer;
    Fsnd_seq_drop_input: Tsnd_seq_drop_input;
    Fsnd_seq_drop_input_buffer: Tsnd_seq_drop_input_buffer;
    Fsnd_seq_remove_events_sizeof: Tsnd_seq_remove_events_sizeof;
    Fsnd_seq_remove_events_malloc: Tsnd_seq_remove_events_malloc;
    Fsnd_seq_remove_events_free: Tsnd_seq_remove_events_free;
    Fsnd_seq_remove_events_copy: Tsnd_seq_remove_events_copy;
    Fsnd_seq_remove_events_get_condition: Tsnd_seq_remove_events_get_condition;
    Fsnd_seq_remove_events_get_queue: Tsnd_seq_remove_events_get_queue;
    Fsnd_seq_remove_events_get_time: Tsnd_seq_remove_events_get_time;
    Fsnd_seq_remove_events_get_dest: Tsnd_seq_remove_events_get_dest;
    Fsnd_seq_remove_events_get_channel: Tsnd_seq_remove_events_get_channel;
    Fsnd_seq_remove_events_get_event_type: Tsnd_seq_remove_events_get_event_type;
    Fsnd_seq_remove_events_get_tag: Tsnd_seq_remove_events_get_tag;
    Fsnd_seq_remove_events_set_condition: Tsnd_seq_remove_events_set_condition;
    Fsnd_seq_remove_events_set_queue: Tsnd_seq_remove_events_set_queue;
    Fsnd_seq_remove_events_set_time: Tsnd_seq_remove_events_set_time;
    Fsnd_seq_remove_events_set_dest: Tsnd_seq_remove_events_set_dest;
    Fsnd_seq_remove_events_set_channel: Tsnd_seq_remove_events_set_channel;
    Fsnd_seq_remove_events_set_event_type: Tsnd_seq_remove_events_set_event_type;
    Fsnd_seq_remove_events_set_tag: Tsnd_seq_remove_events_set_tag;
    Fsnd_seq_remove_events: Tsnd_seq_remove_events;
    Fsnd_seq_set_bit: Tsnd_seq_set_bit;
    Fsnd_seq_unset_bit: Tsnd_seq_unset_bit;
    Fsnd_seq_change_bit: Tsnd_seq_change_bit;
    Fsnd_seq_get_bit: Tsnd_seq_get_bit;
    Fsnd_seq_create_simple_port: Tsnd_seq_create_simple_port;
    Fsnd_seq_delete_simple_port: Tsnd_seq_delete_simple_port;
    Fsnd_seq_connect_from: Tsnd_seq_connect_from;
    Fsnd_seq_connect_to: Tsnd_seq_connect_to;
    Fsnd_seq_disconnect_from: Tsnd_seq_disconnect_from;
    Fsnd_seq_disconnect_to: Tsnd_seq_disconnect_to;
    Fsnd_seq_set_client_name: Tsnd_seq_set_client_name;
    Fsnd_seq_set_client_event_filter: Tsnd_seq_set_client_event_filter;
    Fsnd_seq_set_client_pool_output: Tsnd_seq_set_client_pool_output;
    Fsnd_seq_set_client_pool_output_room: Tsnd_seq_set_client_pool_output_room;
    Fsnd_seq_set_client_pool_input: Tsnd_seq_set_client_pool_input;
    Fsnd_seq_sync_output_queue: Tsnd_seq_sync_output_queue;
    Fsnd_seq_parse_address: Tsnd_seq_parse_address;
    Fsnd_seq_reset_pool_output: Tsnd_seq_reset_pool_output;
    Fsnd_seq_reset_pool_input: Tsnd_seq_reset_pool_input;
    Fsnd_seq_control_queue: Tsnd_seq_control_queue;
    Fsnd_strerror: Tsnd_strerror;
  public
    (* Case-sensitivity depends on the operating system and filesystem.
    *)
    constructor Create(const LoadName: string);
    procedure LoadVarargsRoutine(loadName: string= ''; keepGoing: boolean= false);
    {$push }
    {$macro on }
    {$undef CONSTS }
    {$undef TYPES  }
    {$define PROCS }
    {$undef VPROCS }
    {$define CDECL__:= }
    {$define CDECL_VARARGS__:= }
    {$define LIBASOUND__:= }
    {$i AsoundSeqDefs.inc }
    {$pop }
  end;

(* Return either a static or a dynamic representation of the Asound embedding
  library (libasound.so or similar). In this case it is dynamic.
*)
function AsoundSeq(): TAsoundSeq; inline;

(* Create the object and optionally load the shared object library.
*)
procedure InitialiseLibrary(const moduleName: string= DefaultModuleName;
                                        earlyLoad: boolean= DefaultEarlyLoad);

(* Create the object and optionally load the shared object library.
*)
procedure InitializeLibrary(const moduleName: string= DefaultModuleName;
                                        earlyLoad: boolean= DefaultEarlyLoad);


implementation

var
  xAsoundSeq: TAsoundSeq= nil;


constructor TAsoundSeq.Create(const LoadName: string);

begin
  inherited Create(loadName);
{$ifdef PRELOAD_ROUTINES }
  Fsnd_seq_open := Tsnd_seq_open(LoadRoutine('snd_seq_open'));
  Fsnd_seq_open_lconf := Tsnd_seq_open_lconf(LoadRoutine('snd_seq_open_lconf'));
  Fsnd_seq_name := Tsnd_seq_name(LoadRoutine('snd_seq_name'));
  Fsnd_seq_type := Tsnd_seq_type(LoadRoutine('snd_seq_type'));
  Fsnd_seq_close := Tsnd_seq_close(LoadRoutine('snd_seq_close'));
  Fsnd_seq_poll_descriptors_count := Tsnd_seq_poll_descriptors_count(LoadRoutine('snd_seq_poll_descriptors_count'));
  Fsnd_seq_poll_descriptors := Tsnd_seq_poll_descriptors(LoadRoutine('snd_seq_poll_descriptors'));
  Fsnd_seq_poll_descriptors_revents := Tsnd_seq_poll_descriptors_revents(LoadRoutine('snd_seq_poll_descriptors_revents'));
  Fsnd_seq_nonblock := Tsnd_seq_nonblock(LoadRoutine('snd_seq_nonblock'));
  Fsnd_seq_client_id := Tsnd_seq_client_id(LoadRoutine('snd_seq_client_id'));
  Fsnd_seq_get_output_buffer_size := Tsnd_seq_get_output_buffer_size(LoadRoutine('snd_seq_get_output_buffer_size'));
  Fsnd_seq_get_input_buffer_size := Tsnd_seq_get_input_buffer_size(LoadRoutine('snd_seq_get_input_buffer_size'));
  Fsnd_seq_set_output_buffer_size := Tsnd_seq_set_output_buffer_size(LoadRoutine('snd_seq_set_output_buffer_size'));
  Fsnd_seq_set_input_buffer_size := Tsnd_seq_set_input_buffer_size(LoadRoutine('snd_seq_set_input_buffer_size'));
  Fsnd_seq_system_info_sizeof := Tsnd_seq_system_info_sizeof(LoadRoutine('snd_seq_system_info_sizeof'));
  Fsnd_seq_system_info_malloc := Tsnd_seq_system_info_malloc(LoadRoutine('snd_seq_system_info_malloc'));
  Fsnd_seq_system_info_free := Tsnd_seq_system_info_free(LoadRoutine('snd_seq_system_info_free'));
  Fsnd_seq_system_info_copy := Tsnd_seq_system_info_copy(LoadRoutine('snd_seq_system_info_copy'));
  Fsnd_seq_system_info_get_queues := Tsnd_seq_system_info_get_queues(LoadRoutine('snd_seq_system_info_get_queues'));
  Fsnd_seq_system_info_get_clients := Tsnd_seq_system_info_get_clients(LoadRoutine('snd_seq_system_info_get_clients'));
  Fsnd_seq_system_info_get_ports := Tsnd_seq_system_info_get_ports(LoadRoutine('snd_seq_system_info_get_ports'));
  Fsnd_seq_system_info_get_channels := Tsnd_seq_system_info_get_channels(LoadRoutine('snd_seq_system_info_get_channels'));
  Fsnd_seq_system_info_get_cur_clients := Tsnd_seq_system_info_get_cur_clients(LoadRoutine('snd_seq_system_info_get_cur_clients'));
  Fsnd_seq_system_info_get_cur_queues := Tsnd_seq_system_info_get_cur_queues(LoadRoutine('snd_seq_system_info_get_cur_queues'));
  Fsnd_seq_system_info := Tsnd_seq_system_info(LoadRoutine('snd_seq_system_info'));
  Fsnd_seq_client_info_sizeof := Tsnd_seq_client_info_sizeof(LoadRoutine('snd_seq_client_info_sizeof'));
  Fsnd_seq_client_info_malloc := Tsnd_seq_client_info_malloc(LoadRoutine('snd_seq_client_info_malloc'));
  Fsnd_seq_client_info_free := Tsnd_seq_client_info_free(LoadRoutine('snd_seq_client_info_free'));
  Fsnd_seq_client_info_copy := Tsnd_seq_client_info_copy(LoadRoutine('snd_seq_client_info_copy'));
  Fsnd_seq_client_info_get_client := Tsnd_seq_client_info_get_client(LoadRoutine('snd_seq_client_info_get_client'));
  Fsnd_seq_client_info_get_type := Tsnd_seq_client_info_get_type(LoadRoutine('snd_seq_client_info_get_type'));
  Fsnd_seq_client_info_get_name := Tsnd_seq_client_info_get_name(LoadRoutine('snd_seq_client_info_get_name'));
  Fsnd_seq_client_info_get_broadcast_filter := Tsnd_seq_client_info_get_broadcast_filter(LoadRoutine('snd_seq_client_info_get_broadcast_filter'));
  Fsnd_seq_client_info_get_error_bounce := Tsnd_seq_client_info_get_error_bounce(LoadRoutine('snd_seq_client_info_get_error_bounce'));
  Fsnd_seq_client_info_get_event_filter := Tsnd_seq_client_info_get_event_filter(LoadRoutine('snd_seq_client_info_get_event_filter'));
  Fsnd_seq_client_info_get_num_ports := Tsnd_seq_client_info_get_num_ports(LoadRoutine('snd_seq_client_info_get_num_ports'));
  Fsnd_seq_client_info_get_event_lost := Tsnd_seq_client_info_get_event_lost(LoadRoutine('snd_seq_client_info_get_event_lost'));
  Fsnd_seq_client_info_set_client := Tsnd_seq_client_info_set_client(LoadRoutine('snd_seq_client_info_set_client'));
  Fsnd_seq_client_info_set_name := Tsnd_seq_client_info_set_name(LoadRoutine('snd_seq_client_info_set_name'));
  Fsnd_seq_client_info_set_broadcast_filter := Tsnd_seq_client_info_set_broadcast_filter(LoadRoutine('snd_seq_client_info_set_broadcast_filter'));
  Fsnd_seq_client_info_set_error_bounce := Tsnd_seq_client_info_set_error_bounce(LoadRoutine('snd_seq_client_info_set_error_bounce'));
  Fsnd_seq_client_info_set_event_filter := Tsnd_seq_client_info_set_event_filter(LoadRoutine('snd_seq_client_info_set_event_filter'));
  Fsnd_seq_client_info_event_filter_clear := Tsnd_seq_client_info_event_filter_clear(LoadRoutine('snd_seq_client_info_event_filter_clear'));
  Fsnd_seq_client_info_event_filter_add := Tsnd_seq_client_info_event_filter_add(LoadRoutine('snd_seq_client_info_event_filter_add'));
  Fsnd_seq_client_info_event_filter_del := Tsnd_seq_client_info_event_filter_del(LoadRoutine('snd_seq_client_info_event_filter_del'));
  Fsnd_seq_client_info_event_filter_check := Tsnd_seq_client_info_event_filter_check(LoadRoutine('snd_seq_client_info_event_filter_check'));
  Fsnd_seq_get_client_info := Tsnd_seq_get_client_info(LoadRoutine('snd_seq_get_client_info'));
  Fsnd_seq_get_any_client_info := Tsnd_seq_get_any_client_info(LoadRoutine('snd_seq_get_any_client_info'));
  Fsnd_seq_set_client_info := Tsnd_seq_set_client_info(LoadRoutine('snd_seq_set_client_info'));
  Fsnd_seq_query_next_client := Tsnd_seq_query_next_client(LoadRoutine('snd_seq_query_next_client'));
  Fsnd_seq_client_pool_sizeof := Tsnd_seq_client_pool_sizeof(LoadRoutine('snd_seq_client_pool_sizeof'));
  Fsnd_seq_client_pool_malloc := Tsnd_seq_client_pool_malloc(LoadRoutine('snd_seq_client_pool_malloc'));
  Fsnd_seq_client_pool_free := Tsnd_seq_client_pool_free(LoadRoutine('snd_seq_client_pool_free'));
  Fsnd_seq_client_pool_copy := Tsnd_seq_client_pool_copy(LoadRoutine('snd_seq_client_pool_copy'));
  Fsnd_seq_client_pool_get_client := Tsnd_seq_client_pool_get_client(LoadRoutine('snd_seq_client_pool_get_client'));
  Fsnd_seq_client_pool_get_output_pool := Tsnd_seq_client_pool_get_output_pool(LoadRoutine('snd_seq_client_pool_get_output_pool'));
  Fsnd_seq_client_pool_get_input_pool := Tsnd_seq_client_pool_get_input_pool(LoadRoutine('snd_seq_client_pool_get_input_pool'));
  Fsnd_seq_client_pool_get_output_room := Tsnd_seq_client_pool_get_output_room(LoadRoutine('snd_seq_client_pool_get_output_room'));
  Fsnd_seq_client_pool_get_output_free := Tsnd_seq_client_pool_get_output_free(LoadRoutine('snd_seq_client_pool_get_output_free'));
  Fsnd_seq_client_pool_get_input_free := Tsnd_seq_client_pool_get_input_free(LoadRoutine('snd_seq_client_pool_get_input_free'));
  Fsnd_seq_client_pool_set_output_pool := Tsnd_seq_client_pool_set_output_pool(LoadRoutine('snd_seq_client_pool_set_output_pool'));
  Fsnd_seq_client_pool_set_input_pool := Tsnd_seq_client_pool_set_input_pool(LoadRoutine('snd_seq_client_pool_set_input_pool'));
  Fsnd_seq_client_pool_set_output_room := Tsnd_seq_client_pool_set_output_room(LoadRoutine('snd_seq_client_pool_set_output_room'));
  Fsnd_seq_get_client_pool := Tsnd_seq_get_client_pool(LoadRoutine('snd_seq_get_client_pool'));
  Fsnd_seq_set_client_pool := Tsnd_seq_set_client_pool(LoadRoutine('snd_seq_set_client_pool'));
  Fsnd_seq_port_info_sizeof := Tsnd_seq_port_info_sizeof(LoadRoutine('snd_seq_port_info_sizeof'));
  Fsnd_seq_port_info_malloc := Tsnd_seq_port_info_malloc(LoadRoutine('snd_seq_port_info_malloc'));
  Fsnd_seq_port_info_free := Tsnd_seq_port_info_free(LoadRoutine('snd_seq_port_info_free'));
  Fsnd_seq_port_info_copy := Tsnd_seq_port_info_copy(LoadRoutine('snd_seq_port_info_copy'));
  Fsnd_seq_port_info_get_client := Tsnd_seq_port_info_get_client(LoadRoutine('snd_seq_port_info_get_client'));
  Fsnd_seq_port_info_get_port := Tsnd_seq_port_info_get_port(LoadRoutine('snd_seq_port_info_get_port'));
  Fsnd_seq_port_info_get_addr := Tsnd_seq_port_info_get_addr(LoadRoutine('snd_seq_port_info_get_addr'));
  Fsnd_seq_port_info_get_name := Tsnd_seq_port_info_get_name(LoadRoutine('snd_seq_port_info_get_name'));
  Fsnd_seq_port_info_get_capability := Tsnd_seq_port_info_get_capability(LoadRoutine('snd_seq_port_info_get_capability'));
  Fsnd_seq_port_info_get_type := Tsnd_seq_port_info_get_type(LoadRoutine('snd_seq_port_info_get_type'));
  Fsnd_seq_port_info_get_midi_channels := Tsnd_seq_port_info_get_midi_channels(LoadRoutine('snd_seq_port_info_get_midi_channels'));
  Fsnd_seq_port_info_get_midi_voices := Tsnd_seq_port_info_get_midi_voices(LoadRoutine('snd_seq_port_info_get_midi_voices'));
  Fsnd_seq_port_info_get_synth_voices := Tsnd_seq_port_info_get_synth_voices(LoadRoutine('snd_seq_port_info_get_synth_voices'));
  Fsnd_seq_port_info_get_read_use := Tsnd_seq_port_info_get_read_use(LoadRoutine('snd_seq_port_info_get_read_use'));
  Fsnd_seq_port_info_get_write_use := Tsnd_seq_port_info_get_write_use(LoadRoutine('snd_seq_port_info_get_write_use'));
  Fsnd_seq_port_info_get_port_specified := Tsnd_seq_port_info_get_port_specified(LoadRoutine('snd_seq_port_info_get_port_specified'));
  Fsnd_seq_port_info_get_timestamping := Tsnd_seq_port_info_get_timestamping(LoadRoutine('snd_seq_port_info_get_timestamping'));
  Fsnd_seq_port_info_get_timestamp_real := Tsnd_seq_port_info_get_timestamp_real(LoadRoutine('snd_seq_port_info_get_timestamp_real'));
  Fsnd_seq_port_info_get_timestamp_queue := Tsnd_seq_port_info_get_timestamp_queue(LoadRoutine('snd_seq_port_info_get_timestamp_queue'));
  Fsnd_seq_port_info_set_client := Tsnd_seq_port_info_set_client(LoadRoutine('snd_seq_port_info_set_client'));
  Fsnd_seq_port_info_set_port := Tsnd_seq_port_info_set_port(LoadRoutine('snd_seq_port_info_set_port'));
  Fsnd_seq_port_info_set_addr := Tsnd_seq_port_info_set_addr(LoadRoutine('snd_seq_port_info_set_addr'));
  Fsnd_seq_port_info_set_name := Tsnd_seq_port_info_set_name(LoadRoutine('snd_seq_port_info_set_name'));
  Fsnd_seq_port_info_set_capability := Tsnd_seq_port_info_set_capability(LoadRoutine('snd_seq_port_info_set_capability'));
  Fsnd_seq_port_info_set_type := Tsnd_seq_port_info_set_type(LoadRoutine('snd_seq_port_info_set_type'));
  Fsnd_seq_port_info_set_midi_channels := Tsnd_seq_port_info_set_midi_channels(LoadRoutine('snd_seq_port_info_set_midi_channels'));
  Fsnd_seq_port_info_set_midi_voices := Tsnd_seq_port_info_set_midi_voices(LoadRoutine('snd_seq_port_info_set_midi_voices'));
  Fsnd_seq_port_info_set_synth_voices := Tsnd_seq_port_info_set_synth_voices(LoadRoutine('snd_seq_port_info_set_synth_voices'));
  Fsnd_seq_port_info_set_port_specified := Tsnd_seq_port_info_set_port_specified(LoadRoutine('snd_seq_port_info_set_port_specified'));
  Fsnd_seq_port_info_set_timestamping := Tsnd_seq_port_info_set_timestamping(LoadRoutine('snd_seq_port_info_set_timestamping'));
  Fsnd_seq_port_info_set_timestamp_real := Tsnd_seq_port_info_set_timestamp_real(LoadRoutine('snd_seq_port_info_set_timestamp_real'));
  Fsnd_seq_port_info_set_timestamp_queue := Tsnd_seq_port_info_set_timestamp_queue(LoadRoutine('snd_seq_port_info_set_timestamp_queue'));
  Fsnd_seq_create_port := Tsnd_seq_create_port(LoadRoutine('snd_seq_create_port'));
  Fsnd_seq_delete_port := Tsnd_seq_delete_port(LoadRoutine('snd_seq_delete_port'));
  Fsnd_seq_get_port_info := Tsnd_seq_get_port_info(LoadRoutine('snd_seq_get_port_info'));
  Fsnd_seq_get_any_port_info := Tsnd_seq_get_any_port_info(LoadRoutine('snd_seq_get_any_port_info'));
  Fsnd_seq_set_port_info := Tsnd_seq_set_port_info(LoadRoutine('snd_seq_set_port_info'));
  Fsnd_seq_query_next_port := Tsnd_seq_query_next_port(LoadRoutine('snd_seq_query_next_port'));
  Fsnd_seq_port_subscribe_sizeof := Tsnd_seq_port_subscribe_sizeof(LoadRoutine('snd_seq_port_subscribe_sizeof'));
  Fsnd_seq_port_subscribe_malloc := Tsnd_seq_port_subscribe_malloc(LoadRoutine('snd_seq_port_subscribe_malloc'));
  Fsnd_seq_port_subscribe_free := Tsnd_seq_port_subscribe_free(LoadRoutine('snd_seq_port_subscribe_free'));
  Fsnd_seq_port_subscribe_copy := Tsnd_seq_port_subscribe_copy(LoadRoutine('snd_seq_port_subscribe_copy'));
  Fsnd_seq_port_subscribe_get_sender := Tsnd_seq_port_subscribe_get_sender(LoadRoutine('snd_seq_port_subscribe_get_sender'));
  Fsnd_seq_port_subscribe_get_dest := Tsnd_seq_port_subscribe_get_dest(LoadRoutine('snd_seq_port_subscribe_get_dest'));
  Fsnd_seq_port_subscribe_get_queue := Tsnd_seq_port_subscribe_get_queue(LoadRoutine('snd_seq_port_subscribe_get_queue'));
  Fsnd_seq_port_subscribe_get_exclusive := Tsnd_seq_port_subscribe_get_exclusive(LoadRoutine('snd_seq_port_subscribe_get_exclusive'));
  Fsnd_seq_port_subscribe_get_time_update := Tsnd_seq_port_subscribe_get_time_update(LoadRoutine('snd_seq_port_subscribe_get_time_update'));
  Fsnd_seq_port_subscribe_get_time_real := Tsnd_seq_port_subscribe_get_time_real(LoadRoutine('snd_seq_port_subscribe_get_time_real'));
  Fsnd_seq_port_subscribe_set_sender := Tsnd_seq_port_subscribe_set_sender(LoadRoutine('snd_seq_port_subscribe_set_sender'));
  Fsnd_seq_port_subscribe_set_dest := Tsnd_seq_port_subscribe_set_dest(LoadRoutine('snd_seq_port_subscribe_set_dest'));
  Fsnd_seq_port_subscribe_set_queue := Tsnd_seq_port_subscribe_set_queue(LoadRoutine('snd_seq_port_subscribe_set_queue'));
  Fsnd_seq_port_subscribe_set_exclusive := Tsnd_seq_port_subscribe_set_exclusive(LoadRoutine('snd_seq_port_subscribe_set_exclusive'));
  Fsnd_seq_port_subscribe_set_time_update := Tsnd_seq_port_subscribe_set_time_update(LoadRoutine('snd_seq_port_subscribe_set_time_update'));
  Fsnd_seq_port_subscribe_set_time_real := Tsnd_seq_port_subscribe_set_time_real(LoadRoutine('snd_seq_port_subscribe_set_time_real'));
  Fsnd_seq_get_port_subscription := Tsnd_seq_get_port_subscription(LoadRoutine('snd_seq_get_port_subscription'));
  Fsnd_seq_subscribe_port := Tsnd_seq_subscribe_port(LoadRoutine('snd_seq_subscribe_port'));
  Fsnd_seq_unsubscribe_port := Tsnd_seq_unsubscribe_port(LoadRoutine('snd_seq_unsubscribe_port'));
  Fsnd_seq_query_subscribe_sizeof := Tsnd_seq_query_subscribe_sizeof(LoadRoutine('snd_seq_query_subscribe_sizeof'));
  Fsnd_seq_query_subscribe_malloc := Tsnd_seq_query_subscribe_malloc(LoadRoutine('snd_seq_query_subscribe_malloc'));
  Fsnd_seq_query_subscribe_free := Tsnd_seq_query_subscribe_free(LoadRoutine('snd_seq_query_subscribe_free'));
  Fsnd_seq_query_subscribe_copy := Tsnd_seq_query_subscribe_copy(LoadRoutine('snd_seq_query_subscribe_copy'));
  Fsnd_seq_query_subscribe_get_client := Tsnd_seq_query_subscribe_get_client(LoadRoutine('snd_seq_query_subscribe_get_client'));
  Fsnd_seq_query_subscribe_get_port := Tsnd_seq_query_subscribe_get_port(LoadRoutine('snd_seq_query_subscribe_get_port'));
  Fsnd_seq_query_subscribe_get_root := Tsnd_seq_query_subscribe_get_root(LoadRoutine('snd_seq_query_subscribe_get_root'));
  Fsnd_seq_query_subscribe_get_type := Tsnd_seq_query_subscribe_get_type(LoadRoutine('snd_seq_query_subscribe_get_type'));
  Fsnd_seq_query_subscribe_get_index := Tsnd_seq_query_subscribe_get_index(LoadRoutine('snd_seq_query_subscribe_get_index'));
  Fsnd_seq_query_subscribe_get_num_subs := Tsnd_seq_query_subscribe_get_num_subs(LoadRoutine('snd_seq_query_subscribe_get_num_subs'));
  Fsnd_seq_query_subscribe_get_addr := Tsnd_seq_query_subscribe_get_addr(LoadRoutine('snd_seq_query_subscribe_get_addr'));
  Fsnd_seq_query_subscribe_get_queue := Tsnd_seq_query_subscribe_get_queue(LoadRoutine('snd_seq_query_subscribe_get_queue'));
  Fsnd_seq_query_subscribe_get_exclusive := Tsnd_seq_query_subscribe_get_exclusive(LoadRoutine('snd_seq_query_subscribe_get_exclusive'));
  Fsnd_seq_query_subscribe_get_time_update := Tsnd_seq_query_subscribe_get_time_update(LoadRoutine('snd_seq_query_subscribe_get_time_update'));
  Fsnd_seq_query_subscribe_get_time_real := Tsnd_seq_query_subscribe_get_time_real(LoadRoutine('snd_seq_query_subscribe_get_time_real'));
  Fsnd_seq_query_subscribe_set_client := Tsnd_seq_query_subscribe_set_client(LoadRoutine('snd_seq_query_subscribe_set_client'));
  Fsnd_seq_query_subscribe_set_port := Tsnd_seq_query_subscribe_set_port(LoadRoutine('snd_seq_query_subscribe_set_port'));
  Fsnd_seq_query_subscribe_set_root := Tsnd_seq_query_subscribe_set_root(LoadRoutine('snd_seq_query_subscribe_set_root'));
  Fsnd_seq_query_subscribe_set_type := Tsnd_seq_query_subscribe_set_type(LoadRoutine('snd_seq_query_subscribe_set_type'));
  Fsnd_seq_query_subscribe_set_index := Tsnd_seq_query_subscribe_set_index(LoadRoutine('snd_seq_query_subscribe_set_index'));
  Fsnd_seq_query_port_subscribers := Tsnd_seq_query_port_subscribers(LoadRoutine('snd_seq_query_port_subscribers'));
  Fsnd_seq_queue_info_sizeof := Tsnd_seq_queue_info_sizeof(LoadRoutine('snd_seq_queue_info_sizeof'));
  Fsnd_seq_queue_info_malloc := Tsnd_seq_queue_info_malloc(LoadRoutine('snd_seq_queue_info_malloc'));
  Fsnd_seq_queue_info_free := Tsnd_seq_queue_info_free(LoadRoutine('snd_seq_queue_info_free'));
  Fsnd_seq_queue_info_copy := Tsnd_seq_queue_info_copy(LoadRoutine('snd_seq_queue_info_copy'));
  Fsnd_seq_queue_info_get_queue := Tsnd_seq_queue_info_get_queue(LoadRoutine('snd_seq_queue_info_get_queue'));
  Fsnd_seq_queue_info_get_name := Tsnd_seq_queue_info_get_name(LoadRoutine('snd_seq_queue_info_get_name'));
  Fsnd_seq_queue_info_get_owner := Tsnd_seq_queue_info_get_owner(LoadRoutine('snd_seq_queue_info_get_owner'));
  Fsnd_seq_queue_info_get_locked := Tsnd_seq_queue_info_get_locked(LoadRoutine('snd_seq_queue_info_get_locked'));
  Fsnd_seq_queue_info_get_flags := Tsnd_seq_queue_info_get_flags(LoadRoutine('snd_seq_queue_info_get_flags'));
  Fsnd_seq_queue_info_set_name := Tsnd_seq_queue_info_set_name(LoadRoutine('snd_seq_queue_info_set_name'));
  Fsnd_seq_queue_info_set_owner := Tsnd_seq_queue_info_set_owner(LoadRoutine('snd_seq_queue_info_set_owner'));
  Fsnd_seq_queue_info_set_locked := Tsnd_seq_queue_info_set_locked(LoadRoutine('snd_seq_queue_info_set_locked'));
  Fsnd_seq_queue_info_set_flags := Tsnd_seq_queue_info_set_flags(LoadRoutine('snd_seq_queue_info_set_flags'));
  Fsnd_seq_create_queue := Tsnd_seq_create_queue(LoadRoutine('snd_seq_create_queue'));
  Fsnd_seq_alloc_named_queue := Tsnd_seq_alloc_named_queue(LoadRoutine('snd_seq_alloc_named_queue'));
  Fsnd_seq_alloc_queue := Tsnd_seq_alloc_queue(LoadRoutine('snd_seq_alloc_queue'));
  Fsnd_seq_free_queue := Tsnd_seq_free_queue(LoadRoutine('snd_seq_free_queue'));
  Fsnd_seq_get_queue_info := Tsnd_seq_get_queue_info(LoadRoutine('snd_seq_get_queue_info'));
  Fsnd_seq_set_queue_info := Tsnd_seq_set_queue_info(LoadRoutine('snd_seq_set_queue_info'));
  Fsnd_seq_query_named_queue := Tsnd_seq_query_named_queue(LoadRoutine('snd_seq_query_named_queue'));
  Fsnd_seq_get_queue_usage := Tsnd_seq_get_queue_usage(LoadRoutine('snd_seq_get_queue_usage'));
  Fsnd_seq_set_queue_usage := Tsnd_seq_set_queue_usage(LoadRoutine('snd_seq_set_queue_usage'));
  Fsnd_seq_queue_status_sizeof := Tsnd_seq_queue_status_sizeof(LoadRoutine('snd_seq_queue_status_sizeof'));
  Fsnd_seq_queue_status_malloc := Tsnd_seq_queue_status_malloc(LoadRoutine('snd_seq_queue_status_malloc'));
  Fsnd_seq_queue_status_free := Tsnd_seq_queue_status_free(LoadRoutine('snd_seq_queue_status_free'));
  Fsnd_seq_queue_status_copy := Tsnd_seq_queue_status_copy(LoadRoutine('snd_seq_queue_status_copy'));
  Fsnd_seq_queue_status_get_queue := Tsnd_seq_queue_status_get_queue(LoadRoutine('snd_seq_queue_status_get_queue'));
  Fsnd_seq_queue_status_get_events := Tsnd_seq_queue_status_get_events(LoadRoutine('snd_seq_queue_status_get_events'));
  Fsnd_seq_queue_status_get_tick_time := Tsnd_seq_queue_status_get_tick_time(LoadRoutine('snd_seq_queue_status_get_tick_time'));
  Fsnd_seq_queue_status_get_real_time := Tsnd_seq_queue_status_get_real_time(LoadRoutine('snd_seq_queue_status_get_real_time'));
  Fsnd_seq_queue_status_get_status := Tsnd_seq_queue_status_get_status(LoadRoutine('snd_seq_queue_status_get_status'));
  Fsnd_seq_get_queue_status := Tsnd_seq_get_queue_status(LoadRoutine('snd_seq_get_queue_status'));
  Fsnd_seq_queue_tempo_sizeof := Tsnd_seq_queue_tempo_sizeof(LoadRoutine('snd_seq_queue_tempo_sizeof'));
  Fsnd_seq_queue_tempo_malloc := Tsnd_seq_queue_tempo_malloc(LoadRoutine('snd_seq_queue_tempo_malloc'));
  Fsnd_seq_queue_tempo_free := Tsnd_seq_queue_tempo_free(LoadRoutine('snd_seq_queue_tempo_free'));
  Fsnd_seq_queue_tempo_copy := Tsnd_seq_queue_tempo_copy(LoadRoutine('snd_seq_queue_tempo_copy'));
  Fsnd_seq_queue_tempo_get_queue := Tsnd_seq_queue_tempo_get_queue(LoadRoutine('snd_seq_queue_tempo_get_queue'));
  Fsnd_seq_queue_tempo_get_tempo := Tsnd_seq_queue_tempo_get_tempo(LoadRoutine('snd_seq_queue_tempo_get_tempo'));
  Fsnd_seq_queue_tempo_get_ppq := Tsnd_seq_queue_tempo_get_ppq(LoadRoutine('snd_seq_queue_tempo_get_ppq'));
  Fsnd_seq_queue_tempo_get_skew := Tsnd_seq_queue_tempo_get_skew(LoadRoutine('snd_seq_queue_tempo_get_skew'));
  Fsnd_seq_queue_tempo_get_skew_base := Tsnd_seq_queue_tempo_get_skew_base(LoadRoutine('snd_seq_queue_tempo_get_skew_base'));
  Fsnd_seq_queue_tempo_set_tempo := Tsnd_seq_queue_tempo_set_tempo(LoadRoutine('snd_seq_queue_tempo_set_tempo'));
  Fsnd_seq_queue_tempo_set_ppq := Tsnd_seq_queue_tempo_set_ppq(LoadRoutine('snd_seq_queue_tempo_set_ppq'));
  Fsnd_seq_queue_tempo_set_skew := Tsnd_seq_queue_tempo_set_skew(LoadRoutine('snd_seq_queue_tempo_set_skew'));
  Fsnd_seq_queue_tempo_set_skew_base := Tsnd_seq_queue_tempo_set_skew_base(LoadRoutine('snd_seq_queue_tempo_set_skew_base'));
  Fsnd_seq_get_queue_tempo := Tsnd_seq_get_queue_tempo(LoadRoutine('snd_seq_get_queue_tempo'));
  Fsnd_seq_set_queue_tempo := Tsnd_seq_set_queue_tempo(LoadRoutine('snd_seq_set_queue_tempo'));
  Fsnd_seq_queue_timer_sizeof := Tsnd_seq_queue_timer_sizeof(LoadRoutine('snd_seq_queue_timer_sizeof'));
  Fsnd_seq_queue_timer_malloc := Tsnd_seq_queue_timer_malloc(LoadRoutine('snd_seq_queue_timer_malloc'));
  Fsnd_seq_queue_timer_free := Tsnd_seq_queue_timer_free(LoadRoutine('snd_seq_queue_timer_free'));
  Fsnd_seq_queue_timer_copy := Tsnd_seq_queue_timer_copy(LoadRoutine('snd_seq_queue_timer_copy'));
  Fsnd_seq_queue_timer_get_queue := Tsnd_seq_queue_timer_get_queue(LoadRoutine('snd_seq_queue_timer_get_queue'));
  Fsnd_seq_queue_timer_get_type := Tsnd_seq_queue_timer_get_type(LoadRoutine('snd_seq_queue_timer_get_type'));
  Fsnd_seq_queue_timer_get_id := Tsnd_seq_queue_timer_get_id(LoadRoutine('snd_seq_queue_timer_get_id'));
  Fsnd_seq_queue_timer_get_resolution := Tsnd_seq_queue_timer_get_resolution(LoadRoutine('snd_seq_queue_timer_get_resolution'));
  Fsnd_seq_queue_timer_set_type := Tsnd_seq_queue_timer_set_type(LoadRoutine('snd_seq_queue_timer_set_type'));
  Fsnd_seq_queue_timer_set_id := Tsnd_seq_queue_timer_set_id(LoadRoutine('snd_seq_queue_timer_set_id'));
  Fsnd_seq_queue_timer_set_resolution := Tsnd_seq_queue_timer_set_resolution(LoadRoutine('snd_seq_queue_timer_set_resolution'));
  Fsnd_seq_get_queue_timer := Tsnd_seq_get_queue_timer(LoadRoutine('snd_seq_get_queue_timer'));
  Fsnd_seq_set_queue_timer := Tsnd_seq_set_queue_timer(LoadRoutine('snd_seq_set_queue_timer'));
  Fsnd_seq_free_event := Tsnd_seq_free_event(LoadRoutine('snd_seq_free_event'));
  Fsnd_seq_event_length := Tsnd_seq_event_length(LoadRoutine('snd_seq_event_length'));
  Fsnd_seq_event_output := Tsnd_seq_event_output(LoadRoutine('snd_seq_event_output'));
  Fsnd_seq_event_output_buffer := Tsnd_seq_event_output_buffer(LoadRoutine('snd_seq_event_output_buffer'));
  Fsnd_seq_event_output_direct := Tsnd_seq_event_output_direct(LoadRoutine('snd_seq_event_output_direct'));
  Fsnd_seq_event_input := Tsnd_seq_event_input(LoadRoutine('snd_seq_event_input'));
  Fsnd_seq_event_input_pending := Tsnd_seq_event_input_pending(LoadRoutine('snd_seq_event_input_pending'));
  Fsnd_seq_drain_output := Tsnd_seq_drain_output(LoadRoutine('snd_seq_drain_output'));
  Fsnd_seq_event_output_pending := Tsnd_seq_event_output_pending(LoadRoutine('snd_seq_event_output_pending'));
  Fsnd_seq_extract_output := Tsnd_seq_extract_output(LoadRoutine('snd_seq_extract_output'));
  Fsnd_seq_drop_output := Tsnd_seq_drop_output(LoadRoutine('snd_seq_drop_output'));
  Fsnd_seq_drop_output_buffer := Tsnd_seq_drop_output_buffer(LoadRoutine('snd_seq_drop_output_buffer'));
  Fsnd_seq_drop_input := Tsnd_seq_drop_input(LoadRoutine('snd_seq_drop_input'));
  Fsnd_seq_drop_input_buffer := Tsnd_seq_drop_input_buffer(LoadRoutine('snd_seq_drop_input_buffer'));
  Fsnd_seq_remove_events_sizeof := Tsnd_seq_remove_events_sizeof(LoadRoutine('snd_seq_remove_events_sizeof'));
  Fsnd_seq_remove_events_malloc := Tsnd_seq_remove_events_malloc(LoadRoutine('snd_seq_remove_events_malloc'));
  Fsnd_seq_remove_events_free := Tsnd_seq_remove_events_free(LoadRoutine('snd_seq_remove_events_free'));
  Fsnd_seq_remove_events_copy := Tsnd_seq_remove_events_copy(LoadRoutine('snd_seq_remove_events_copy'));
  Fsnd_seq_remove_events_get_condition := Tsnd_seq_remove_events_get_condition(LoadRoutine('snd_seq_remove_events_get_condition'));
  Fsnd_seq_remove_events_get_queue := Tsnd_seq_remove_events_get_queue(LoadRoutine('snd_seq_remove_events_get_queue'));
  Fsnd_seq_remove_events_get_time := Tsnd_seq_remove_events_get_time(LoadRoutine('snd_seq_remove_events_get_time'));
  Fsnd_seq_remove_events_get_dest := Tsnd_seq_remove_events_get_dest(LoadRoutine('snd_seq_remove_events_get_dest'));
  Fsnd_seq_remove_events_get_channel := Tsnd_seq_remove_events_get_channel(LoadRoutine('snd_seq_remove_events_get_channel'));
  Fsnd_seq_remove_events_get_event_type := Tsnd_seq_remove_events_get_event_type(LoadRoutine('snd_seq_remove_events_get_event_type'));
  Fsnd_seq_remove_events_get_tag := Tsnd_seq_remove_events_get_tag(LoadRoutine('snd_seq_remove_events_get_tag'));
  Fsnd_seq_remove_events_set_condition := Tsnd_seq_remove_events_set_condition(LoadRoutine('snd_seq_remove_events_set_condition'));
  Fsnd_seq_remove_events_set_queue := Tsnd_seq_remove_events_set_queue(LoadRoutine('snd_seq_remove_events_set_queue'));
  Fsnd_seq_remove_events_set_time := Tsnd_seq_remove_events_set_time(LoadRoutine('snd_seq_remove_events_set_time'));
  Fsnd_seq_remove_events_set_dest := Tsnd_seq_remove_events_set_dest(LoadRoutine('snd_seq_remove_events_set_dest'));
  Fsnd_seq_remove_events_set_channel := Tsnd_seq_remove_events_set_channel(LoadRoutine('snd_seq_remove_events_set_channel'));
  Fsnd_seq_remove_events_set_event_type := Tsnd_seq_remove_events_set_event_type(LoadRoutine('snd_seq_remove_events_set_event_type'));
  Fsnd_seq_remove_events_set_tag := Tsnd_seq_remove_events_set_tag(LoadRoutine('snd_seq_remove_events_set_tag'));
  Fsnd_seq_remove_events := Tsnd_seq_remove_events(LoadRoutine('snd_seq_remove_events'));
  Fsnd_seq_set_bit := Tsnd_seq_set_bit(LoadRoutine('snd_seq_set_bit'));
  Fsnd_seq_unset_bit := Tsnd_seq_unset_bit(LoadRoutine('snd_seq_unset_bit'));
  Fsnd_seq_change_bit := Tsnd_seq_change_bit(LoadRoutine('snd_seq_change_bit'));
  Fsnd_seq_get_bit := Tsnd_seq_get_bit(LoadRoutine('snd_seq_get_bit'));
  Fsnd_seq_create_simple_port := Tsnd_seq_create_simple_port(LoadRoutine('snd_seq_create_simple_port'));
  Fsnd_seq_delete_simple_port := Tsnd_seq_delete_simple_port(LoadRoutine('snd_seq_delete_simple_port'));
  Fsnd_seq_connect_from := Tsnd_seq_connect_from(LoadRoutine('snd_seq_connect_from'));
  Fsnd_seq_connect_to := Tsnd_seq_connect_to(LoadRoutine('snd_seq_connect_to'));
  Fsnd_seq_disconnect_from := Tsnd_seq_disconnect_from(LoadRoutine('snd_seq_disconnect_from'));
  Fsnd_seq_disconnect_to := Tsnd_seq_disconnect_to(LoadRoutine('snd_seq_disconnect_to'));
  Fsnd_seq_set_client_name := Tsnd_seq_set_client_name(LoadRoutine('snd_seq_set_client_name'));
  Fsnd_seq_set_client_event_filter := Tsnd_seq_set_client_event_filter(LoadRoutine('snd_seq_set_client_event_filter'));
  Fsnd_seq_set_client_pool_output := Tsnd_seq_set_client_pool_output(LoadRoutine('snd_seq_set_client_pool_output'));
  Fsnd_seq_set_client_pool_output_room := Tsnd_seq_set_client_pool_output_room(LoadRoutine('snd_seq_set_client_pool_output_room'));
  Fsnd_seq_set_client_pool_input := Tsnd_seq_set_client_pool_input(LoadRoutine('snd_seq_set_client_pool_input'));
  Fsnd_seq_sync_output_queue := Tsnd_seq_sync_output_queue(LoadRoutine('snd_seq_sync_output_queue'));
  Fsnd_seq_parse_address := Tsnd_seq_parse_address(LoadRoutine('snd_seq_parse_address'));
  Fsnd_seq_reset_pool_output := Tsnd_seq_reset_pool_output(LoadRoutine('snd_seq_reset_pool_output'));
  Fsnd_seq_reset_pool_input := Tsnd_seq_reset_pool_input(LoadRoutine('snd_seq_reset_pool_input'));
  Fsnd_seq_control_queue := Tsnd_seq_control_queue(LoadRoutine('snd_seq_control_queue'));
  Fsnd_strerror := Tsnd_strerror(LoadRoutine('snd_strerror'));
  LoadVarargsRoutine;
{$else                   }
  Fsnd_seq_open := nil;
  Fsnd_seq_open_lconf := nil;
  Fsnd_seq_name := nil;
  Fsnd_seq_type := nil;
  Fsnd_seq_close := nil;
  Fsnd_seq_poll_descriptors_count := nil;
  Fsnd_seq_poll_descriptors := nil;
  Fsnd_seq_poll_descriptors_revents := nil;
  Fsnd_seq_nonblock := nil;
  Fsnd_seq_client_id := nil;
  Fsnd_seq_get_output_buffer_size := nil;
  Fsnd_seq_get_input_buffer_size := nil;
  Fsnd_seq_set_output_buffer_size := nil;
  Fsnd_seq_set_input_buffer_size := nil;
  Fsnd_seq_system_info_sizeof := nil;
  Fsnd_seq_system_info_malloc := nil;
  Fsnd_seq_system_info_free := nil;
  Fsnd_seq_system_info_copy := nil;
  Fsnd_seq_system_info_get_queues := nil;
  Fsnd_seq_system_info_get_clients := nil;
  Fsnd_seq_system_info_get_ports := nil;
  Fsnd_seq_system_info_get_channels := nil;
  Fsnd_seq_system_info_get_cur_clients := nil;
  Fsnd_seq_system_info_get_cur_queues := nil;
  Fsnd_seq_system_info := nil;
  Fsnd_seq_client_info_sizeof := nil;
  Fsnd_seq_client_info_malloc := nil;
  Fsnd_seq_client_info_free := nil;
  Fsnd_seq_client_info_copy := nil;
  Fsnd_seq_client_info_get_client := nil;
  Fsnd_seq_client_info_get_type := nil;
  Fsnd_seq_client_info_get_name := nil;
  Fsnd_seq_client_info_get_broadcast_filter := nil;
  Fsnd_seq_client_info_get_error_bounce := nil;
  Fsnd_seq_client_info_get_event_filter := nil;
  Fsnd_seq_client_info_get_num_ports := nil;
  Fsnd_seq_client_info_get_event_lost := nil;
  Fsnd_seq_client_info_set_client := nil;
  Fsnd_seq_client_info_set_name := nil;
  Fsnd_seq_client_info_set_broadcast_filter := nil;
  Fsnd_seq_client_info_set_error_bounce := nil;
  Fsnd_seq_client_info_set_event_filter := nil;
  Fsnd_seq_client_info_event_filter_clear := nil;
  Fsnd_seq_client_info_event_filter_add := nil;
  Fsnd_seq_client_info_event_filter_del := nil;
  Fsnd_seq_client_info_event_filter_check := nil;
  Fsnd_seq_get_client_info := nil;
  Fsnd_seq_get_any_client_info := nil;
  Fsnd_seq_set_client_info := nil;
  Fsnd_seq_query_next_client := nil;
  Fsnd_seq_client_pool_sizeof := nil;
  Fsnd_seq_client_pool_malloc := nil;
  Fsnd_seq_client_pool_free := nil;
  Fsnd_seq_client_pool_copy := nil;
  Fsnd_seq_client_pool_get_client := nil;
  Fsnd_seq_client_pool_get_output_pool := nil;
  Fsnd_seq_client_pool_get_input_pool := nil;
  Fsnd_seq_client_pool_get_output_room := nil;
  Fsnd_seq_client_pool_get_output_free := nil;
  Fsnd_seq_client_pool_get_input_free := nil;
  Fsnd_seq_client_pool_set_output_pool := nil;
  Fsnd_seq_client_pool_set_input_pool := nil;
  Fsnd_seq_client_pool_set_output_room := nil;
  Fsnd_seq_get_client_pool := nil;
  Fsnd_seq_set_client_pool := nil;
  Fsnd_seq_port_info_sizeof := nil;
  Fsnd_seq_port_info_malloc := nil;
  Fsnd_seq_port_info_free := nil;
  Fsnd_seq_port_info_copy := nil;
  Fsnd_seq_port_info_get_client := nil;
  Fsnd_seq_port_info_get_port := nil;
  Fsnd_seq_port_info_get_addr := nil;
  Fsnd_seq_port_info_get_name := nil;
  Fsnd_seq_port_info_get_capability := nil;
  Fsnd_seq_port_info_get_type := nil;
  Fsnd_seq_port_info_get_midi_channels := nil;
  Fsnd_seq_port_info_get_midi_voices := nil;
  Fsnd_seq_port_info_get_synth_voices := nil;
  Fsnd_seq_port_info_get_read_use := nil;
  Fsnd_seq_port_info_get_write_use := nil;
  Fsnd_seq_port_info_get_port_specified := nil;
  Fsnd_seq_port_info_get_timestamping := nil;
  Fsnd_seq_port_info_get_timestamp_real := nil;
  Fsnd_seq_port_info_get_timestamp_queue := nil;
  Fsnd_seq_port_info_set_client := nil;
  Fsnd_seq_port_info_set_port := nil;
  Fsnd_seq_port_info_set_addr := nil;
  Fsnd_seq_port_info_set_name := nil;
  Fsnd_seq_port_info_set_capability := nil;
  Fsnd_seq_port_info_set_type := nil;
  Fsnd_seq_port_info_set_midi_channels := nil;
  Fsnd_seq_port_info_set_midi_voices := nil;
  Fsnd_seq_port_info_set_synth_voices := nil;
  Fsnd_seq_port_info_set_port_specified := nil;
  Fsnd_seq_port_info_set_timestamping := nil;
  Fsnd_seq_port_info_set_timestamp_real := nil;
  Fsnd_seq_port_info_set_timestamp_queue := nil;
  Fsnd_seq_create_port := nil;
  Fsnd_seq_delete_port := nil;
  Fsnd_seq_get_port_info := nil;
  Fsnd_seq_get_any_port_info := nil;
  Fsnd_seq_set_port_info := nil;
  Fsnd_seq_query_next_port := nil;
  Fsnd_seq_port_subscribe_sizeof := nil;
  Fsnd_seq_port_subscribe_malloc := nil;
  Fsnd_seq_port_subscribe_free := nil;
  Fsnd_seq_port_subscribe_copy := nil;
  Fsnd_seq_port_subscribe_get_sender := nil;
  Fsnd_seq_port_subscribe_get_dest := nil;
  Fsnd_seq_port_subscribe_get_queue := nil;
  Fsnd_seq_port_subscribe_get_exclusive := nil;
  Fsnd_seq_port_subscribe_get_time_update := nil;
  Fsnd_seq_port_subscribe_get_time_real := nil;
  Fsnd_seq_port_subscribe_set_sender := nil;
  Fsnd_seq_port_subscribe_set_dest := nil;
  Fsnd_seq_port_subscribe_set_queue := nil;
  Fsnd_seq_port_subscribe_set_exclusive := nil;
  Fsnd_seq_port_subscribe_set_time_update := nil;
  Fsnd_seq_port_subscribe_set_time_real := nil;
  Fsnd_seq_get_port_subscription := nil;
  Fsnd_seq_subscribe_port := nil;
  Fsnd_seq_unsubscribe_port := nil;
  Fsnd_seq_query_subscribe_sizeof := nil;
  Fsnd_seq_query_subscribe_malloc := nil;
  Fsnd_seq_query_subscribe_free := nil;
  Fsnd_seq_query_subscribe_copy := nil;
  Fsnd_seq_query_subscribe_get_client := nil;
  Fsnd_seq_query_subscribe_get_port := nil;
  Fsnd_seq_query_subscribe_get_root := nil;
  Fsnd_seq_query_subscribe_get_type := nil;
  Fsnd_seq_query_subscribe_get_index := nil;
  Fsnd_seq_query_subscribe_get_num_subs := nil;
  Fsnd_seq_query_subscribe_get_addr := nil;
  Fsnd_seq_query_subscribe_get_queue := nil;
  Fsnd_seq_query_subscribe_get_exclusive := nil;
  Fsnd_seq_query_subscribe_get_time_update := nil;
  Fsnd_seq_query_subscribe_get_time_real := nil;
  Fsnd_seq_query_subscribe_set_client := nil;
  Fsnd_seq_query_subscribe_set_port := nil;
  Fsnd_seq_query_subscribe_set_root := nil;
  Fsnd_seq_query_subscribe_set_type := nil;
  Fsnd_seq_query_subscribe_set_index := nil;
  Fsnd_seq_query_port_subscribers := nil;
  Fsnd_seq_queue_info_sizeof := nil;
  Fsnd_seq_queue_info_malloc := nil;
  Fsnd_seq_queue_info_free := nil;
  Fsnd_seq_queue_info_copy := nil;
  Fsnd_seq_queue_info_get_queue := nil;
  Fsnd_seq_queue_info_get_name := nil;
  Fsnd_seq_queue_info_get_owner := nil;
  Fsnd_seq_queue_info_get_locked := nil;
  Fsnd_seq_queue_info_get_flags := nil;
  Fsnd_seq_queue_info_set_name := nil;
  Fsnd_seq_queue_info_set_owner := nil;
  Fsnd_seq_queue_info_set_locked := nil;
  Fsnd_seq_queue_info_set_flags := nil;
  Fsnd_seq_create_queue := nil;
  Fsnd_seq_alloc_named_queue := nil;
  Fsnd_seq_alloc_queue := nil;
  Fsnd_seq_free_queue := nil;
  Fsnd_seq_get_queue_info := nil;
  Fsnd_seq_set_queue_info := nil;
  Fsnd_seq_query_named_queue := nil;
  Fsnd_seq_get_queue_usage := nil;
  Fsnd_seq_set_queue_usage := nil;
  Fsnd_seq_queue_status_sizeof := nil;
  Fsnd_seq_queue_status_malloc := nil;
  Fsnd_seq_queue_status_free := nil;
  Fsnd_seq_queue_status_copy := nil;
  Fsnd_seq_queue_status_get_queue := nil;
  Fsnd_seq_queue_status_get_events := nil;
  Fsnd_seq_queue_status_get_tick_time := nil;
  Fsnd_seq_queue_status_get_real_time := nil;
  Fsnd_seq_queue_status_get_status := nil;
  Fsnd_seq_get_queue_status := nil;
  Fsnd_seq_queue_tempo_sizeof := nil;
  Fsnd_seq_queue_tempo_malloc := nil;
  Fsnd_seq_queue_tempo_free := nil;
  Fsnd_seq_queue_tempo_copy := nil;
  Fsnd_seq_queue_tempo_get_queue := nil;
  Fsnd_seq_queue_tempo_get_tempo := nil;
  Fsnd_seq_queue_tempo_get_ppq := nil;
  Fsnd_seq_queue_tempo_get_skew := nil;
  Fsnd_seq_queue_tempo_get_skew_base := nil;
  Fsnd_seq_queue_tempo_set_tempo := nil;
  Fsnd_seq_queue_tempo_set_ppq := nil;
  Fsnd_seq_queue_tempo_set_skew := nil;
  Fsnd_seq_queue_tempo_set_skew_base := nil;
  Fsnd_seq_get_queue_tempo := nil;
  Fsnd_seq_set_queue_tempo := nil;
  Fsnd_seq_queue_timer_sizeof := nil;
  Fsnd_seq_queue_timer_malloc := nil;
  Fsnd_seq_queue_timer_free := nil;
  Fsnd_seq_queue_timer_copy := nil;
  Fsnd_seq_queue_timer_get_queue := nil;
  Fsnd_seq_queue_timer_get_type := nil;
  Fsnd_seq_queue_timer_get_id := nil;
  Fsnd_seq_queue_timer_get_resolution := nil;
  Fsnd_seq_queue_timer_set_type := nil;
  Fsnd_seq_queue_timer_set_id := nil;
  Fsnd_seq_queue_timer_set_resolution := nil;
  Fsnd_seq_get_queue_timer := nil;
  Fsnd_seq_set_queue_timer := nil;
  Fsnd_seq_free_event := nil;
  Fsnd_seq_event_length := nil;
  Fsnd_seq_event_output := nil;
  Fsnd_seq_event_output_buffer := nil;
  Fsnd_seq_event_output_direct := nil;
  Fsnd_seq_event_input := nil;
  Fsnd_seq_event_input_pending := nil;
  Fsnd_seq_drain_output := nil;
  Fsnd_seq_event_output_pending := nil;
  Fsnd_seq_extract_output := nil;
  Fsnd_seq_drop_output := nil;
  Fsnd_seq_drop_output_buffer := nil;
  Fsnd_seq_drop_input := nil;
  Fsnd_seq_drop_input_buffer := nil;
  Fsnd_seq_remove_events_sizeof := nil;
  Fsnd_seq_remove_events_malloc := nil;
  Fsnd_seq_remove_events_free := nil;
  Fsnd_seq_remove_events_copy := nil;
  Fsnd_seq_remove_events_get_condition := nil;
  Fsnd_seq_remove_events_get_queue := nil;
  Fsnd_seq_remove_events_get_time := nil;
  Fsnd_seq_remove_events_get_dest := nil;
  Fsnd_seq_remove_events_get_channel := nil;
  Fsnd_seq_remove_events_get_event_type := nil;
  Fsnd_seq_remove_events_get_tag := nil;
  Fsnd_seq_remove_events_set_condition := nil;
  Fsnd_seq_remove_events_set_queue := nil;
  Fsnd_seq_remove_events_set_time := nil;
  Fsnd_seq_remove_events_set_dest := nil;
  Fsnd_seq_remove_events_set_channel := nil;
  Fsnd_seq_remove_events_set_event_type := nil;
  Fsnd_seq_remove_events_set_tag := nil;
  Fsnd_seq_remove_events := nil;
  Fsnd_seq_set_bit := nil;
  Fsnd_seq_unset_bit := nil;
  Fsnd_seq_change_bit := nil;
  Fsnd_seq_get_bit := nil;
  Fsnd_seq_create_simple_port := nil;
  Fsnd_seq_delete_simple_port := nil;
  Fsnd_seq_connect_from := nil;
  Fsnd_seq_connect_to := nil;
  Fsnd_seq_disconnect_from := nil;
  Fsnd_seq_disconnect_to := nil;
  Fsnd_seq_set_client_name := nil;
  Fsnd_seq_set_client_event_filter := nil;
  Fsnd_seq_set_client_pool_output := nil;
  Fsnd_seq_set_client_pool_output_room := nil;
  Fsnd_seq_set_client_pool_input := nil;
  Fsnd_seq_sync_output_queue := nil;
  Fsnd_seq_parse_address := nil;
  Fsnd_seq_reset_pool_output := nil;
  Fsnd_seq_reset_pool_input := nil;
  Fsnd_seq_control_queue := nil;
  Fsnd_strerror := nil;
{$endif PRELOAD_ROUTINES }
end { TAsoundSeq.Create } ;


(************************************************************************** DCN *)


procedure TAsoundSeq.LoadVarargsRoutine(loadName: string= ''; keepGoing: boolean= false);


begin
  loadName := Trim(loadName);
  if loadName = '*' then
    loadName := '';
end { TAsoundSeq.LoadVarargsRoutine } ;


(************************************************************************** DLV *)


function TAsoundSeq.snd_seq_open(handle: PPsnd_seq_t; name: PChar; streams: cint; mode: cint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_open), 'snd_seq_open');
  result := Fsnd_seq_open(handle, name, streams, mode)
end { TAsoundSeq.snd_seq_open } ;


function TAsoundSeq.snd_seq_open_lconf(handle: PPsnd_seq_t; name: PChar; streams: cint; mode: cint; lconf: Psnd_config_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_open_lconf), 'snd_seq_open_lconf');
  result := Fsnd_seq_open_lconf(handle, name, streams, mode, lconf)
end { TAsoundSeq.snd_seq_open_lconf } ;


function TAsoundSeq.snd_seq_name(seq: Psnd_seq_t): PChar; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_name), 'snd_seq_name');
  result := Fsnd_seq_name(seq)
end { TAsoundSeq.snd_seq_name } ;


function TAsoundSeq.snd_seq_type(seq: Psnd_seq_t): snd_seq_type_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_type), 'snd_seq_type');
  result := Fsnd_seq_type(seq)
end { TAsoundSeq.snd_seq_type } ;


function TAsoundSeq.snd_seq_close(handle: Psnd_seq_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_close), 'snd_seq_close');
  result := Fsnd_seq_close(handle)
end { TAsoundSeq.snd_seq_close } ;


function TAsoundSeq.snd_seq_poll_descriptors_count(handle: Psnd_seq_t; events: cshort): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_poll_descriptors_count), 'snd_seq_poll_descriptors_count');
  result := Fsnd_seq_poll_descriptors_count(handle, events)
end { TAsoundSeq.snd_seq_poll_descriptors_count } ;


function TAsoundSeq.snd_seq_poll_descriptors(handle: Psnd_seq_t; pfds: {struct pollfd*}Pointer; space: cuint; events: cshort): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_poll_descriptors), 'snd_seq_poll_descriptors');
  result := Fsnd_seq_poll_descriptors(handle, pfds, space, events)
end { TAsoundSeq.snd_seq_poll_descriptors } ;


function TAsoundSeq.snd_seq_poll_descriptors_revents(seq: Psnd_seq_t; pfds: {struct pollfd*}Pointer; nfds: cuint; revents: Pcushort): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_poll_descriptors_revents), 'snd_seq_poll_descriptors_revents');
  result := Fsnd_seq_poll_descriptors_revents(seq, pfds, nfds, revents)
end { TAsoundSeq.snd_seq_poll_descriptors_revents } ;


function TAsoundSeq.snd_seq_nonblock(handle: Psnd_seq_t; nonblock: cint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_nonblock), 'snd_seq_nonblock');
  result := Fsnd_seq_nonblock(handle, nonblock)
end { TAsoundSeq.snd_seq_nonblock } ;


function TAsoundSeq.snd_seq_client_id(handle: Psnd_seq_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_id), 'snd_seq_client_id');
  result := Fsnd_seq_client_id(handle)
end { TAsoundSeq.snd_seq_client_id } ;


function TAsoundSeq.snd_seq_get_output_buffer_size(handle: Psnd_seq_t): size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_get_output_buffer_size), 'snd_seq_get_output_buffer_size');
  result := Fsnd_seq_get_output_buffer_size(handle)
end { TAsoundSeq.snd_seq_get_output_buffer_size } ;


function TAsoundSeq.snd_seq_get_input_buffer_size(handle: Psnd_seq_t): size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_get_input_buffer_size), 'snd_seq_get_input_buffer_size');
  result := Fsnd_seq_get_input_buffer_size(handle)
end { TAsoundSeq.snd_seq_get_input_buffer_size } ;


function TAsoundSeq.snd_seq_set_output_buffer_size(handle: Psnd_seq_t; size: size_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_set_output_buffer_size), 'snd_seq_set_output_buffer_size');
  result := Fsnd_seq_set_output_buffer_size(handle, size)
end { TAsoundSeq.snd_seq_set_output_buffer_size } ;


function TAsoundSeq.snd_seq_set_input_buffer_size(handle: Psnd_seq_t; size: size_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_set_input_buffer_size), 'snd_seq_set_input_buffer_size');
  result := Fsnd_seq_set_input_buffer_size(handle, size)
end { TAsoundSeq.snd_seq_set_input_buffer_size } ;


function TAsoundSeq.snd_seq_system_info_sizeof: size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_system_info_sizeof), 'snd_seq_system_info_sizeof');
  result := Fsnd_seq_system_info_sizeof()
end { TAsoundSeq.snd_seq_system_info_sizeof } ;


function TAsoundSeq.snd_seq_system_info_malloc(ptr: PPsnd_seq_system_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_system_info_malloc), 'snd_seq_system_info_malloc');
  result := Fsnd_seq_system_info_malloc(ptr)
end { TAsoundSeq.snd_seq_system_info_malloc } ;


procedure TAsoundSeq.snd_seq_system_info_free(ptr: Psnd_seq_system_info_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_system_info_free), 'snd_seq_system_info_free');
  Fsnd_seq_system_info_free(ptr)
end { TAsoundSeq.snd_seq_system_info_free } ;


procedure TAsoundSeq.snd_seq_system_info_copy(dst: Psnd_seq_system_info_t; src: Psnd_seq_system_info_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_system_info_copy), 'snd_seq_system_info_copy');
  Fsnd_seq_system_info_copy(dst, src)
end { TAsoundSeq.snd_seq_system_info_copy } ;


function TAsoundSeq.snd_seq_system_info_get_queues(info: Psnd_seq_system_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_system_info_get_queues), 'snd_seq_system_info_get_queues');
  result := Fsnd_seq_system_info_get_queues(info)
end { TAsoundSeq.snd_seq_system_info_get_queues } ;


function TAsoundSeq.snd_seq_system_info_get_clients(info: Psnd_seq_system_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_system_info_get_clients), 'snd_seq_system_info_get_clients');
  result := Fsnd_seq_system_info_get_clients(info)
end { TAsoundSeq.snd_seq_system_info_get_clients } ;


function TAsoundSeq.snd_seq_system_info_get_ports(info: Psnd_seq_system_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_system_info_get_ports), 'snd_seq_system_info_get_ports');
  result := Fsnd_seq_system_info_get_ports(info)
end { TAsoundSeq.snd_seq_system_info_get_ports } ;


function TAsoundSeq.snd_seq_system_info_get_channels(info: Psnd_seq_system_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_system_info_get_channels), 'snd_seq_system_info_get_channels');
  result := Fsnd_seq_system_info_get_channels(info)
end { TAsoundSeq.snd_seq_system_info_get_channels } ;


function TAsoundSeq.snd_seq_system_info_get_cur_clients(info: Psnd_seq_system_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_system_info_get_cur_clients), 'snd_seq_system_info_get_cur_clients');
  result := Fsnd_seq_system_info_get_cur_clients(info)
end { TAsoundSeq.snd_seq_system_info_get_cur_clients } ;


function TAsoundSeq.snd_seq_system_info_get_cur_queues(info: Psnd_seq_system_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_system_info_get_cur_queues), 'snd_seq_system_info_get_cur_queues');
  result := Fsnd_seq_system_info_get_cur_queues(info)
end { TAsoundSeq.snd_seq_system_info_get_cur_queues } ;


function TAsoundSeq.snd_seq_system_info(handle: Psnd_seq_t; info: Psnd_seq_system_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_system_info), 'snd_seq_system_info');
  result := Fsnd_seq_system_info(handle, info)
end { TAsoundSeq.snd_seq_system_info } ;


function TAsoundSeq.snd_seq_client_info_sizeof: size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_sizeof), 'snd_seq_client_info_sizeof');
  result := Fsnd_seq_client_info_sizeof()
end { TAsoundSeq.snd_seq_client_info_sizeof } ;


function TAsoundSeq.snd_seq_client_info_malloc(ptr: PPsnd_seq_client_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_malloc), 'snd_seq_client_info_malloc');
  result := Fsnd_seq_client_info_malloc(ptr)
end { TAsoundSeq.snd_seq_client_info_malloc } ;


procedure TAsoundSeq.snd_seq_client_info_free(ptr: Psnd_seq_client_info_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_free), 'snd_seq_client_info_free');
  Fsnd_seq_client_info_free(ptr)
end { TAsoundSeq.snd_seq_client_info_free } ;


procedure TAsoundSeq.snd_seq_client_info_copy(dst: Psnd_seq_client_info_t; src: Psnd_seq_client_info_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_copy), 'snd_seq_client_info_copy');
  Fsnd_seq_client_info_copy(dst, src)
end { TAsoundSeq.snd_seq_client_info_copy } ;


function TAsoundSeq.snd_seq_client_info_get_client(info: Psnd_seq_client_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_get_client), 'snd_seq_client_info_get_client');
  result := Fsnd_seq_client_info_get_client(info)
end { TAsoundSeq.snd_seq_client_info_get_client } ;


function TAsoundSeq.snd_seq_client_info_get_type(info: Psnd_seq_client_info_t): snd_seq_client_type_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_get_type), 'snd_seq_client_info_get_type');
  result := Fsnd_seq_client_info_get_type(info)
end { TAsoundSeq.snd_seq_client_info_get_type } ;


function TAsoundSeq.snd_seq_client_info_get_name(info: Psnd_seq_client_info_t): PChar; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_get_name), 'snd_seq_client_info_get_name');
  result := Fsnd_seq_client_info_get_name(info)
end { TAsoundSeq.snd_seq_client_info_get_name } ;


function TAsoundSeq.snd_seq_client_info_get_broadcast_filter(info: Psnd_seq_client_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_get_broadcast_filter), 'snd_seq_client_info_get_broadcast_filter');
  result := Fsnd_seq_client_info_get_broadcast_filter(info)
end { TAsoundSeq.snd_seq_client_info_get_broadcast_filter } ;


function TAsoundSeq.snd_seq_client_info_get_error_bounce(info: Psnd_seq_client_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_get_error_bounce), 'snd_seq_client_info_get_error_bounce');
  result := Fsnd_seq_client_info_get_error_bounce(info)
end { TAsoundSeq.snd_seq_client_info_get_error_bounce } ;


function TAsoundSeq.snd_seq_client_info_get_event_filter(info: Psnd_seq_client_info_t): Pcuchar; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_get_event_filter), 'snd_seq_client_info_get_event_filter');
  result := Fsnd_seq_client_info_get_event_filter(info)
end { TAsoundSeq.snd_seq_client_info_get_event_filter } ;


function TAsoundSeq.snd_seq_client_info_get_num_ports(info: Psnd_seq_client_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_get_num_ports), 'snd_seq_client_info_get_num_ports');
  result := Fsnd_seq_client_info_get_num_ports(info)
end { TAsoundSeq.snd_seq_client_info_get_num_ports } ;


function TAsoundSeq.snd_seq_client_info_get_event_lost(info: Psnd_seq_client_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_get_event_lost), 'snd_seq_client_info_get_event_lost');
  result := Fsnd_seq_client_info_get_event_lost(info)
end { TAsoundSeq.snd_seq_client_info_get_event_lost } ;


procedure TAsoundSeq.snd_seq_client_info_set_client(info: Psnd_seq_client_info_t; client: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_set_client), 'snd_seq_client_info_set_client');
  Fsnd_seq_client_info_set_client(info, client)
end { TAsoundSeq.snd_seq_client_info_set_client } ;


procedure TAsoundSeq.snd_seq_client_info_set_name(info: Psnd_seq_client_info_t; name: PChar); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_set_name), 'snd_seq_client_info_set_name');
  Fsnd_seq_client_info_set_name(info, name)
end { TAsoundSeq.snd_seq_client_info_set_name } ;


procedure TAsoundSeq.snd_seq_client_info_set_broadcast_filter(info: Psnd_seq_client_info_t; val: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_set_broadcast_filter), 'snd_seq_client_info_set_broadcast_filter');
  Fsnd_seq_client_info_set_broadcast_filter(info, val)
end { TAsoundSeq.snd_seq_client_info_set_broadcast_filter } ;


procedure TAsoundSeq.snd_seq_client_info_set_error_bounce(info: Psnd_seq_client_info_t; val: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_set_error_bounce), 'snd_seq_client_info_set_error_bounce');
  Fsnd_seq_client_info_set_error_bounce(info, val)
end { TAsoundSeq.snd_seq_client_info_set_error_bounce } ;


procedure TAsoundSeq.snd_seq_client_info_set_event_filter(info: Psnd_seq_client_info_t; filter: Pcuchar); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_set_event_filter), 'snd_seq_client_info_set_event_filter');
  Fsnd_seq_client_info_set_event_filter(info, filter)
end { TAsoundSeq.snd_seq_client_info_set_event_filter } ;


procedure TAsoundSeq.snd_seq_client_info_event_filter_clear(info: Psnd_seq_client_info_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_event_filter_clear), 'snd_seq_client_info_event_filter_clear');
  Fsnd_seq_client_info_event_filter_clear(info)
end { TAsoundSeq.snd_seq_client_info_event_filter_clear } ;


procedure TAsoundSeq.snd_seq_client_info_event_filter_add(info: Psnd_seq_client_info_t; event_type: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_event_filter_add), 'snd_seq_client_info_event_filter_add');
  Fsnd_seq_client_info_event_filter_add(info, event_type)
end { TAsoundSeq.snd_seq_client_info_event_filter_add } ;


procedure TAsoundSeq.snd_seq_client_info_event_filter_del(info: Psnd_seq_client_info_t; event_type: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_event_filter_del), 'snd_seq_client_info_event_filter_del');
  Fsnd_seq_client_info_event_filter_del(info, event_type)
end { TAsoundSeq.snd_seq_client_info_event_filter_del } ;


function TAsoundSeq.snd_seq_client_info_event_filter_check(info: Psnd_seq_client_info_t; event_type: cint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_info_event_filter_check), 'snd_seq_client_info_event_filter_check');
  result := Fsnd_seq_client_info_event_filter_check(info, event_type)
end { TAsoundSeq.snd_seq_client_info_event_filter_check } ;


function TAsoundSeq.snd_seq_get_client_info(handle: Psnd_seq_t; info: Psnd_seq_client_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_get_client_info), 'snd_seq_get_client_info');
  result := Fsnd_seq_get_client_info(handle, info)
end { TAsoundSeq.snd_seq_get_client_info } ;


function TAsoundSeq.snd_seq_get_any_client_info(handle: Psnd_seq_t; client: cint; info: Psnd_seq_client_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_get_any_client_info), 'snd_seq_get_any_client_info');
  result := Fsnd_seq_get_any_client_info(handle, client, info)
end { TAsoundSeq.snd_seq_get_any_client_info } ;


function TAsoundSeq.snd_seq_set_client_info(handle: Psnd_seq_t; info: Psnd_seq_client_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_set_client_info), 'snd_seq_set_client_info');
  result := Fsnd_seq_set_client_info(handle, info)
end { TAsoundSeq.snd_seq_set_client_info } ;


function TAsoundSeq.snd_seq_query_next_client(handle: Psnd_seq_t; info: Psnd_seq_client_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_next_client), 'snd_seq_query_next_client');
  result := Fsnd_seq_query_next_client(handle, info)
end { TAsoundSeq.snd_seq_query_next_client } ;


function TAsoundSeq.snd_seq_client_pool_sizeof: size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_pool_sizeof), 'snd_seq_client_pool_sizeof');
  result := Fsnd_seq_client_pool_sizeof()
end { TAsoundSeq.snd_seq_client_pool_sizeof } ;


function TAsoundSeq.snd_seq_client_pool_malloc(ptr: PPsnd_seq_client_pool_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_pool_malloc), 'snd_seq_client_pool_malloc');
  result := Fsnd_seq_client_pool_malloc(ptr)
end { TAsoundSeq.snd_seq_client_pool_malloc } ;


procedure TAsoundSeq.snd_seq_client_pool_free(ptr: Psnd_seq_client_pool_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_pool_free), 'snd_seq_client_pool_free');
  Fsnd_seq_client_pool_free(ptr)
end { TAsoundSeq.snd_seq_client_pool_free } ;


procedure TAsoundSeq.snd_seq_client_pool_copy(dst: Psnd_seq_client_pool_t; src: Psnd_seq_client_pool_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_pool_copy), 'snd_seq_client_pool_copy');
  Fsnd_seq_client_pool_copy(dst, src)
end { TAsoundSeq.snd_seq_client_pool_copy } ;


function TAsoundSeq.snd_seq_client_pool_get_client(info: Psnd_seq_client_pool_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_pool_get_client), 'snd_seq_client_pool_get_client');
  result := Fsnd_seq_client_pool_get_client(info)
end { TAsoundSeq.snd_seq_client_pool_get_client } ;


function TAsoundSeq.snd_seq_client_pool_get_output_pool(info: Psnd_seq_client_pool_t): size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_pool_get_output_pool), 'snd_seq_client_pool_get_output_pool');
  result := Fsnd_seq_client_pool_get_output_pool(info)
end { TAsoundSeq.snd_seq_client_pool_get_output_pool } ;


function TAsoundSeq.snd_seq_client_pool_get_input_pool(info: Psnd_seq_client_pool_t): size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_pool_get_input_pool), 'snd_seq_client_pool_get_input_pool');
  result := Fsnd_seq_client_pool_get_input_pool(info)
end { TAsoundSeq.snd_seq_client_pool_get_input_pool } ;


function TAsoundSeq.snd_seq_client_pool_get_output_room(info: Psnd_seq_client_pool_t): size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_pool_get_output_room), 'snd_seq_client_pool_get_output_room');
  result := Fsnd_seq_client_pool_get_output_room(info)
end { TAsoundSeq.snd_seq_client_pool_get_output_room } ;


function TAsoundSeq.snd_seq_client_pool_get_output_free(info: Psnd_seq_client_pool_t): size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_pool_get_output_free), 'snd_seq_client_pool_get_output_free');
  result := Fsnd_seq_client_pool_get_output_free(info)
end { TAsoundSeq.snd_seq_client_pool_get_output_free } ;


function TAsoundSeq.snd_seq_client_pool_get_input_free(info: Psnd_seq_client_pool_t): size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_pool_get_input_free), 'snd_seq_client_pool_get_input_free');
  result := Fsnd_seq_client_pool_get_input_free(info)
end { TAsoundSeq.snd_seq_client_pool_get_input_free } ;


procedure TAsoundSeq.snd_seq_client_pool_set_output_pool(info: Psnd_seq_client_pool_t; size: size_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_pool_set_output_pool), 'snd_seq_client_pool_set_output_pool');
  Fsnd_seq_client_pool_set_output_pool(info, size)
end { TAsoundSeq.snd_seq_client_pool_set_output_pool } ;


procedure TAsoundSeq.snd_seq_client_pool_set_input_pool(info: Psnd_seq_client_pool_t; size: size_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_pool_set_input_pool), 'snd_seq_client_pool_set_input_pool');
  Fsnd_seq_client_pool_set_input_pool(info, size)
end { TAsoundSeq.snd_seq_client_pool_set_input_pool } ;


procedure TAsoundSeq.snd_seq_client_pool_set_output_room(info: Psnd_seq_client_pool_t; size: size_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_client_pool_set_output_room), 'snd_seq_client_pool_set_output_room');
  Fsnd_seq_client_pool_set_output_room(info, size)
end { TAsoundSeq.snd_seq_client_pool_set_output_room } ;


function TAsoundSeq.snd_seq_get_client_pool(handle: Psnd_seq_t; info: Psnd_seq_client_pool_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_get_client_pool), 'snd_seq_get_client_pool');
  result := Fsnd_seq_get_client_pool(handle, info)
end { TAsoundSeq.snd_seq_get_client_pool } ;


function TAsoundSeq.snd_seq_set_client_pool(handle: Psnd_seq_t; info: Psnd_seq_client_pool_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_set_client_pool), 'snd_seq_set_client_pool');
  result := Fsnd_seq_set_client_pool(handle, info)
end { TAsoundSeq.snd_seq_set_client_pool } ;


function TAsoundSeq.snd_seq_port_info_sizeof: size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_sizeof), 'snd_seq_port_info_sizeof');
  result := Fsnd_seq_port_info_sizeof()
end { TAsoundSeq.snd_seq_port_info_sizeof } ;


function TAsoundSeq.snd_seq_port_info_malloc(ptr: PPsnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_malloc), 'snd_seq_port_info_malloc');
  result := Fsnd_seq_port_info_malloc(ptr)
end { TAsoundSeq.snd_seq_port_info_malloc } ;


procedure TAsoundSeq.snd_seq_port_info_free(ptr: Psnd_seq_port_info_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_free), 'snd_seq_port_info_free');
  Fsnd_seq_port_info_free(ptr)
end { TAsoundSeq.snd_seq_port_info_free } ;


procedure TAsoundSeq.snd_seq_port_info_copy(dst: Psnd_seq_port_info_t; src: Psnd_seq_port_info_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_copy), 'snd_seq_port_info_copy');
  Fsnd_seq_port_info_copy(dst, src)
end { TAsoundSeq.snd_seq_port_info_copy } ;


function TAsoundSeq.snd_seq_port_info_get_client(info: Psnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_get_client), 'snd_seq_port_info_get_client');
  result := Fsnd_seq_port_info_get_client(info)
end { TAsoundSeq.snd_seq_port_info_get_client } ;


function TAsoundSeq.snd_seq_port_info_get_port(info: Psnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_get_port), 'snd_seq_port_info_get_port');
  result := Fsnd_seq_port_info_get_port(info)
end { TAsoundSeq.snd_seq_port_info_get_port } ;


function TAsoundSeq.snd_seq_port_info_get_addr(info: Psnd_seq_port_info_t): Psnd_seq_addr_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_get_addr), 'snd_seq_port_info_get_addr');
  result := Fsnd_seq_port_info_get_addr(info)
end { TAsoundSeq.snd_seq_port_info_get_addr } ;


function TAsoundSeq.snd_seq_port_info_get_name(info: Psnd_seq_port_info_t): PChar; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_get_name), 'snd_seq_port_info_get_name');
  result := Fsnd_seq_port_info_get_name(info)
end { TAsoundSeq.snd_seq_port_info_get_name } ;


function TAsoundSeq.snd_seq_port_info_get_capability(info: Psnd_seq_port_info_t): cuint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_get_capability), 'snd_seq_port_info_get_capability');
  result := Fsnd_seq_port_info_get_capability(info)
end { TAsoundSeq.snd_seq_port_info_get_capability } ;


function TAsoundSeq.snd_seq_port_info_get_type(info: Psnd_seq_port_info_t): cuint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_get_type), 'snd_seq_port_info_get_type');
  result := Fsnd_seq_port_info_get_type(info)
end { TAsoundSeq.snd_seq_port_info_get_type } ;


function TAsoundSeq.snd_seq_port_info_get_midi_channels(info: Psnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_get_midi_channels), 'snd_seq_port_info_get_midi_channels');
  result := Fsnd_seq_port_info_get_midi_channels(info)
end { TAsoundSeq.snd_seq_port_info_get_midi_channels } ;


function TAsoundSeq.snd_seq_port_info_get_midi_voices(info: Psnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_get_midi_voices), 'snd_seq_port_info_get_midi_voices');
  result := Fsnd_seq_port_info_get_midi_voices(info)
end { TAsoundSeq.snd_seq_port_info_get_midi_voices } ;


function TAsoundSeq.snd_seq_port_info_get_synth_voices(info: Psnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_get_synth_voices), 'snd_seq_port_info_get_synth_voices');
  result := Fsnd_seq_port_info_get_synth_voices(info)
end { TAsoundSeq.snd_seq_port_info_get_synth_voices } ;


function TAsoundSeq.snd_seq_port_info_get_read_use(info: Psnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_get_read_use), 'snd_seq_port_info_get_read_use');
  result := Fsnd_seq_port_info_get_read_use(info)
end { TAsoundSeq.snd_seq_port_info_get_read_use } ;


function TAsoundSeq.snd_seq_port_info_get_write_use(info: Psnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_get_write_use), 'snd_seq_port_info_get_write_use');
  result := Fsnd_seq_port_info_get_write_use(info)
end { TAsoundSeq.snd_seq_port_info_get_write_use } ;


function TAsoundSeq.snd_seq_port_info_get_port_specified(info: Psnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_get_port_specified), 'snd_seq_port_info_get_port_specified');
  result := Fsnd_seq_port_info_get_port_specified(info)
end { TAsoundSeq.snd_seq_port_info_get_port_specified } ;


function TAsoundSeq.snd_seq_port_info_get_timestamping(info: Psnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_get_timestamping), 'snd_seq_port_info_get_timestamping');
  result := Fsnd_seq_port_info_get_timestamping(info)
end { TAsoundSeq.snd_seq_port_info_get_timestamping } ;


function TAsoundSeq.snd_seq_port_info_get_timestamp_real(info: Psnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_get_timestamp_real), 'snd_seq_port_info_get_timestamp_real');
  result := Fsnd_seq_port_info_get_timestamp_real(info)
end { TAsoundSeq.snd_seq_port_info_get_timestamp_real } ;


function TAsoundSeq.snd_seq_port_info_get_timestamp_queue(info: Psnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_get_timestamp_queue), 'snd_seq_port_info_get_timestamp_queue');
  result := Fsnd_seq_port_info_get_timestamp_queue(info)
end { TAsoundSeq.snd_seq_port_info_get_timestamp_queue } ;


procedure TAsoundSeq.snd_seq_port_info_set_client(info: Psnd_seq_port_info_t; client: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_set_client), 'snd_seq_port_info_set_client');
  Fsnd_seq_port_info_set_client(info, client)
end { TAsoundSeq.snd_seq_port_info_set_client } ;


procedure TAsoundSeq.snd_seq_port_info_set_port(info: Psnd_seq_port_info_t; port: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_set_port), 'snd_seq_port_info_set_port');
  Fsnd_seq_port_info_set_port(info, port)
end { TAsoundSeq.snd_seq_port_info_set_port } ;


procedure TAsoundSeq.snd_seq_port_info_set_addr(info: Psnd_seq_port_info_t; addr: Psnd_seq_addr_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_set_addr), 'snd_seq_port_info_set_addr');
  Fsnd_seq_port_info_set_addr(info, addr)
end { TAsoundSeq.snd_seq_port_info_set_addr } ;


procedure TAsoundSeq.snd_seq_port_info_set_name(info: Psnd_seq_port_info_t; name: PChar); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_set_name), 'snd_seq_port_info_set_name');
  Fsnd_seq_port_info_set_name(info, name)
end { TAsoundSeq.snd_seq_port_info_set_name } ;


procedure TAsoundSeq.snd_seq_port_info_set_capability(info: Psnd_seq_port_info_t; capability: cuint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_set_capability), 'snd_seq_port_info_set_capability');
  Fsnd_seq_port_info_set_capability(info, capability)
end { TAsoundSeq.snd_seq_port_info_set_capability } ;


procedure TAsoundSeq.snd_seq_port_info_set_type(info: Psnd_seq_port_info_t; _type: cuint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_set_type), 'snd_seq_port_info_set_type');
  Fsnd_seq_port_info_set_type(info, _type)
end { TAsoundSeq.snd_seq_port_info_set_type } ;


procedure TAsoundSeq.snd_seq_port_info_set_midi_channels(info: Psnd_seq_port_info_t; channels: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_set_midi_channels), 'snd_seq_port_info_set_midi_channels');
  Fsnd_seq_port_info_set_midi_channels(info, channels)
end { TAsoundSeq.snd_seq_port_info_set_midi_channels } ;


procedure TAsoundSeq.snd_seq_port_info_set_midi_voices(info: Psnd_seq_port_info_t; voices: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_set_midi_voices), 'snd_seq_port_info_set_midi_voices');
  Fsnd_seq_port_info_set_midi_voices(info, voices)
end { TAsoundSeq.snd_seq_port_info_set_midi_voices } ;


procedure TAsoundSeq.snd_seq_port_info_set_synth_voices(info: Psnd_seq_port_info_t; voices: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_set_synth_voices), 'snd_seq_port_info_set_synth_voices');
  Fsnd_seq_port_info_set_synth_voices(info, voices)
end { TAsoundSeq.snd_seq_port_info_set_synth_voices } ;


procedure TAsoundSeq.snd_seq_port_info_set_port_specified(info: Psnd_seq_port_info_t; val: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_set_port_specified), 'snd_seq_port_info_set_port_specified');
  Fsnd_seq_port_info_set_port_specified(info, val)
end { TAsoundSeq.snd_seq_port_info_set_port_specified } ;


procedure TAsoundSeq.snd_seq_port_info_set_timestamping(info: Psnd_seq_port_info_t; enable: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_set_timestamping), 'snd_seq_port_info_set_timestamping');
  Fsnd_seq_port_info_set_timestamping(info, enable)
end { TAsoundSeq.snd_seq_port_info_set_timestamping } ;


procedure TAsoundSeq.snd_seq_port_info_set_timestamp_real(info: Psnd_seq_port_info_t; realtime: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_set_timestamp_real), 'snd_seq_port_info_set_timestamp_real');
  Fsnd_seq_port_info_set_timestamp_real(info, realtime)
end { TAsoundSeq.snd_seq_port_info_set_timestamp_real } ;


procedure TAsoundSeq.snd_seq_port_info_set_timestamp_queue(info: Psnd_seq_port_info_t; queue: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_info_set_timestamp_queue), 'snd_seq_port_info_set_timestamp_queue');
  Fsnd_seq_port_info_set_timestamp_queue(info, queue)
end { TAsoundSeq.snd_seq_port_info_set_timestamp_queue } ;


function TAsoundSeq.snd_seq_create_port(handle: Psnd_seq_t; info: Psnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_create_port), 'snd_seq_create_port');
  result := Fsnd_seq_create_port(handle, info)
end { TAsoundSeq.snd_seq_create_port } ;


function TAsoundSeq.snd_seq_delete_port(handle: Psnd_seq_t; port: cint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_delete_port), 'snd_seq_delete_port');
  result := Fsnd_seq_delete_port(handle, port)
end { TAsoundSeq.snd_seq_delete_port } ;


function TAsoundSeq.snd_seq_get_port_info(handle: Psnd_seq_t; port: cint; info: Psnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_get_port_info), 'snd_seq_get_port_info');
  result := Fsnd_seq_get_port_info(handle, port, info)
end { TAsoundSeq.snd_seq_get_port_info } ;


function TAsoundSeq.snd_seq_get_any_port_info(handle: Psnd_seq_t; client: cint; port: cint; info: Psnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_get_any_port_info), 'snd_seq_get_any_port_info');
  result := Fsnd_seq_get_any_port_info(handle, client, port, info)
end { TAsoundSeq.snd_seq_get_any_port_info } ;


function TAsoundSeq.snd_seq_set_port_info(handle: Psnd_seq_t; port: cint; info: Psnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_set_port_info), 'snd_seq_set_port_info');
  result := Fsnd_seq_set_port_info(handle, port, info)
end { TAsoundSeq.snd_seq_set_port_info } ;


function TAsoundSeq.snd_seq_query_next_port(handle: Psnd_seq_t; info: Psnd_seq_port_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_next_port), 'snd_seq_query_next_port');
  result := Fsnd_seq_query_next_port(handle, info)
end { TAsoundSeq.snd_seq_query_next_port } ;


function TAsoundSeq.snd_seq_port_subscribe_sizeof: size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_subscribe_sizeof), 'snd_seq_port_subscribe_sizeof');
  result := Fsnd_seq_port_subscribe_sizeof()
end { TAsoundSeq.snd_seq_port_subscribe_sizeof } ;


function TAsoundSeq.snd_seq_port_subscribe_malloc(ptr: PPsnd_seq_port_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_subscribe_malloc), 'snd_seq_port_subscribe_malloc');
  result := Fsnd_seq_port_subscribe_malloc(ptr)
end { TAsoundSeq.snd_seq_port_subscribe_malloc } ;


procedure TAsoundSeq.snd_seq_port_subscribe_free(ptr: Psnd_seq_port_subscribe_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_subscribe_free), 'snd_seq_port_subscribe_free');
  Fsnd_seq_port_subscribe_free(ptr)
end { TAsoundSeq.snd_seq_port_subscribe_free } ;


procedure TAsoundSeq.snd_seq_port_subscribe_copy(dst: Psnd_seq_port_subscribe_t; src: Psnd_seq_port_subscribe_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_subscribe_copy), 'snd_seq_port_subscribe_copy');
  Fsnd_seq_port_subscribe_copy(dst, src)
end { TAsoundSeq.snd_seq_port_subscribe_copy } ;


function TAsoundSeq.snd_seq_port_subscribe_get_sender(info: Psnd_seq_port_subscribe_t): Psnd_seq_addr_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_subscribe_get_sender), 'snd_seq_port_subscribe_get_sender');
  result := Fsnd_seq_port_subscribe_get_sender(info)
end { TAsoundSeq.snd_seq_port_subscribe_get_sender } ;


function TAsoundSeq.snd_seq_port_subscribe_get_dest(info: Psnd_seq_port_subscribe_t): Psnd_seq_addr_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_subscribe_get_dest), 'snd_seq_port_subscribe_get_dest');
  result := Fsnd_seq_port_subscribe_get_dest(info)
end { TAsoundSeq.snd_seq_port_subscribe_get_dest } ;


function TAsoundSeq.snd_seq_port_subscribe_get_queue(info: Psnd_seq_port_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_subscribe_get_queue), 'snd_seq_port_subscribe_get_queue');
  result := Fsnd_seq_port_subscribe_get_queue(info)
end { TAsoundSeq.snd_seq_port_subscribe_get_queue } ;


function TAsoundSeq.snd_seq_port_subscribe_get_exclusive(info: Psnd_seq_port_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_subscribe_get_exclusive), 'snd_seq_port_subscribe_get_exclusive');
  result := Fsnd_seq_port_subscribe_get_exclusive(info)
end { TAsoundSeq.snd_seq_port_subscribe_get_exclusive } ;


function TAsoundSeq.snd_seq_port_subscribe_get_time_update(info: Psnd_seq_port_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_subscribe_get_time_update), 'snd_seq_port_subscribe_get_time_update');
  result := Fsnd_seq_port_subscribe_get_time_update(info)
end { TAsoundSeq.snd_seq_port_subscribe_get_time_update } ;


function TAsoundSeq.snd_seq_port_subscribe_get_time_real(info: Psnd_seq_port_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_subscribe_get_time_real), 'snd_seq_port_subscribe_get_time_real');
  result := Fsnd_seq_port_subscribe_get_time_real(info)
end { TAsoundSeq.snd_seq_port_subscribe_get_time_real } ;


procedure TAsoundSeq.snd_seq_port_subscribe_set_sender(info: Psnd_seq_port_subscribe_t; addr: Psnd_seq_addr_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_subscribe_set_sender), 'snd_seq_port_subscribe_set_sender');
  Fsnd_seq_port_subscribe_set_sender(info, addr)
end { TAsoundSeq.snd_seq_port_subscribe_set_sender } ;


procedure TAsoundSeq.snd_seq_port_subscribe_set_dest(info: Psnd_seq_port_subscribe_t; addr: Psnd_seq_addr_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_subscribe_set_dest), 'snd_seq_port_subscribe_set_dest');
  Fsnd_seq_port_subscribe_set_dest(info, addr)
end { TAsoundSeq.snd_seq_port_subscribe_set_dest } ;


procedure TAsoundSeq.snd_seq_port_subscribe_set_queue(info: Psnd_seq_port_subscribe_t; q: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_subscribe_set_queue), 'snd_seq_port_subscribe_set_queue');
  Fsnd_seq_port_subscribe_set_queue(info, q)
end { TAsoundSeq.snd_seq_port_subscribe_set_queue } ;


procedure TAsoundSeq.snd_seq_port_subscribe_set_exclusive(info: Psnd_seq_port_subscribe_t; val: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_subscribe_set_exclusive), 'snd_seq_port_subscribe_set_exclusive');
  Fsnd_seq_port_subscribe_set_exclusive(info, val)
end { TAsoundSeq.snd_seq_port_subscribe_set_exclusive } ;


procedure TAsoundSeq.snd_seq_port_subscribe_set_time_update(info: Psnd_seq_port_subscribe_t; val: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_subscribe_set_time_update), 'snd_seq_port_subscribe_set_time_update');
  Fsnd_seq_port_subscribe_set_time_update(info, val)
end { TAsoundSeq.snd_seq_port_subscribe_set_time_update } ;


procedure TAsoundSeq.snd_seq_port_subscribe_set_time_real(info: Psnd_seq_port_subscribe_t; val: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_port_subscribe_set_time_real), 'snd_seq_port_subscribe_set_time_real');
  Fsnd_seq_port_subscribe_set_time_real(info, val)
end { TAsoundSeq.snd_seq_port_subscribe_set_time_real } ;


function TAsoundSeq.snd_seq_get_port_subscription(handle: Psnd_seq_t; sub: Psnd_seq_port_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_get_port_subscription), 'snd_seq_get_port_subscription');
  result := Fsnd_seq_get_port_subscription(handle, sub)
end { TAsoundSeq.snd_seq_get_port_subscription } ;


function TAsoundSeq.snd_seq_subscribe_port(handle: Psnd_seq_t; sub: Psnd_seq_port_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_subscribe_port), 'snd_seq_subscribe_port');
  result := Fsnd_seq_subscribe_port(handle, sub)
end { TAsoundSeq.snd_seq_subscribe_port } ;


function TAsoundSeq.snd_seq_unsubscribe_port(handle: Psnd_seq_t; sub: Psnd_seq_port_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_unsubscribe_port), 'snd_seq_unsubscribe_port');
  result := Fsnd_seq_unsubscribe_port(handle, sub)
end { TAsoundSeq.snd_seq_unsubscribe_port } ;


function TAsoundSeq.snd_seq_query_subscribe_sizeof: size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_sizeof), 'snd_seq_query_subscribe_sizeof');
  result := Fsnd_seq_query_subscribe_sizeof()
end { TAsoundSeq.snd_seq_query_subscribe_sizeof } ;


function TAsoundSeq.snd_seq_query_subscribe_malloc(ptr: PPsnd_seq_query_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_malloc), 'snd_seq_query_subscribe_malloc');
  result := Fsnd_seq_query_subscribe_malloc(ptr)
end { TAsoundSeq.snd_seq_query_subscribe_malloc } ;


procedure TAsoundSeq.snd_seq_query_subscribe_free(ptr: Psnd_seq_query_subscribe_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_free), 'snd_seq_query_subscribe_free');
  Fsnd_seq_query_subscribe_free(ptr)
end { TAsoundSeq.snd_seq_query_subscribe_free } ;


procedure TAsoundSeq.snd_seq_query_subscribe_copy(dst: Psnd_seq_query_subscribe_t; src: Psnd_seq_query_subscribe_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_copy), 'snd_seq_query_subscribe_copy');
  Fsnd_seq_query_subscribe_copy(dst, src)
end { TAsoundSeq.snd_seq_query_subscribe_copy } ;


function TAsoundSeq.snd_seq_query_subscribe_get_client(info: Psnd_seq_query_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_get_client), 'snd_seq_query_subscribe_get_client');
  result := Fsnd_seq_query_subscribe_get_client(info)
end { TAsoundSeq.snd_seq_query_subscribe_get_client } ;


function TAsoundSeq.snd_seq_query_subscribe_get_port(info: Psnd_seq_query_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_get_port), 'snd_seq_query_subscribe_get_port');
  result := Fsnd_seq_query_subscribe_get_port(info)
end { TAsoundSeq.snd_seq_query_subscribe_get_port } ;


function TAsoundSeq.snd_seq_query_subscribe_get_root(info: Psnd_seq_query_subscribe_t): Psnd_seq_addr_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_get_root), 'snd_seq_query_subscribe_get_root');
  result := Fsnd_seq_query_subscribe_get_root(info)
end { TAsoundSeq.snd_seq_query_subscribe_get_root } ;


function TAsoundSeq.snd_seq_query_subscribe_get_type(info: Psnd_seq_query_subscribe_t): snd_seq_query_subs_type_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_get_type), 'snd_seq_query_subscribe_get_type');
  result := Fsnd_seq_query_subscribe_get_type(info)
end { TAsoundSeq.snd_seq_query_subscribe_get_type } ;


function TAsoundSeq.snd_seq_query_subscribe_get_index(info: Psnd_seq_query_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_get_index), 'snd_seq_query_subscribe_get_index');
  result := Fsnd_seq_query_subscribe_get_index(info)
end { TAsoundSeq.snd_seq_query_subscribe_get_index } ;


function TAsoundSeq.snd_seq_query_subscribe_get_num_subs(info: Psnd_seq_query_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_get_num_subs), 'snd_seq_query_subscribe_get_num_subs');
  result := Fsnd_seq_query_subscribe_get_num_subs(info)
end { TAsoundSeq.snd_seq_query_subscribe_get_num_subs } ;


function TAsoundSeq.snd_seq_query_subscribe_get_addr(info: Psnd_seq_query_subscribe_t): Psnd_seq_addr_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_get_addr), 'snd_seq_query_subscribe_get_addr');
  result := Fsnd_seq_query_subscribe_get_addr(info)
end { TAsoundSeq.snd_seq_query_subscribe_get_addr } ;


function TAsoundSeq.snd_seq_query_subscribe_get_queue(info: Psnd_seq_query_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_get_queue), 'snd_seq_query_subscribe_get_queue');
  result := Fsnd_seq_query_subscribe_get_queue(info)
end { TAsoundSeq.snd_seq_query_subscribe_get_queue } ;


function TAsoundSeq.snd_seq_query_subscribe_get_exclusive(info: Psnd_seq_query_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_get_exclusive), 'snd_seq_query_subscribe_get_exclusive');
  result := Fsnd_seq_query_subscribe_get_exclusive(info)
end { TAsoundSeq.snd_seq_query_subscribe_get_exclusive } ;


function TAsoundSeq.snd_seq_query_subscribe_get_time_update(info: Psnd_seq_query_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_get_time_update), 'snd_seq_query_subscribe_get_time_update');
  result := Fsnd_seq_query_subscribe_get_time_update(info)
end { TAsoundSeq.snd_seq_query_subscribe_get_time_update } ;


function TAsoundSeq.snd_seq_query_subscribe_get_time_real(info: Psnd_seq_query_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_get_time_real), 'snd_seq_query_subscribe_get_time_real');
  result := Fsnd_seq_query_subscribe_get_time_real(info)
end { TAsoundSeq.snd_seq_query_subscribe_get_time_real } ;


procedure TAsoundSeq.snd_seq_query_subscribe_set_client(info: Psnd_seq_query_subscribe_t; client: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_set_client), 'snd_seq_query_subscribe_set_client');
  Fsnd_seq_query_subscribe_set_client(info, client)
end { TAsoundSeq.snd_seq_query_subscribe_set_client } ;


procedure TAsoundSeq.snd_seq_query_subscribe_set_port(info: Psnd_seq_query_subscribe_t; port: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_set_port), 'snd_seq_query_subscribe_set_port');
  Fsnd_seq_query_subscribe_set_port(info, port)
end { TAsoundSeq.snd_seq_query_subscribe_set_port } ;


procedure TAsoundSeq.snd_seq_query_subscribe_set_root(info: Psnd_seq_query_subscribe_t; addr: Psnd_seq_addr_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_set_root), 'snd_seq_query_subscribe_set_root');
  Fsnd_seq_query_subscribe_set_root(info, addr)
end { TAsoundSeq.snd_seq_query_subscribe_set_root } ;


procedure TAsoundSeq.snd_seq_query_subscribe_set_type(info: Psnd_seq_query_subscribe_t; _type: snd_seq_query_subs_type_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_set_type), 'snd_seq_query_subscribe_set_type');
  Fsnd_seq_query_subscribe_set_type(info, _type)
end { TAsoundSeq.snd_seq_query_subscribe_set_type } ;


procedure TAsoundSeq.snd_seq_query_subscribe_set_index(info: Psnd_seq_query_subscribe_t; _index: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_subscribe_set_index), 'snd_seq_query_subscribe_set_index');
  Fsnd_seq_query_subscribe_set_index(info, _index)
end { TAsoundSeq.snd_seq_query_subscribe_set_index } ;


function TAsoundSeq.snd_seq_query_port_subscribers(seq: Psnd_seq_t; subs: Psnd_seq_query_subscribe_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_port_subscribers), 'snd_seq_query_port_subscribers');
  result := Fsnd_seq_query_port_subscribers(seq, subs)
end { TAsoundSeq.snd_seq_query_port_subscribers } ;


function TAsoundSeq.snd_seq_queue_info_sizeof: size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_info_sizeof), 'snd_seq_queue_info_sizeof');
  result := Fsnd_seq_queue_info_sizeof()
end { TAsoundSeq.snd_seq_queue_info_sizeof } ;


function TAsoundSeq.snd_seq_queue_info_malloc(ptr: PPsnd_seq_queue_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_info_malloc), 'snd_seq_queue_info_malloc');
  result := Fsnd_seq_queue_info_malloc(ptr)
end { TAsoundSeq.snd_seq_queue_info_malloc } ;


procedure TAsoundSeq.snd_seq_queue_info_free(ptr: Psnd_seq_queue_info_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_info_free), 'snd_seq_queue_info_free');
  Fsnd_seq_queue_info_free(ptr)
end { TAsoundSeq.snd_seq_queue_info_free } ;


procedure TAsoundSeq.snd_seq_queue_info_copy(dst: Psnd_seq_queue_info_t; src: Psnd_seq_queue_info_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_info_copy), 'snd_seq_queue_info_copy');
  Fsnd_seq_queue_info_copy(dst, src)
end { TAsoundSeq.snd_seq_queue_info_copy } ;


function TAsoundSeq.snd_seq_queue_info_get_queue(info: Psnd_seq_queue_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_info_get_queue), 'snd_seq_queue_info_get_queue');
  result := Fsnd_seq_queue_info_get_queue(info)
end { TAsoundSeq.snd_seq_queue_info_get_queue } ;


function TAsoundSeq.snd_seq_queue_info_get_name(info: Psnd_seq_queue_info_t): PChar; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_info_get_name), 'snd_seq_queue_info_get_name');
  result := Fsnd_seq_queue_info_get_name(info)
end { TAsoundSeq.snd_seq_queue_info_get_name } ;


function TAsoundSeq.snd_seq_queue_info_get_owner(info: Psnd_seq_queue_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_info_get_owner), 'snd_seq_queue_info_get_owner');
  result := Fsnd_seq_queue_info_get_owner(info)
end { TAsoundSeq.snd_seq_queue_info_get_owner } ;


function TAsoundSeq.snd_seq_queue_info_get_locked(info: Psnd_seq_queue_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_info_get_locked), 'snd_seq_queue_info_get_locked');
  result := Fsnd_seq_queue_info_get_locked(info)
end { TAsoundSeq.snd_seq_queue_info_get_locked } ;


function TAsoundSeq.snd_seq_queue_info_get_flags(info: Psnd_seq_queue_info_t): cuint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_info_get_flags), 'snd_seq_queue_info_get_flags');
  result := Fsnd_seq_queue_info_get_flags(info)
end { TAsoundSeq.snd_seq_queue_info_get_flags } ;


procedure TAsoundSeq.snd_seq_queue_info_set_name(info: Psnd_seq_queue_info_t; name: PChar); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_info_set_name), 'snd_seq_queue_info_set_name');
  Fsnd_seq_queue_info_set_name(info, name)
end { TAsoundSeq.snd_seq_queue_info_set_name } ;


procedure TAsoundSeq.snd_seq_queue_info_set_owner(info: Psnd_seq_queue_info_t; owner: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_info_set_owner), 'snd_seq_queue_info_set_owner');
  Fsnd_seq_queue_info_set_owner(info, owner)
end { TAsoundSeq.snd_seq_queue_info_set_owner } ;


procedure TAsoundSeq.snd_seq_queue_info_set_locked(info: Psnd_seq_queue_info_t; locked: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_info_set_locked), 'snd_seq_queue_info_set_locked');
  Fsnd_seq_queue_info_set_locked(info, locked)
end { TAsoundSeq.snd_seq_queue_info_set_locked } ;


procedure TAsoundSeq.snd_seq_queue_info_set_flags(info: Psnd_seq_queue_info_t; flags: cuint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_info_set_flags), 'snd_seq_queue_info_set_flags');
  Fsnd_seq_queue_info_set_flags(info, flags)
end { TAsoundSeq.snd_seq_queue_info_set_flags } ;


function TAsoundSeq.snd_seq_create_queue(seq: Psnd_seq_t; info: Psnd_seq_queue_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_create_queue), 'snd_seq_create_queue');
  result := Fsnd_seq_create_queue(seq, info)
end { TAsoundSeq.snd_seq_create_queue } ;


function TAsoundSeq.snd_seq_alloc_named_queue(seq: Psnd_seq_t; name: PChar): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_alloc_named_queue), 'snd_seq_alloc_named_queue');
  result := Fsnd_seq_alloc_named_queue(seq, name)
end { TAsoundSeq.snd_seq_alloc_named_queue } ;


function TAsoundSeq.snd_seq_alloc_queue(handle: Psnd_seq_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_alloc_queue), 'snd_seq_alloc_queue');
  result := Fsnd_seq_alloc_queue(handle)
end { TAsoundSeq.snd_seq_alloc_queue } ;


function TAsoundSeq.snd_seq_free_queue(handle: Psnd_seq_t; q: cint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_free_queue), 'snd_seq_free_queue');
  result := Fsnd_seq_free_queue(handle, q)
end { TAsoundSeq.snd_seq_free_queue } ;


function TAsoundSeq.snd_seq_get_queue_info(seq: Psnd_seq_t; q: cint; info: Psnd_seq_queue_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_get_queue_info), 'snd_seq_get_queue_info');
  result := Fsnd_seq_get_queue_info(seq, q, info)
end { TAsoundSeq.snd_seq_get_queue_info } ;


function TAsoundSeq.snd_seq_set_queue_info(seq: Psnd_seq_t; q: cint; info: Psnd_seq_queue_info_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_set_queue_info), 'snd_seq_set_queue_info');
  result := Fsnd_seq_set_queue_info(seq, q, info)
end { TAsoundSeq.snd_seq_set_queue_info } ;


function TAsoundSeq.snd_seq_query_named_queue(seq: Psnd_seq_t; name: PChar): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_query_named_queue), 'snd_seq_query_named_queue');
  result := Fsnd_seq_query_named_queue(seq, name)
end { TAsoundSeq.snd_seq_query_named_queue } ;


function TAsoundSeq.snd_seq_get_queue_usage(handle: Psnd_seq_t; q: cint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_get_queue_usage), 'snd_seq_get_queue_usage');
  result := Fsnd_seq_get_queue_usage(handle, q)
end { TAsoundSeq.snd_seq_get_queue_usage } ;


function TAsoundSeq.snd_seq_set_queue_usage(handle: Psnd_seq_t; q: cint; used: cint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_set_queue_usage), 'snd_seq_set_queue_usage');
  result := Fsnd_seq_set_queue_usage(handle, q, used)
end { TAsoundSeq.snd_seq_set_queue_usage } ;


function TAsoundSeq.snd_seq_queue_status_sizeof: size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_status_sizeof), 'snd_seq_queue_status_sizeof');
  result := Fsnd_seq_queue_status_sizeof()
end { TAsoundSeq.snd_seq_queue_status_sizeof } ;


function TAsoundSeq.snd_seq_queue_status_malloc(ptr: PPsnd_seq_queue_status_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_status_malloc), 'snd_seq_queue_status_malloc');
  result := Fsnd_seq_queue_status_malloc(ptr)
end { TAsoundSeq.snd_seq_queue_status_malloc } ;


procedure TAsoundSeq.snd_seq_queue_status_free(ptr: Psnd_seq_queue_status_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_status_free), 'snd_seq_queue_status_free');
  Fsnd_seq_queue_status_free(ptr)
end { TAsoundSeq.snd_seq_queue_status_free } ;


procedure TAsoundSeq.snd_seq_queue_status_copy(dst: Psnd_seq_queue_status_t; src: Psnd_seq_queue_status_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_status_copy), 'snd_seq_queue_status_copy');
  Fsnd_seq_queue_status_copy(dst, src)
end { TAsoundSeq.snd_seq_queue_status_copy } ;


function TAsoundSeq.snd_seq_queue_status_get_queue(info: Psnd_seq_queue_status_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_status_get_queue), 'snd_seq_queue_status_get_queue');
  result := Fsnd_seq_queue_status_get_queue(info)
end { TAsoundSeq.snd_seq_queue_status_get_queue } ;


function TAsoundSeq.snd_seq_queue_status_get_events(info: Psnd_seq_queue_status_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_status_get_events), 'snd_seq_queue_status_get_events');
  result := Fsnd_seq_queue_status_get_events(info)
end { TAsoundSeq.snd_seq_queue_status_get_events } ;


function TAsoundSeq.snd_seq_queue_status_get_tick_time(info: Psnd_seq_queue_status_t): snd_seq_tick_time_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_status_get_tick_time), 'snd_seq_queue_status_get_tick_time');
  result := Fsnd_seq_queue_status_get_tick_time(info)
end { TAsoundSeq.snd_seq_queue_status_get_tick_time } ;


function TAsoundSeq.snd_seq_queue_status_get_real_time(info: Psnd_seq_queue_status_t): Psnd_seq_real_time_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_status_get_real_time), 'snd_seq_queue_status_get_real_time');
  result := Fsnd_seq_queue_status_get_real_time(info)
end { TAsoundSeq.snd_seq_queue_status_get_real_time } ;


function TAsoundSeq.snd_seq_queue_status_get_status(info: Psnd_seq_queue_status_t): cuint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_status_get_status), 'snd_seq_queue_status_get_status');
  result := Fsnd_seq_queue_status_get_status(info)
end { TAsoundSeq.snd_seq_queue_status_get_status } ;


function TAsoundSeq.snd_seq_get_queue_status(handle: Psnd_seq_t; q: cint; status: Psnd_seq_queue_status_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_get_queue_status), 'snd_seq_get_queue_status');
  result := Fsnd_seq_get_queue_status(handle, q, status)
end { TAsoundSeq.snd_seq_get_queue_status } ;


function TAsoundSeq.snd_seq_queue_tempo_sizeof: size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_tempo_sizeof), 'snd_seq_queue_tempo_sizeof');
  result := Fsnd_seq_queue_tempo_sizeof()
end { TAsoundSeq.snd_seq_queue_tempo_sizeof } ;


function TAsoundSeq.snd_seq_queue_tempo_malloc(ptr: PPsnd_seq_queue_tempo_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_tempo_malloc), 'snd_seq_queue_tempo_malloc');
  result := Fsnd_seq_queue_tempo_malloc(ptr)
end { TAsoundSeq.snd_seq_queue_tempo_malloc } ;


procedure TAsoundSeq.snd_seq_queue_tempo_free(ptr: Psnd_seq_queue_tempo_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_tempo_free), 'snd_seq_queue_tempo_free');
  Fsnd_seq_queue_tempo_free(ptr)
end { TAsoundSeq.snd_seq_queue_tempo_free } ;


procedure TAsoundSeq.snd_seq_queue_tempo_copy(dst: Psnd_seq_queue_tempo_t; src: Psnd_seq_queue_tempo_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_tempo_copy), 'snd_seq_queue_tempo_copy');
  Fsnd_seq_queue_tempo_copy(dst, src)
end { TAsoundSeq.snd_seq_queue_tempo_copy } ;


function TAsoundSeq.snd_seq_queue_tempo_get_queue(info: Psnd_seq_queue_tempo_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_tempo_get_queue), 'snd_seq_queue_tempo_get_queue');
  result := Fsnd_seq_queue_tempo_get_queue(info)
end { TAsoundSeq.snd_seq_queue_tempo_get_queue } ;


function TAsoundSeq.snd_seq_queue_tempo_get_tempo(info: Psnd_seq_queue_tempo_t): cuint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_tempo_get_tempo), 'snd_seq_queue_tempo_get_tempo');
  result := Fsnd_seq_queue_tempo_get_tempo(info)
end { TAsoundSeq.snd_seq_queue_tempo_get_tempo } ;


function TAsoundSeq.snd_seq_queue_tempo_get_ppq(info: Psnd_seq_queue_tempo_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_tempo_get_ppq), 'snd_seq_queue_tempo_get_ppq');
  result := Fsnd_seq_queue_tempo_get_ppq(info)
end { TAsoundSeq.snd_seq_queue_tempo_get_ppq } ;


function TAsoundSeq.snd_seq_queue_tempo_get_skew(info: Psnd_seq_queue_tempo_t): cuint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_tempo_get_skew), 'snd_seq_queue_tempo_get_skew');
  result := Fsnd_seq_queue_tempo_get_skew(info)
end { TAsoundSeq.snd_seq_queue_tempo_get_skew } ;


function TAsoundSeq.snd_seq_queue_tempo_get_skew_base(info: Psnd_seq_queue_tempo_t): cuint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_tempo_get_skew_base), 'snd_seq_queue_tempo_get_skew_base');
  result := Fsnd_seq_queue_tempo_get_skew_base(info)
end { TAsoundSeq.snd_seq_queue_tempo_get_skew_base } ;


procedure TAsoundSeq.snd_seq_queue_tempo_set_tempo(info: Psnd_seq_queue_tempo_t; tempo: cuint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_tempo_set_tempo), 'snd_seq_queue_tempo_set_tempo');
  Fsnd_seq_queue_tempo_set_tempo(info, tempo)
end { TAsoundSeq.snd_seq_queue_tempo_set_tempo } ;


procedure TAsoundSeq.snd_seq_queue_tempo_set_ppq(info: Psnd_seq_queue_tempo_t; ppq: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_tempo_set_ppq), 'snd_seq_queue_tempo_set_ppq');
  Fsnd_seq_queue_tempo_set_ppq(info, ppq)
end { TAsoundSeq.snd_seq_queue_tempo_set_ppq } ;


procedure TAsoundSeq.snd_seq_queue_tempo_set_skew(info: Psnd_seq_queue_tempo_t; skew: cuint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_tempo_set_skew), 'snd_seq_queue_tempo_set_skew');
  Fsnd_seq_queue_tempo_set_skew(info, skew)
end { TAsoundSeq.snd_seq_queue_tempo_set_skew } ;


procedure TAsoundSeq.snd_seq_queue_tempo_set_skew_base(info: Psnd_seq_queue_tempo_t; base: cuint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_tempo_set_skew_base), 'snd_seq_queue_tempo_set_skew_base');
  Fsnd_seq_queue_tempo_set_skew_base(info, base)
end { TAsoundSeq.snd_seq_queue_tempo_set_skew_base } ;


function TAsoundSeq.snd_seq_get_queue_tempo(handle: Psnd_seq_t; q: cint; tempo: Psnd_seq_queue_tempo_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_get_queue_tempo), 'snd_seq_get_queue_tempo');
  result := Fsnd_seq_get_queue_tempo(handle, q, tempo)
end { TAsoundSeq.snd_seq_get_queue_tempo } ;


function TAsoundSeq.snd_seq_set_queue_tempo(handle: Psnd_seq_t; q: cint; tempo: Psnd_seq_queue_tempo_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_set_queue_tempo), 'snd_seq_set_queue_tempo');
  result := Fsnd_seq_set_queue_tempo(handle, q, tempo)
end { TAsoundSeq.snd_seq_set_queue_tempo } ;


function TAsoundSeq.snd_seq_queue_timer_sizeof: size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_timer_sizeof), 'snd_seq_queue_timer_sizeof');
  result := Fsnd_seq_queue_timer_sizeof()
end { TAsoundSeq.snd_seq_queue_timer_sizeof } ;


function TAsoundSeq.snd_seq_queue_timer_malloc(ptr: PPsnd_seq_queue_timer_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_timer_malloc), 'snd_seq_queue_timer_malloc');
  result := Fsnd_seq_queue_timer_malloc(ptr)
end { TAsoundSeq.snd_seq_queue_timer_malloc } ;


procedure TAsoundSeq.snd_seq_queue_timer_free(ptr: Psnd_seq_queue_timer_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_timer_free), 'snd_seq_queue_timer_free');
  Fsnd_seq_queue_timer_free(ptr)
end { TAsoundSeq.snd_seq_queue_timer_free } ;


procedure TAsoundSeq.snd_seq_queue_timer_copy(dst: Psnd_seq_queue_timer_t; src: Psnd_seq_queue_timer_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_timer_copy), 'snd_seq_queue_timer_copy');
  Fsnd_seq_queue_timer_copy(dst, src)
end { TAsoundSeq.snd_seq_queue_timer_copy } ;


function TAsoundSeq.snd_seq_queue_timer_get_queue(info: Psnd_seq_queue_timer_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_timer_get_queue), 'snd_seq_queue_timer_get_queue');
  result := Fsnd_seq_queue_timer_get_queue(info)
end { TAsoundSeq.snd_seq_queue_timer_get_queue } ;


function TAsoundSeq.snd_seq_queue_timer_get_type(info: Psnd_seq_queue_timer_t): snd_seq_queue_timer_type_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_timer_get_type), 'snd_seq_queue_timer_get_type');
  result := Fsnd_seq_queue_timer_get_type(info)
end { TAsoundSeq.snd_seq_queue_timer_get_type } ;


function TAsoundSeq.snd_seq_queue_timer_get_id(info: Psnd_seq_queue_timer_t): Psnd_timer_id_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_timer_get_id), 'snd_seq_queue_timer_get_id');
  result := Fsnd_seq_queue_timer_get_id(info)
end { TAsoundSeq.snd_seq_queue_timer_get_id } ;


function TAsoundSeq.snd_seq_queue_timer_get_resolution(info: Psnd_seq_queue_timer_t): cuint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_timer_get_resolution), 'snd_seq_queue_timer_get_resolution');
  result := Fsnd_seq_queue_timer_get_resolution(info)
end { TAsoundSeq.snd_seq_queue_timer_get_resolution } ;


procedure TAsoundSeq.snd_seq_queue_timer_set_type(info: Psnd_seq_queue_timer_t; type_: snd_seq_queue_timer_type_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_timer_set_type), 'snd_seq_queue_timer_set_type');
  Fsnd_seq_queue_timer_set_type(info, type_)
end { TAsoundSeq.snd_seq_queue_timer_set_type } ;


procedure TAsoundSeq.snd_seq_queue_timer_set_id(info: Psnd_seq_queue_timer_t; id: Psnd_timer_id_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_timer_set_id), 'snd_seq_queue_timer_set_id');
  Fsnd_seq_queue_timer_set_id(info, id)
end { TAsoundSeq.snd_seq_queue_timer_set_id } ;


procedure TAsoundSeq.snd_seq_queue_timer_set_resolution(info: Psnd_seq_queue_timer_t; resolution: cuint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_queue_timer_set_resolution), 'snd_seq_queue_timer_set_resolution');
  Fsnd_seq_queue_timer_set_resolution(info, resolution)
end { TAsoundSeq.snd_seq_queue_timer_set_resolution } ;


function TAsoundSeq.snd_seq_get_queue_timer(handle: Psnd_seq_t; q: cint; timer: Psnd_seq_queue_timer_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_get_queue_timer), 'snd_seq_get_queue_timer');
  result := Fsnd_seq_get_queue_timer(handle, q, timer)
end { TAsoundSeq.snd_seq_get_queue_timer } ;


function TAsoundSeq.snd_seq_set_queue_timer(handle: Psnd_seq_t; q: cint; timer: Psnd_seq_queue_timer_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_set_queue_timer), 'snd_seq_set_queue_timer');
  result := Fsnd_seq_set_queue_timer(handle, q, timer)
end { TAsoundSeq.snd_seq_set_queue_timer } ;


function TAsoundSeq.snd_seq_free_event(ev: Psnd_seq_event_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_free_event), 'snd_seq_free_event');
  result := Fsnd_seq_free_event(ev)
end { TAsoundSeq.snd_seq_free_event } ;


function TAsoundSeq.snd_seq_event_length(ev: Psnd_seq_event_t): ssize_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_event_length), 'snd_seq_event_length');
  result := Fsnd_seq_event_length(ev)
end { TAsoundSeq.snd_seq_event_length } ;


function TAsoundSeq.snd_seq_event_output(handle: Psnd_seq_t; ev: Psnd_seq_event_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_event_output), 'snd_seq_event_output');
  result := Fsnd_seq_event_output(handle, ev)
end { TAsoundSeq.snd_seq_event_output } ;


function TAsoundSeq.snd_seq_event_output_buffer(handle: Psnd_seq_t; ev: Psnd_seq_event_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_event_output_buffer), 'snd_seq_event_output_buffer');
  result := Fsnd_seq_event_output_buffer(handle, ev)
end { TAsoundSeq.snd_seq_event_output_buffer } ;


function TAsoundSeq.snd_seq_event_output_direct(handle: Psnd_seq_t; ev: Psnd_seq_event_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_event_output_direct), 'snd_seq_event_output_direct');
  result := Fsnd_seq_event_output_direct(handle, ev)
end { TAsoundSeq.snd_seq_event_output_direct } ;


function TAsoundSeq.snd_seq_event_input(handle: Psnd_seq_t; ev: PPsnd_seq_event_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_event_input), 'snd_seq_event_input');
  result := Fsnd_seq_event_input(handle, ev)
end { TAsoundSeq.snd_seq_event_input } ;


function TAsoundSeq.snd_seq_event_input_pending(seq: Psnd_seq_t; fetch_sequencer: cint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_event_input_pending), 'snd_seq_event_input_pending');
  result := Fsnd_seq_event_input_pending(seq, fetch_sequencer)
end { TAsoundSeq.snd_seq_event_input_pending } ;


function TAsoundSeq.snd_seq_drain_output(handle: Psnd_seq_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_drain_output), 'snd_seq_drain_output');
  result := Fsnd_seq_drain_output(handle)
end { TAsoundSeq.snd_seq_drain_output } ;


function TAsoundSeq.snd_seq_event_output_pending(seq: Psnd_seq_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_event_output_pending), 'snd_seq_event_output_pending');
  result := Fsnd_seq_event_output_pending(seq)
end { TAsoundSeq.snd_seq_event_output_pending } ;


function TAsoundSeq.snd_seq_extract_output(handle: Psnd_seq_t; ev: PPsnd_seq_event_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_extract_output), 'snd_seq_extract_output');
  result := Fsnd_seq_extract_output(handle, ev)
end { TAsoundSeq.snd_seq_extract_output } ;


function TAsoundSeq.snd_seq_drop_output(handle: Psnd_seq_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_drop_output), 'snd_seq_drop_output');
  result := Fsnd_seq_drop_output(handle)
end { TAsoundSeq.snd_seq_drop_output } ;


function TAsoundSeq.snd_seq_drop_output_buffer(handle: Psnd_seq_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_drop_output_buffer), 'snd_seq_drop_output_buffer');
  result := Fsnd_seq_drop_output_buffer(handle)
end { TAsoundSeq.snd_seq_drop_output_buffer } ;


function TAsoundSeq.snd_seq_drop_input(handle: Psnd_seq_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_drop_input), 'snd_seq_drop_input');
  result := Fsnd_seq_drop_input(handle)
end { TAsoundSeq.snd_seq_drop_input } ;


function TAsoundSeq.snd_seq_drop_input_buffer(handle: Psnd_seq_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_drop_input_buffer), 'snd_seq_drop_input_buffer');
  result := Fsnd_seq_drop_input_buffer(handle)
end { TAsoundSeq.snd_seq_drop_input_buffer } ;


function TAsoundSeq.snd_seq_remove_events_sizeof: size_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_sizeof), 'snd_seq_remove_events_sizeof');
  result := Fsnd_seq_remove_events_sizeof()
end { TAsoundSeq.snd_seq_remove_events_sizeof } ;


function TAsoundSeq.snd_seq_remove_events_malloc(ptr: PPsnd_seq_remove_events_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_malloc), 'snd_seq_remove_events_malloc');
  result := Fsnd_seq_remove_events_malloc(ptr)
end { TAsoundSeq.snd_seq_remove_events_malloc } ;


procedure TAsoundSeq.snd_seq_remove_events_free(ptr: Psnd_seq_remove_events_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_free), 'snd_seq_remove_events_free');
  Fsnd_seq_remove_events_free(ptr)
end { TAsoundSeq.snd_seq_remove_events_free } ;


procedure TAsoundSeq.snd_seq_remove_events_copy(dst: Psnd_seq_remove_events_t; src: Psnd_seq_remove_events_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_copy), 'snd_seq_remove_events_copy');
  Fsnd_seq_remove_events_copy(dst, src)
end { TAsoundSeq.snd_seq_remove_events_copy } ;


function TAsoundSeq.snd_seq_remove_events_get_condition(info: Psnd_seq_remove_events_t): cuint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_get_condition), 'snd_seq_remove_events_get_condition');
  result := Fsnd_seq_remove_events_get_condition(info)
end { TAsoundSeq.snd_seq_remove_events_get_condition } ;


function TAsoundSeq.snd_seq_remove_events_get_queue(info: Psnd_seq_remove_events_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_get_queue), 'snd_seq_remove_events_get_queue');
  result := Fsnd_seq_remove_events_get_queue(info)
end { TAsoundSeq.snd_seq_remove_events_get_queue } ;


function TAsoundSeq.snd_seq_remove_events_get_time(info: Psnd_seq_remove_events_t): Psnd_seq_timestamp_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_get_time), 'snd_seq_remove_events_get_time');
  result := Fsnd_seq_remove_events_get_time(info)
end { TAsoundSeq.snd_seq_remove_events_get_time } ;


function TAsoundSeq.snd_seq_remove_events_get_dest(info: Psnd_seq_remove_events_t): Psnd_seq_addr_t; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_get_dest), 'snd_seq_remove_events_get_dest');
  result := Fsnd_seq_remove_events_get_dest(info)
end { TAsoundSeq.snd_seq_remove_events_get_dest } ;


function TAsoundSeq.snd_seq_remove_events_get_channel(info: Psnd_seq_remove_events_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_get_channel), 'snd_seq_remove_events_get_channel');
  result := Fsnd_seq_remove_events_get_channel(info)
end { TAsoundSeq.snd_seq_remove_events_get_channel } ;


function TAsoundSeq.snd_seq_remove_events_get_event_type(info: Psnd_seq_remove_events_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_get_event_type), 'snd_seq_remove_events_get_event_type');
  result := Fsnd_seq_remove_events_get_event_type(info)
end { TAsoundSeq.snd_seq_remove_events_get_event_type } ;


function TAsoundSeq.snd_seq_remove_events_get_tag(info: Psnd_seq_remove_events_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_get_tag), 'snd_seq_remove_events_get_tag');
  result := Fsnd_seq_remove_events_get_tag(info)
end { TAsoundSeq.snd_seq_remove_events_get_tag } ;


procedure TAsoundSeq.snd_seq_remove_events_set_condition(info: Psnd_seq_remove_events_t; flags: cuint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_set_condition), 'snd_seq_remove_events_set_condition');
  Fsnd_seq_remove_events_set_condition(info, flags)
end { TAsoundSeq.snd_seq_remove_events_set_condition } ;


procedure TAsoundSeq.snd_seq_remove_events_set_queue(info: Psnd_seq_remove_events_t; queue: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_set_queue), 'snd_seq_remove_events_set_queue');
  Fsnd_seq_remove_events_set_queue(info, queue)
end { TAsoundSeq.snd_seq_remove_events_set_queue } ;


procedure TAsoundSeq.snd_seq_remove_events_set_time(info: Psnd_seq_remove_events_t; time: Psnd_seq_timestamp_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_set_time), 'snd_seq_remove_events_set_time');
  Fsnd_seq_remove_events_set_time(info, time)
end { TAsoundSeq.snd_seq_remove_events_set_time } ;


procedure TAsoundSeq.snd_seq_remove_events_set_dest(info: Psnd_seq_remove_events_t; addr: Psnd_seq_addr_t); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_set_dest), 'snd_seq_remove_events_set_dest');
  Fsnd_seq_remove_events_set_dest(info, addr)
end { TAsoundSeq.snd_seq_remove_events_set_dest } ;


procedure TAsoundSeq.snd_seq_remove_events_set_channel(info: Psnd_seq_remove_events_t; channel: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_set_channel), 'snd_seq_remove_events_set_channel');
  Fsnd_seq_remove_events_set_channel(info, channel)
end { TAsoundSeq.snd_seq_remove_events_set_channel } ;


procedure TAsoundSeq.snd_seq_remove_events_set_event_type(info: Psnd_seq_remove_events_t; type_: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_set_event_type), 'snd_seq_remove_events_set_event_type');
  Fsnd_seq_remove_events_set_event_type(info, type_)
end { TAsoundSeq.snd_seq_remove_events_set_event_type } ;


procedure TAsoundSeq.snd_seq_remove_events_set_tag(info: Psnd_seq_remove_events_t; tag: cint); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events_set_tag), 'snd_seq_remove_events_set_tag');
  Fsnd_seq_remove_events_set_tag(info, tag)
end { TAsoundSeq.snd_seq_remove_events_set_tag } ;


function TAsoundSeq.snd_seq_remove_events(handle: Psnd_seq_t; info: Psnd_seq_remove_events_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_remove_events), 'snd_seq_remove_events');
  result := Fsnd_seq_remove_events(handle, info)
end { TAsoundSeq.snd_seq_remove_events } ;


procedure TAsoundSeq.snd_seq_set_bit(nr: cint; array_: Pointer); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_set_bit), 'snd_seq_set_bit');
  Fsnd_seq_set_bit(nr, array_)
end { TAsoundSeq.snd_seq_set_bit } ;


procedure TAsoundSeq.snd_seq_unset_bit(nr: cint; array_: Pointer); cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_unset_bit), 'snd_seq_unset_bit');
  Fsnd_seq_unset_bit(nr, array_)
end { TAsoundSeq.snd_seq_unset_bit } ;


function TAsoundSeq.snd_seq_change_bit(nr: cint; array_: Pointer): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_change_bit), 'snd_seq_change_bit');
  result := Fsnd_seq_change_bit(nr, array_)
end { TAsoundSeq.snd_seq_change_bit } ;


function TAsoundSeq.snd_seq_get_bit(nr: cint; array_: Pointer): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_get_bit), 'snd_seq_get_bit');
  result := Fsnd_seq_get_bit(nr, array_)
end { TAsoundSeq.snd_seq_get_bit } ;


function TAsoundSeq.snd_seq_create_simple_port(seq: Psnd_seq_t; name: PChar; caps, type_: cuint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_create_simple_port), 'snd_seq_create_simple_port');
  result := Fsnd_seq_create_simple_port(seq, name, caps, type_)
end { TAsoundSeq.snd_seq_create_simple_port } ;


function TAsoundSeq.snd_seq_delete_simple_port(seq: Psnd_seq_t; port: cint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_delete_simple_port), 'snd_seq_delete_simple_port');
  result := Fsnd_seq_delete_simple_port(seq, port)
end { TAsoundSeq.snd_seq_delete_simple_port } ;


function TAsoundSeq.snd_seq_connect_from(seq: Psnd_seq_t; my_port, src_client, src_port: cint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_connect_from), 'snd_seq_connect_from');
  result := Fsnd_seq_connect_from(seq, my_port, src_client, src_port)
end { TAsoundSeq.snd_seq_connect_from } ;


function TAsoundSeq.snd_seq_connect_to(seq: Psnd_seq_t; my_port, dest_client, dest_port: cint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_connect_to), 'snd_seq_connect_to');
  result := Fsnd_seq_connect_to(seq, my_port, dest_client, dest_port)
end { TAsoundSeq.snd_seq_connect_to } ;


function TAsoundSeq.snd_seq_disconnect_from(seq: Psnd_seq_t; my_port, src_client, src_port: cint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_disconnect_from), 'snd_seq_disconnect_from');
  result := Fsnd_seq_disconnect_from(seq, my_port, src_client, src_port)
end { TAsoundSeq.snd_seq_disconnect_from } ;


function TAsoundSeq.snd_seq_disconnect_to(seq: Psnd_seq_t; my_port, dest_client, dest_port: cint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_disconnect_to), 'snd_seq_disconnect_to');
  result := Fsnd_seq_disconnect_to(seq, my_port, dest_client, dest_port)
end { TAsoundSeq.snd_seq_disconnect_to } ;


function TAsoundSeq.snd_seq_set_client_name(seq: Psnd_seq_t; name: PChar): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_set_client_name), 'snd_seq_set_client_name');
  result := Fsnd_seq_set_client_name(seq, name)
end { TAsoundSeq.snd_seq_set_client_name } ;


function TAsoundSeq.snd_seq_set_client_event_filter(seq: Psnd_seq_t; event_type: cint): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_set_client_event_filter), 'snd_seq_set_client_event_filter');
  result := Fsnd_seq_set_client_event_filter(seq, event_type)
end { TAsoundSeq.snd_seq_set_client_event_filter } ;


function TAsoundSeq.snd_seq_set_client_pool_output(seq: Psnd_seq_t; size: size_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_set_client_pool_output), 'snd_seq_set_client_pool_output');
  result := Fsnd_seq_set_client_pool_output(seq, size)
end { TAsoundSeq.snd_seq_set_client_pool_output } ;


function TAsoundSeq.snd_seq_set_client_pool_output_room(seq: Psnd_seq_t; size: size_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_set_client_pool_output_room), 'snd_seq_set_client_pool_output_room');
  result := Fsnd_seq_set_client_pool_output_room(seq, size)
end { TAsoundSeq.snd_seq_set_client_pool_output_room } ;


function TAsoundSeq.snd_seq_set_client_pool_input(seq: Psnd_seq_t; size: size_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_set_client_pool_input), 'snd_seq_set_client_pool_input');
  result := Fsnd_seq_set_client_pool_input(seq, size)
end { TAsoundSeq.snd_seq_set_client_pool_input } ;


function TAsoundSeq.snd_seq_sync_output_queue(seq: Psnd_seq_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_sync_output_queue), 'snd_seq_sync_output_queue');
  result := Fsnd_seq_sync_output_queue(seq)
end { TAsoundSeq.snd_seq_sync_output_queue } ;


function TAsoundSeq.snd_seq_parse_address(seq: Psnd_seq_t; addr: Psnd_seq_addr_t; str: PChar): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_parse_address), 'snd_seq_parse_address');
  result := Fsnd_seq_parse_address(seq, addr, str)
end { TAsoundSeq.snd_seq_parse_address } ;


function TAsoundSeq.snd_seq_reset_pool_output(seq: Psnd_seq_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_reset_pool_output), 'snd_seq_reset_pool_output');
  result := Fsnd_seq_reset_pool_output(seq)
end { TAsoundSeq.snd_seq_reset_pool_output } ;


function TAsoundSeq.snd_seq_reset_pool_input(seq: Psnd_seq_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_reset_pool_input), 'snd_seq_reset_pool_input');
  result := Fsnd_seq_reset_pool_input(seq)
end { TAsoundSeq.snd_seq_reset_pool_input } ;


function TAsoundSeq.snd_seq_control_queue(seq: Psnd_seq_t; q, type_, value: cint; ev: Psnd_seq_event_t): cint; cdecl;

begin
  LoadRoutine(pointer(Fsnd_seq_control_queue), 'snd_seq_control_queue');
  result := Fsnd_seq_control_queue(seq, q, type_, value, ev)
end { TAsoundSeq.snd_seq_control_queue } ;


function TAsoundSeq.snd_strerror(errnum: cint): PChar; cdecl;

begin
  LoadRoutine(pointer(Fsnd_strerror), 'snd_strerror');
  result := Fsnd_strerror(errnum)
end { TAsoundSeq.snd_strerror } ;


(* Procedures and functions which are defined locally rather than being part of *)
(* the external library, and which in C would often be implemented as macros,   *)
(* are defined in this file to protect them from being overwritten.             *)

{$define CLSASOUND__:= TAsoundSeq. }
{$i AsoundSeq-macros.inc }


(*************************************************************************** DB *)


(* Return either a static or a dynamic representation of the Asound embedding
  library (libasound.so or similar). In this case it is dynamic.
*)
function AsoundSeq(): TAsoundSeq; inline;

begin
  if not Assigned(xAsoundSeq) then
    InitialiseLibrary;
  result := xAsoundSeq
end { AsoundSeq } ;


(* Create the object and optionally load the shared object library.
*)
procedure InitialiseLibrary(const moduleName: string= DefaultModuleName;
                                        earlyLoad: boolean= DefaultEarlyLoad);

begin
  if not Assigned(xAsoundSeq) then begin
    xAsoundSeq := TAsoundSeq.Create(moduleName);
    if Assigned(xAsoundSeq) and earlyLoad then
      xAsoundSeq.LoadModule            (* So that ModuleInMemory is correct     *)
  end
end { InitialiseLibrary } ;


(* Create the object and optionally load the shared object library.
*)
procedure InitializeLibrary(const moduleName: string= DefaultModuleName;
                                        earlyLoad: boolean= DefaultEarlyLoad);

begin
  InitialiseLibrary(moduleName, earlyLoad)
end { InitializeLibrary } ;


initialization
//  InitialiseLibrary
finalization
  FreeAndNil(xAsoundSeq)
end.
