
all: help

clean: ## Docker System Prune
	docker system prune --all

build: ## Builds lthn/build
	docker build -t lthn/build -f build-conf/build.Dockerfile build-src

compile: ## Builds lthn/build:compile
	docker build -t lthn/build:compile -f build-conf/compile/base.Dockerfile build-src


depends-x86_64-apple-darwin11: ## Macos
	docker build --build-arg TARGET=x86_64-apple-darwin11 --build-arg PACKAGE="imagemagick libcap-dev librsvg2-bin libz-dev libbz2-dev libtiff-tools python-dev python3-setuptools-git"  -t lthn/build:depends-x86_64-apple-darwin11 -f build-conf/compile/depends.Dockerfile build-src

depends-x86_64-unknown-freebsd: ## x86_64 Freebsd
	docker build --build-arg TARGET=x86_64-unknown-freebsd --build-arg PACKAGE="clang libdbus-1-dev libharfbuzz-dev" -t lthn/build:depends-x86_64-unknown-freebsd -f build-conf/compile/depends.Dockerfile build-src

depends-x86_64-unknown-linux-gnu: ## x86_64 Linux
	docker build --build-arg TARGET=x86_64-unknown-linux-gnu --build-arg PACKAGE="libdbus-1-dev libharfbuzz-dev" -t lthn/build:depends-x86_64-unknown-linux-gnu -f build-conf/compile/depends.Dockerfile build-src

depends-i686-pc-linux-gnu:
	docker build --build-arg TARGET=i686-pc-linux-gnu --build-arg PACKAGE="gcc-multilib-i686-linux-gnu" -t lthn/build:depends-i686-pc-linux-gnu -f build-conf/compile/depends.Dockerfile build-src

depends-x86_64-w64-mingw32:
	docker build --build-arg TARGET=x86_64-w64-mingw32 --build-arg PACKAGE=g++-mingw-w64-x86-64 -t lthn/build:depends-x86_64-w64-mingw32 -f build-conf/compile/depends.Dockerfile build-src

depends-i686-w64-mingw32:
	docker build --build-arg TARGET=i686-w64-mingw32 --build-arg PACKAGE=g++-mingw-w64-i686 -t lthn/build:depends-i686-w64-mingw32 -f build-conf/compile/depends.Dockerfile build-src

depends-arm-linux-gnueabihf:
	docker build --build-arg TARGET=arm-linux-gnueabihf --build-arg PACKAGE=g++-arm-linux-gnueabihf -t lthn/build:depends-arm-linux-gnueabihf -f build-conf/compile/depends.Dockerfile build-src

depends-aarch64-linux-gnu:
	docker build --build-arg TARGET=aarch64-linux-gnu --build-arg PACKAGE=g++-aarch64-linux-gnu -t lthn/build:depends-aarch64-linux-gnu -f build-conf/compile/depends.Dockerfile build-src


depends-riscv64-linux-gnu:
	docker build --build-arg TARGET=riscv64-linux-gnu --build-arg PACKAGE=g++-riscv64-linux-gnu -t lthn/build:depends-riscv64-linux-gnu -f build-conf/compile/depends.Dockerfile build-src


help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m make %-30s\033[0m %s\n", $$1, $$2}'