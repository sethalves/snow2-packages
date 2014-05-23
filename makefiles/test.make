#
#
#

# snow2=~/src/snow2/snow2-client/snow2-client-chibi.scm
snow2=/usr/local/bin/snow2

# PACKAGEDIR=$(shell dirname $$PWD)
# PACKAGENAME=$(shell basename $(PACKAGEDIR))
# REPODIR=$(shell dirname $(PACKAGEDIR))
# REPONAME=$(shell basename $(REPODIR))

REPOS=-r ../../../snow -r ../../../seth -r ../../../../r7rs-srfis

all:

link-deps:
	snow2 -s $(REPOS) install $(TEST_DEPS)

install-deps:
	snow2 $(REPOS) install $(TEST_DEPS)

download-deps:
	snow2 install $(TEST_DEPS)

test: link-deps
	./test-chicken.scm
	@echo
	./test-chibi.scm
	@echo
	./test-gauche.scm
	@echo
	./test-sagittarius.scm
	@echo

clean:
	rm -f *~
#	for DEP in $(DEPS) ; do \
#		$(snow2) uninstall $(TEST_DEPS); \
#	done
	rm -rf seth snow srfi
	make clean-extra
