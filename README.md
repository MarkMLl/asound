# asound
Minimal interface for Pascal with static and dynamic linkage, coded with
reference to fpalsa etc.

This provides as much functionality as I currently need for emitting warning
or acknowledgement "jingles" via a sound card and amplifier using either PCM
or a MIDI sequencer device.

It is intended to be lightweight, and to support dynamic linkage for cases
where ALSA is unavailable at runtime. As much documentation as possible has
been transcribed in a form which the Lazarus IDE will pick it up as hints.
