#
#
#

# snow2=~/src/snow2/snow2-client/snow2-client-chibi.scm
snow2=/usr/local/bin/snow2

# PACKAGEDIR=$(shell dirname $$PWD)
# PACKAGENAME=$(shell basename $(PACKAGEDIR))
# REPODIR=$(shell dirname $(PACKAGEDIR))
# REPONAME=$(shell basename $(REPODIR))

REPOS=-r ../../../snow -r ../../../seth

all:

link-deps:
	snow2 -s $(REPOS) install $(TEST_DEPS)

install-deps:
	snow2 $(REPOS) install $(TEST_DEPS)

download-deps:
	snow2 install $(TEST_DEPS)

test: link-deps
	./test-chicken.scm
	./test-chibi.scm
	./test-gauche.scm
	./test-sash.scm

clean:
	rm -f *~
#	for DEP in $(DEPS) ; do \
#		$(snow2) uninstall $(TEST_DEPS); \
#	done
	rm -rf seth snow
	make clean-extra