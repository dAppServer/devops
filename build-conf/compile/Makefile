compile: ## Builds lthn/build:compile
	docker build -t lthn/build:compile -f base.Dockerfile .

depends-x86_64-apple-darwin11: ## Macos
	docker build --build-arg HOST=x86_64-apple-darwin11 --build-arg PACKAGE="imagemagick libcap-dev librsvg2-bin libz-dev libbz2-dev libtiff-tools python-dev python3-setuptools-git"  -t lthn/build:depends-x86_64-apple-darwin11 -f depends.Dockerfile .c

depends-x86_64-unknown-freebsd: ## x86_64 Freebsd
	docker build --build-arg HOST=x86_64-unknown-freebsd --build-arg PACKAGE="clang-8 gperf cmake python3-zmq libdbus-1-dev libharfbuzz-dev" -t lthn/build:depends-x86_64-unknown-freebsd -f depends.Dockerfile .

depends-x86_64-unknown-linux-gnu: ## x86_64 Linux
	docker build --build-arg HOST=x86_64-unknown-linux-gnu --build-arg PACKAGE="gperf cmake python3-zmq libdbus-1-dev libharfbuzz-dev" -t lthn/build:depends-x86_64-unknown-linux-gnu -f depends.Dockerfile .

depends-i686-pc-linux-gnu:
	docker build --build-arg HOST=i686-pc-linux-gnu --build-arg PACKAGE="gperf cmake g++-multilib python3-zmq" -t lthn/build:depends-i686-pc-linux-gnu -f depends.Dockerfile .

depends-x86_64-w64-mingw32:
	docker build --build-arg HOST=x86_64-w64-mingw32 --build-arg PACKAGE="cmake python3 g++-mingw-w64-x86-64 qttools5-dev-tools wine1.6 bc" -t lthn/build:depends-x86_64-w64-mingw32 -f depends.Dockerfile .

depends-i686-w64-mingw32:
	docker build --build-arg HOST=i686-w64-mingw32 --build-arg PACKAGE="python3 g++-mingw-w64-i686 qttools5-dev-tools wine1.6 bc" -t lthn/build:depends-i686-w64-mingw32 -f depends.Dockerfile .

depends-arm-linux-gnueabihf:
	docker build --build-arg HOST=arm-linux-gnueabihf --build-arg PACKAGE="python3 gperf g++-arm-linux-gnueabihf" -t lthn/build:depends-arm-linux-gnueabihf -f depends.Dockerfile .

depends-aarch64-linux-gnu:
	docker build --build-arg HOST=aarch64-linux-gnu --build-arg PACKAGE="python3 gperf g++-aarch64-linux-gnu" -t lthn/build:depends-aarch64-linux-gnu -f depends.Dockerfile .

depends-riscv64-linux-gnu:
	docker build --build-arg HOST=riscv64-linux-gnu --build-arg PACKAGE="python3 gperf g++-riscv64-linux-gnu" -t lthn/build:depends-riscv64-linux-gnu -f depends.Dockerfile .
