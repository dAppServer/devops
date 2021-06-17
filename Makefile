.PHONY: all
all:
	$(MAKE) -C build-src


.PHONY: build
build:
	docker build -t lthn/build -f build-conf/build.Dockerfile build-src


.PHONY: tool-gcc
tool-gcc:
	docker build -t lthn/build:tool-gcc -f build-conf/tool/gcc.Dockerfile build-src


.PHONY: lthn-chain-linux
lthn-chain-linux:
	docker build -t lthn/build:lthn-chain-linux -f build-conf/lthn/chain/linux.Dockerfile build-src

.PHONY: base-ubuntu
base-ubuntu: base-ubuntu-16.04 base-ubuntu-18.04 base-ubuntu-20.04
	echo "made base-ubuntu-16.04, base-ubuntu-18.04 base-ubuntu-20.04" && \
 	docker tag lthn/build:base-ubuntu-20.04 lthn/build:base-ubuntu

.PHONY: base-ubuntu-16-04
base-ubuntu-16-04:
	docker build -t lthn/build:base-ubuntu-16-04 -f build-conf/base/ubuntu/16-04.Dockerfile build-src

.PHONY: base-ubuntu-18-04
base-ubuntu-18-04:
	docker build -t lthn/build:base-ubuntu-18-04 -f build-conf/base/ubuntu/18-04.Dockerfile build-src

.PHONY: base-ubuntu-20-04
base-ubuntu-20-04:
	docker build -t lthn/build:base-ubuntu-20-04 -f build-conf/base/ubuntu/20-04.Dockerfile build-src

.PHONY: base-ubuntu-16.04-test
base-ubuntu-16.04-test:
	docker build --no-cache -t lthn/build:base-ubuntu-16.04-test -f build-test/base-image/ubuntu.Dockerfile build-src
