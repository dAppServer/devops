.PHONY: all help clean build tool-gcc lthn-chain-linux lthn-wallet-linux shrink-chain-build
.PHONY: base-ubuntu base-ubuntu-16.04 base-ubuntu-18.04 base-ubuntu-20.04
.ONESHELL: shrink-chain-build base-ubuntu
all: help

clean: ## Docker System Prune
	docker system prune --all

build: ## Builds lthn/build
	docker build --no-cache -t lthn/build -f build-conf/build.Dockerfile build-src

tool-gcc: ## Builds lthn/build:tool-gcc
	docker build --no-cache -t lthn/build:tool-gcc -f build-conf/tool/gcc/build.Dockerfile build-src

lthn-chain-linux: ## Builds lthn/build:lthn-chain-linux
	docker build --no-cache -t lthn/build:lthn-chain-linux -f build-conf/lthn/chain/linux.Dockerfile build-src

lthn-chain-linux-shrink: ## Builds a optimised build image
	docker run --rm -v /var/run/docker.sock:/var/run/docker.sock dslim/docker-slim build \
			--continue-after "exec" --http-probe-off --pull --target "lthn/build:lthn-chain-linux" \
			--exec "git clone https://gitlab.com/lthn.io/projects/chain/lethean.git && cd lethean && make -j4 release-static && cd .. && rm -rf lethean" \
			--show-plogs --show-clogs --show-blogs --tag "lthn/build:lthn-chain-linux" \
			--include-path "/usr/share/cmake-3.5"

lthn-chain-linux-shrink-ci: ## Gitlab task
	docker run -e DOCKER_HOST=tcp://docker:2375 dslim/docker-slim build \
			--continue-after "exec" --http-probe-off --pull --target "lthn/build:lthn-chain-linux-full" \
			--exec "git clone https://gitlab.com/lthn.io/projects/chain/lethean.git && cd lethean && make -j4 release-static && cd .. && rm -rf lethean" \
			--tag "lthn/build:lthn-chain-linux" --include-path "/usr/share/cmake-3.5"

lthn-wallet-linux: ## Builds lthn/build:lthn-wallet-linux
	docker build --no-cache -t lthn/build:lthn-wallet-linux -f build-conf/lthn/wallet/linux.Dockerfile build-src



base-ubuntu: base-ubuntu-20.04 ## Builds lthn/build:base-ubuntu (20.04)
	echo "made base-ubuntu-16.04, base-ubuntu-18.04 base-ubuntu-20.04"
	docker tag lthn/build:base-ubuntu-20.04 lthn/build:base-ubuntu

base-ubuntu-16-04: ## Builds lthn/build:base-ubuntu-16-04
	docker build --no-cache -t lthn/build:base-ubuntu-16-04 -f build-conf/base/ubuntu/16-04/build.Dockerfile build-src

base-ubuntu-18-04: ## Builds lthn/build:base-ubuntu-18-04
	docker build --no-cache -t lthn/build:base-ubuntu-18-04 -f build-conf/base/ubuntu/18-04/build.Dockerfile build-src

base-ubuntu-20-04: ## Builds lthn/build:base-ubuntu-20-04
	docker build --no-cache -t lthn/build:base-ubuntu-20-04 -f build-conf/base/ubuntu/20-04/build.Dockerfile build-src

base-ubuntu-16.04-test: ## Builds lthn/build:base-ubuntu-16.04-test
	docker build --no-cache -t lthn/build:base-ubuntu-16.04-test -f build-test/base-image/ubuntu.Dockerfile build-src


help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m make %-30s\033[0m %s\n", $$1, $$2}'