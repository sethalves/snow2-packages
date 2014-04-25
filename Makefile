#
#
#

all:
	(cd seth && make $@)
	(cd snow && make $@)

package:
	(cd seth && make $@)
	(cd snow && make $@)

upload:
	(cd seth && make $@)
	(cd snow && make $@)


clean:
	(cd seth && make $@)
	(cd snow && make $@)
