.PHONY: all
all:
	$(MAKE) -C build-src


.PHONY: build
build:
	docker build -t lthn/build -f build-conf/build.Dockerfile build-src

.PHONY: chain-linux
chain-linux:
	docker build -t lthn/build:chain-linux -f build-conf/chain/linux.Dockerfile build-src

.PHONY: base-ubuntu
base-ubuntu: base-ubuntu-16.04 base-ubuntu-18.04 base-ubuntu-20.04
	echo "made base-ubuntu-16.04, base-ubuntu-18.04 base-ubuntu-20.04" && \
 	docker tag lthn/build:base-ubuntu-20.04 lthn/build:base-ubuntu

.PHONY: base-ubuntu-16.04
base-ubuntu-16.04:
	docker build -t lthn/build:base-ubuntu-16.04 --build-arg UBUNTU_VERSION=16.04 -f build-conf/base/ubuntu.Dockerfile build-src

.PHONY: base-ubuntu-18.04
base-ubuntu-18.04:
	docker build -t lthn/build:base-ubuntu-18.04 --build-arg UBUNTU_VERSION=18.04 -f build-conf/base/ubuntu.Dockerfile build-src

.PHONY: base-ubuntu-20.04
base-ubuntu-20.04:
	docker build -t lthn/build:base-ubuntu-20.04 --build-arg UBUNTU_VERSION=20.04 -f build-conf/base/ubuntu.Dockerfile build-src
