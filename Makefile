
COMMON_PROPS:=--platform=linux/amd64 --pull compiler/src
all: help

clean: ## Docker System Prune
	docker system prune --all

compile: ## Builds lthn/build:compile
	docker build -t lthn/build:compile --cache-to=lthn/build:compile  --cache-from=lthn/build:compile -f compiler/images/compile.Dockerfile ${COMMON_PROPS}

sources-linux: ## Download Linux Source Code
	docker build --build-arg BUILD=linux --cache-to=lthn/build:sources-linux --cache-from=lthn/build:sources-linux -t lthn/build:sources-linux -f compiler/images/sources.Dockerfile  ${COMMON_PROPS}

sources-win: ## Download Windows Source Code
	docker build --build-arg BUILD=win --cache-to=lthn/build:sources-win --cache-from=lthn/build:sources-win -t lthn/build:sources-win -f compiler/images/sources.Dockerfile  ${COMMON_PROPS}

sources-osx: ## Download macOS Source Code
	docker build --build-arg BUILD=osx --cache-to=lthn/build:sources-osx --cache-from=lthn/build:sources-osx -t lthn/build:sources-osx -f compiler/images/sources.Dockerfile  ${COMMON_PROPS}

depends-x86_64-apple-darwin11: ## Macos
	docker build --build-arg BUILD=x86_64-apple-darwin11 --cache-to=lthn/build:depends-x86_64-apple-darwin11 --cache-from=lthn/build:depends-x86_64-apple-darwin11 -t lthn/build:depends-x86_64-apple-darwin11 -f compiler/images/depends.Dockerfile  ${COMMON_PROPS}

depends-x86_64-unknown-freebsd: ## x86_64 Freebsd
	docker build --build-arg BUILD=x86_64-unknown-freebsd --cache-to=lthn/build:depends-x86_64-unknown-freebsd --cache-from=lthn/build:depends-x86_64-unknown-freebsd -t lthn/build:depends-x86_64-unknown-freebsd -f compiler/images/depends.Dockerfile  ${COMMON_PROPS}

depends-x86_64-unknown-linux-gnu: ## x86_64 Linux
	docker build --build-arg BUILD=x86_64-unknown-linux-gnu --cache-to=lthn/build:depends-x86_64-unknown-linux-gnu --cache-from=lthn/build:depends-x86_64-unknown-linux-gnu -t lthn/build:depends-x86_64-unknown-linux-gnu -f compiler/images/depends.Dockerfile  ${COMMON_PROPS}

depends-i686-pc-linux-gnu: ## i686 Linux
	docker build --build-arg BUILD=i686-pc-linux-gnu --cache-to=lthn/build:depends-i686-pc-linux-gnu --cache-from=lthn/build:depends-i686-pc-linux-gnu -t lthn/build:depends-i686-pc-linux-gnu -f compiler/images/depends.Dockerfile  ${COMMON_PROPS}

depends-x86_64-w64-mingw32: ## Windows 64
	docker build --build-arg BUILD=x86_64-w64-mingw32 --cache-to=lthn/build:depends-x86_64-w64-mingw32 --cache-from=lthn/build:depends-x86_64-w64-mingw32 -t lthn/build:depends-x86_64-w64-mingw32 -f compiler/images/depends.Dockerfile  ${COMMON_PROPS}

depends-i686-w64-mingw32: ## Windows 32
	docker build --build-arg BUILD=i686-w64-mingw32 --cache-to=lthn/build:depends-i686-w64-mingw32  --cache-from=lthn/build:depends-i686-w64-mingw32 -t lthn/build:depends-i686-w64-mingw32 -f compiler/images/depends.Dockerfile  ${COMMON_PROPS}

depends-arm-linux-gnueabihf: ## ARM 32
	docker build --build-arg BUILD=arm-linux-gnueabihf --cache-to=lthn/build:depends-arm-linux-gnueabihf --cache-from=lthn/build:depends-arm-linux-gnueabihf -t lthn/build:depends-arm-linux-gnueabihf -f compiler/images/depends.Dockerfile  ${COMMON_PROPS}

depends-aarch64-linux-gnu: ## ARM 64
	docker build --build-arg BUILD=aarch64-linux-gnu --cache-to=lthn/build:depends-aarch64-linux-gnu --cache-from=lthn/build:depends-aarch64-linux-gnu -t lthn/build:depends-aarch64-linux-gnu -f compiler/images/depends.Dockerfile  ${COMMON_PROPS}

depends-riscv64-linux-gnu: ## riscv64
	docker build --build-arg=BUILD=riscv64-linux-gnu --cache-to=lthn/build:depends-riscv64-linux-gnu --cache-from=lthn/build:depends-riscv64-linux-gnu -t lthn/build:depends-riscv64-linux-gnu -f compiler/images/depends.Dockerfile  ${COMMON_PROPS}

wallet-linux-base:
	docker build --cache-from=lthn/build:wallet-linux-base   -t lthn/build:wallet-linux-base -f build-conf/wallet/linux/base.Dockerfile  ${COMMON_PROPS}

wallet-lib-linux-utils:
	docker build --cache-from=lthn/build:wallet-lib-linux-utils -t=lthn/build:wallet-lib-linux-utils -f=build-conf/wallet/linux/utils.Dockerfile  ${COMMON_PROPS}

wallet-lib-linux-boost:
	docker build --cache-from=lthn/build:wallet-lib-linux-boost   -t=lthn/build:wallet-lib-linux-boost -f=build-conf/wallet/linux/boost.Dockerfile  ${COMMON_PROPS}

wallet-lib-linux-fontconfig:
	docker build --cache-from=lthn/build:wallet-lib-linux-fontconfig   -t=lthn/build:wallet-lib-linux-fontconfig -f=build-conf/wallet/linux/fontconfig.Dockerfile  ${COMMON_PROPS}

wallet-lib-linux-cmake:
	docker build --cache-from=lthn/build:wallet-lib-linux-cmake   -t=lthn/build:wallet-lib-linux-cmake -f=build-conf/wallet/linux/cmake.Dockerfile  ${COMMON_PROPS}

wallet-lib-linux-libx:
	docker build --cache-from=lthn/build:wallet-lib-linux-libx   -t=lthn/build:wallet-lib-linux-libx -f=build-conf/wallet/linux/libx.Dockerfile  ${COMMON_PROPS}

wallet-windows-base:
	docker build --cache-from=lthn/build:wallet-windows-base   -t=lthn/build:wallet-windows-base -f=build-conf/wallet/windows/base.Dockerfile  ${COMMON_PROPS}

wallet-lib-windows-cmake:
	docker build --cache-from=lthn/build:wallet-lib-windows-cmake   -t=lthn/build:wallet-lib-windows-cmake -f=build-conf/wallet/windows/cmake.Dockerfile  ${COMMON_PROPS}

wallet-lib-windows-libx:
	docker build --cache-from=lthn/build:wallet-lib-windows-libx   -t=lthn/build:wallet-lib-windows-libx -f=build-conf/wallet/windows/libx.Dockerfile  ${COMMON_PROPS}

wallet-lib-windows-qt:
	docker build --cache-from=lthn/build:wallet-lib-windows-qt   -t=lthn/build:wallet-lib-windows-qt -f=build-conf/wallet/windows/qt.Dockerfile  ${COMMON_PROPS}


wallet-linux:
	docker build --cache-from=lthn/build:wallet-linux   -t=lthn/build:wallet-linux -f=build-conf/wallet/linux.Dockerfile  ${COMMON_PROPS}

wallet-windows:
	docker build --cache-from=lthn/build:wallet-windows   -t=lthn/build:wallet-windows -f=build-conf/wallet/windows.Dockerfile  ${COMMON_PROPS}

wallet-android:
	docker build --cache-from=lthn/build:wallet-android   -t lthn/build:wallet-android -f build-conf/wallet/android.Dockerfile  ${COMMON_PROPS}

#lthn-chain-linux-shrink: ## Builds a optimised build image
#	docker run --rm -v /var/run/docker.sock:/var/run/docker.sock dslim/docker-slim build \
#			--continue-after "exec" --http-probe-off --pull --target "lthn/build:lthn-chain-linux" \
#			--exec "git clone https://gitlab.com/lthn.io/projects/chain/lethean.git && cd lethean && make -j4 release-static && cd .. && rm -rf lethean" \
#			--show-plogs --show-clogs --show-blogs --tag "lthn/build:lthn-chain-linux" \
#			--include-path "/usr/share/cmake-3.5"

#lthn-chain-linux-shrink-ci: ## Gitlab task
#	build-shrink/docker-slim build --http-probe=false --continue-after "exec" --show-plogs --show-clogs --show-blogs \
#			--exec "git clone --recursive --depth 1 --branch next https://gitlab.com/lthn.io/projects/chain/lethean.git && cd lethean && make -j10 static" \
#			--include-shell --dockerfile build-conf/lthn/images/compile.Dockerfile --tag "lthn/build:lthn-images-linux" \
#			--include-path "/usr/share/cmake-3.16" --include-path "/usr/local" .


help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m make %-30s\033[0m %s\n", $$1, $$2}'
