FROM lthn/build:depends-aarch64-linux-gnu as aarch64-linux-gnu
FROM lthn/build:depends-x86_64-unknown-linux-gnu as x86_64-unknown-linux-gnu
FROM lthn/build:depends-x86_64-unknown-freebsd as x86_64-unknown-freebsd
FROM lthn/build:depends-x86_64-w64-mingw32 as x86_64-w64-mingw32
FROM lthn/build:depends-i686-w64-mingw32 as i686-w64-mingw32
FROM lthn/build:depends-i686-pc-linux-gnu as i686-pc-linux-gnu
FROM lthn/build:depends-arm-linux-gnueabihf as arm-linux-gnueabihf
FROM lthn/build:depends-aarch64-linux-gnu as aarch64-linux-gnu
FROM lthn/build:depends-riscv64-linux-gnu as riscv64-linux-gnu
FROM lthn/build:compile as build

WORKDIR /depends

COPY --from=riscv64-linux-gnu / /depends
COPY --from=aarch64-linux-gnu / /depends
COPY --from=arm-linux-gnueabihf / /depends
COPY --from=i686-pc-linux-gnu / /depends
COPY --from=i686-w64-mingw32 / /depends
COPY --from=x86_64-w64-mingw32 / /depends
COPY --from=x86_64-unknown-freebsd / /depends
COPY --from=x86_64-unknown-linux-gnu / /depends
COPY --from=aarch64-linux-gnu / /depends

RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository ppa:ubuntu-toolchain-r/test

RUN apt-get update && apt-get install -y gperf cmake python3-zmq libdbus-1-dev libharfbuzz-dev g++-multilib python3-zmq \
    python3 g++-arm-linux-gnueabihf g++-aarch64-linux-gnu g++-mingw-w64-x86-64 g++-mingw-w64-i686 g++-riscv64-linux-gnu \
    clang-8

RUN  update-alternatives --set i686-w64-mingw32-g++ $(which i686-w64-mingw32-g++-posix) && update-alternatives --set i686-w64-mingw32-gcc $(which i686-w64-mingw32-gcc-posix);
RUN  update-alternatives --set x86_64-w64-mingw32-g++ $(which x86_64-w64-mingw32-g++-posix) && update-alternatives --set x86_64-w64-mingw32-gcc $(which x86_64-w64-mingw32-gcc-posix);

COPY . .

RUN chmod +x ./build.sh

ENTRYPOINT ["./build.sh"]