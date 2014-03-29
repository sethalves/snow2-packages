#
#
#

REPONAMEX=$(shell dirname $$PWD)
REPONAME=$(shell basename $(REPONAMEX))


# PKG=`basename $$PWD`
PKG=$(shell basename $$PWD)

all: dist

clean:
	rm -f *~ */*~ ../$(PKG).tgz
	(cd test && make clean)

package: clean
	tar --exclude-vcs --exclude test \
		--exclude $(PKG).package \
		--exclude notes --exclude Makefile \
		-C .. \
		--transform "s/^$(PKG)/$(REPONAME)/" \
		-zcvf ../$(PKG).tgz $(PKG)

dist: package
	@ echo "UPLOADING --" $(PKG)
	(cd .. && ../upload-to-repo $(REPONAME) $(PKG).tgz)

# rsync ../$(PKG).tgz $(REPO)

