#
#
#

all:

package:
	snow2 -r . -r ../seth -r ../../r7rs-srfis package

upload: package
	snow2 upload

clean:
	rm -f *~ */*~ */*/*~ */*/*/*~
	rm -f *.tgz
	ls tests | while read I ; do \
		(cd tests/$$I && make clean) \
	done
