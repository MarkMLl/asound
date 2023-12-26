# Create .static and .dynamic files for ALSA Pcm and Seq (MIDI),
# and copy or rename them to .pas and _dynamic.pas for static and
# dynamic loading. MarkMLl.

all: Asound AsoundPcm AsoundSeq Makefile

Asound: AsoundDefs.inc
	defToSDUnits AsoundDefs.inc libasound
	mv AsoundDefs.static asound.pas
	mv AsoundDefs.dynamic asound_dynamic.pas
	echo ''

AsoundPcm: AsoundDefs.inc AsoundPcmDefs.inc
	defToSDUnits AsoundPcmDefs.inc libasound
	mv AsoundPcmDefs.static asoundpcm.pas
	mv AsoundPcmDefs.dynamic asoundpcm_dynamic.pas
	echo ''

AsoundSeq: AsoundDefs.inc AsoundSeqDefs.inc 
	defToSDUnits AsoundSeqDefs.inc libasound
	mv AsoundSeqDefs.static asoundseq.pas
	mv AsoundSeqDefs.dynamic asoundseq_dynamic.pas
	echo ''

# Note that files such as AsoundSeq-macros.inc are
# manually-created and must not be overwritten or deleted.

clean:
	rm -f *.static *.dynamic *.OLD *~

distclean: clean
	rm -f asound.pas asound_dynamic.pas
	rm -f asoundpcm.pas asoundpcm_dynamic.pas 
	rm -f asoundseq.pas asoundseq_dynamic.pas

