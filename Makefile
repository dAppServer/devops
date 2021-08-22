
all: help

clean: ## Docker System Prune
	docker system prune --all

builder: ## Builds lthn/build
	docker build -t lthn/build -f Dockerfile build-src

compile: ## Builds lthn/build:compile
	docker build -t lthn/build:compile -f base.Dockerfile .

depends-x86_64-apple-darwin11: ## Macos
	docker build --build-arg HOST=x86_64-apple-darwin11 --build-arg PACKAGE="imagemagick libcap-dev librsvg2-bin libz-dev libbz2-dev libtiff-tools python-dev python3-setuptools-git"  -t lthn/build:depends-x86_64-apple-darwin11 -f build-conf/compile/depends.Dockerfile build-src

depends-x86_64-unknown-freebsd: ## x86_64 Freebsd
	docker build --build-arg HOST=x86_64-unknown-freebsd --build-arg PACKAGE="clang-8 gperf cmake python3-zmq libdbus-1-dev libharfbuzz-dev" -t lthn/build:depends-x86_64-unknown-freebsd -f build-conf/compile/depends.Dockerfile build-src

depends-x86_64-unknown-linux-gnu: ## x86_64 Linux
	docker build --build-arg HOST=x86_64-unknown-linux-gnu --build-arg PACKAGE="gperf cmake python3-zmq libdbus-1-dev libharfbuzz-dev" -t lthn/build:depends-x86_64-unknown-linux-gnu -f build-conf/compile/depends.Dockerfile build-src

depends-i686-pc-linux-gnu: ## i686 Linux
	docker build --build-arg HOST=i686-pc-linux-gnu --build-arg PACKAGE="gperf cmake g++-multilib python3-zmq" -t lthn/build:depends-i686-pc-linux-gnu -f build-conf/compile/depends.Dockerfile build-src

depends-x86_64-w64-mingw32: ## Windows 64
	docker build --build-arg HOST=x86_64-w64-mingw32 --build-arg PACKAGE="cmake python3 g++-mingw-w64-x86-64 qttools5-dev-tools" -t lthn/build:depends-x86_64-w64-mingw32 -f build-conf/compile/depends.Dockerfile build-src

depends-i686-w64-mingw32: ## Windows 32
	docker build --build-arg HOST=i686-w64-mingw32 --build-arg PACKAGE="python3 g++-mingw-w64-i686 qttools5-dev-tools" -t lthn/build:depends-i686-w64-mingw32 -f build-conf/compile/depends.Dockerfile build-src

depends-arm-linux-gnueabihf: ## ARM 32
	docker build --build-arg HOST=arm-linux-gnueabihf --build-arg PACKAGE="python3 gperf g++-arm-linux-gnueabihf" -t lthn/build:depends-arm-linux-gnueabihf -f build-conf/compile/depends.Dockerfile build-src

depends-aarch64-linux-gnu: ## ARM 64
	docker build --build-arg HOST=aarch64-linux-gnu --build-arg PACKAGE="python3 gperf g++-aarch64-linux-gnu" -t lthn/build:depends-aarch64-linux-gnu -f build-conf/compile/depends.Dockerfile build-src

depends-riscv64-linux-gnu: ## riscv64
	docker build --build-arg HOST=riscv64-linux-gnu --build-arg PACKAGE="python3 gperf g++-riscv64-linux-gnu" -t lthn/build:depends-riscv64-linux-gnu -f build-conf/compile/depends.Dockerfile build-src

help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m make %-30s\033[0m %s\n", $$1, $$2}'