#
#
#

all:

package: index
	ls packages | while read I ; do \
		snow2 -s -r . package packages/$$I; \
	done


upload: package
	ls packages | while read I ; do \
		snow2 -s -r . upload packages/$$I; \
	done


clean:
	rm -f *~ */*~ */*/*~ */*/*/*~
	rm -f *.tgz
	ls tests | while read I ; do \
		(cd tests/$$I && make clean) \
	done


index:
	rm -f index.scm
	echo '(repository' >> index.scm
	echo '  (sibling' >> index.scm
	echo '    (name "Seth Repository")' >> index.scm
	echo '    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/")' >> index.scm
	echo '    (trust 1.0))' >> index.scm
	cat packages/*.package >> index.scm
	echo ')'  >> index.scm
