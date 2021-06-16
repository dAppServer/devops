.PHONY: all
all:
	$(MAKE) -C build-src


.PHONY: build
build:
	docker build -t lthn/build -f build-conf/build.Dockerfile build-src

.PHONY: chain.linux
chain.linux:
	docker build -t lthn/build:chain-linux -f build-conf/chain/linux.Dockerfile build-src

.PHONY: base.ubuntu
base.ubuntu:
	docker build -t lthn/build:base-ubuntu -f build-conf/base/ubuntu.Dockerfile build-src
