# Makefile for debian packaging

ifndef CHECK
export CHECK = yes
all: build-dep debian
else
all: debian
endif

clean:
	./build-clean.sh
	touch build-stamp

build-dep:
	./build-dep.sh
	$(MAKE)

repository: debian
	./build-repository.sh

upload: debian
	./build-upload.sh
	./build-status.sh

deploy: debian
	./build-deploy.sh

status:
	./build-status.sh

trunk:
	./build-trunk.sh

branch:
	./build-branch.sh

fix:
	./build-fix.sh

fresh:
	./build-fresh.sh
	./build-status.sh

help:
	./build-help.sh

debian:	build-stamp-debian

build-stamp-debian: build-stamp
	./build-debian.sh
	touch build-stamp-debian
	./build-status.sh

.PHONY: clean build-dep debian repository
