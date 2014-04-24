#
#
#

all:

package: seth-package snow-package

dist: seth-dist snow-dist

clean: seth-clean snow-clean

#####################################

# SETH_PACKAGES=$(shell \
# ls seth/packages | while read I; \
# do \
# 	echo `basename $$I .package` \
# done)

seth-all:
#	for PKG in $(SETH_PACKAGES) ; do \
#		(cd seth/$$PKG && make all); \
#	done


seth-package: seth-index


#	for PKG in $(SETH_PACKAGES) ; do \
#		(cd seth/$$PKG && make package); \
#	done


seth-dist: seth-index

#	for PKG in $(SETH_PACKAGES) ; do \
#		(cd seth/$$PKG && make dist); \
#	done
#	(cd seth && ../upload-to-repo seth index.scm)


seth-clean:
	rm -f *~ */*~ */*/*~ */*/*/*~
	ls seth/tests | while read I ; do \
		(cd seth/tests/$$I && make clean) \
	done

#	for PKG in $(SETH_PACKAGES) ; do \
#		(cd seth/$$PKG && make clean); \
#	done


seth-index:
	rm -f seth/index.scm
	echo '(repository' >> seth/index.scm; \
	echo '  (sibling' >> seth/index.scm; \
	echo '    (name "Seth Repository")' >> seth/index.scm; \
	echo '    (url "http://snow-repository.s3-website-us-east-1.amazonaws.com/")' >> seth/index.scm; \
	echo '    (trust 1.0))' >> seth/index.scm; \
	cat seth/packages/*.package >> seth/index.scm
	echo ')'  >> seth/index.scm



#####################################


SNOW_PACKAGES=$(shell \
ls snow | while read I; \
do \
	if [ -f snow/$$I/$$I.sld ]; \
	then \
		echo $$I; \
	fi; \
done)

snow-all:
	for PKG in $(SNOW_PACKAGES) ; do \
		(cd snow/$$PKG && make all); \
	done


snow-package: snow-index
	for PKG in $(SNOW_PACKAGES) ; do \
		(cd snow/$$PKG && make package); \
	done


snow-dist: snow-index
	for PKG in $(SNOW_PACKAGES) ; do \
		(cd snow/$$PKG && make dist); \
	done
	(cd snow && ../upload-to-repo snow index.scm)


snow-clean:
	rm -f *~ */*~
	for PKG in $(SNOW_PACKAGES) ; do \
		(cd snow/$$PKG && make clean); \
	done



snow-index:
	rm -f snow/index.scm
	echo '(repository'  >> snow/index.scm; \
	for PKG in $(SNOW_PACKAGES) ; do \
		cat snow/$$PKG/$$PKG.package >> snow/index.scm; \
	done; \
	echo ')'  >> snow/index.scm


#####################################


test-chicken:
	for PKG in $(SETH_PACKAGES) ; do \
		(cd seth/$$PKG/test && make link-deps); \
	done
	for PKG in $(SETH_PACKAGES) ; do \
		echo -n $$PKG " "; \
		(cd seth/$$PKG/test && ./test-chicken.scm); \
	done
	for PKG in $(SNOW_PACKAGES) ; do \
		(cd snow/$$PKG/test && make link-deps); \
	done
	for PKG in $(SNOW_PACKAGES) ; do \
		echo -n $$PKG " "; \
		(cd snow/$$PKG/test && ./test-chicken.scm); \
	done
