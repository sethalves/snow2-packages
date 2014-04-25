#
#
#

all:

package: index
	snow2 -r . package packages/*.package

upload:
	snow2 -r . s3-upload packages/*.package

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
