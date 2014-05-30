#
#
#

all package upload test test-chibi test-chicken test-foment test-gauche test-sagittarius clean:
	(cd seth && make $@)
	(cd snow && make $@)
