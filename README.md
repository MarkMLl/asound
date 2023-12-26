# asound
Minimal interface for Pascal with static and dynamic linkage, coded with
reference to fpalsa etc.

This provides as much functionality as I currently need for emitting warning
or acknowledgement "jingles" via a sound card and amplifier using either PCM
or a MIDI sequencer device.

As of late 2023 it has a fairly complete interface for the ALSA sequencer API, i.e. MIDI.

It is intended to be lightweight, and to support dynamic linkage for cases
where ALSA is unavailable at runtime. As much documentation as possible has
been transcribed in a form which the Lazarus IDE will pick it up as hints.

The reader is advised to have Lazarus's project groups addon, and to start with examples/BeepDemoCode noting that this imports AlsaPcmDemo and AlsaSeqDemo.

AlsaPcmDemo imports either AsoundPcm or AsoundPcm_dynamic, with the code
being otherwise unchanged.

AlsaSeqDemo imports a crude parser from WatchXyzMidi. WatchXyzMidi imports
either AsoundSeq or AsoundSeq_dynamic, with the code being otherwise unchanged.

There is definite scope for improvement in the area of MIDI note sequencing, which suffers from being a hasty transcript of some much older stuff. However as it stands it is sufficient for the author's requirement, and avoids a substantial amount of overhead inherent in other libraries.

At a lower level there is extra complexity, mostly hidden in include files,
which results in the API being presented either as a statically-linked unit or
as an object which conceals dynamic linkage. Conveniently, Pascal allows an
application program to use identical calling syntax in both cases.
