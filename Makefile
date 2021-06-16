.PHONY: all
all:
	$(MAKE) -C src


.PHONY: builder
builder:
	docker build -t lthn/build -f build-conf/build.Dockerfile src

.PHONY: chain.linux
chain.linux:
	docker build -t lthn/build:chain-linux -f build-conf/chain/linux.Dockerfile src
