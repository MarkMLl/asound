# Create .static and .dynamic files for a plugin filter (the former nor being
# used), and copy or rename them to .pas and _dynamic.pas for static and
# dynamic loading.                                              MarkMLl.

all: plugin Makefile

plugin: plugin.inc Makefile
	defToSDUnits plugin.inc libfilter_demo
	mv plugin.static plugin.pas
	mv plugin.dynamic plugin_dynamic.pas
	echo ''

# Note that files such as plugin-macros.inc are manually-created and must not
# be overwritten or deleted.

clean:
	rm -f *.static *.dynamic *.OLD *~

distclean: clean
	rm -f plugin.pas plugin_dynamic.pas

# NOTE: For static linkage without installing the .so library this might
# require  LD_LIBRARY_PATH=./plugin  or similar. During testing, something
# like  Run -> Run Parameter -> Environment  etc.


