FROM debian:bullseye-slim as base
# This sets the build target, you can pick from:
# 64: x86_64-unknown-linux-gnu, x86_64-unknown-freebsd, x86_64-w64-mingw32
# 32: i686-pc-linux-gnu, i686-w64-mingw32, arm-linux-gnueabihf
# arm: aarch64-linux-gnu, riscv64-linux-gnu
ARG BUILD=x86_64-unknown-linux-gnu
ARG THREADS=2
ENV DEBIAN_FRONTEND=noninteractive

RUN echo "Acquire::Retries \"3\";"         | tee -a /etc/apt/apt.conf.d/80-custom
RUN echo "Acquire::http::Timeout \"120\";" | tee -a /etc/apt/apt.conf.d/80-custom
RUN echo "Acquire::ftp::Timeout \"120\";"  | tee -a /etc/apt/apt.conf.d/80-custom

RUN apt-get update && apt-get install -y curl librsvg2-bin libtiff-tools bsdmainutils cmake imagemagick libz-dev python3-setuptools libtinfo5 xorriso \
    make automake cmake curl libtool binutils-gold bsdmainutils pkg-config python3 patch bison \
    g++-arm-linux-gnueabihf binutils-arm-linux-gnueabihf g++-aarch64-linux-gnu binutils-aarch64-linux-gnu \
    g++-riscv64-linux-gnu binutils-riscv64-linux-gnu ccache \
    build-essential libtool autotools-dev automake pkg-config bsdmainutils curl git nsis

WORKDIR /bitcoin

COPY ./bitcoin/depends /bitcoin/depends

RUN make -C /bitcoin/depends download-win
RUN make -C /bitcoin/depends download-linux
RUN make -C /bitcoin/depends download-osx

RUN ccache --max-size=150M
RUN ccache --set-config=compression=true

FROM base as build-x86_64-w64-mingw32
RUN update-alternatives --set x86_64-w64-mingw32-g++ $(which x86_64-w64-mingw32-g++-posix) && \
    update-alternatives --set x86_64-w64-mingw32-gcc $(which x86_64-w64-mingw32-gcc-posix);
RUN make -C /bitcoin/depends HOST=x86_64-w64-mingw32 -j${THREADS}

FROM base as build-i686-w64-mingw32
RUN update-alternatives --set i686-w64-mingw32-g++ $(which i686-w64-mingw32-g++-posix) && \
    update-alternatives --set i686-w64-mingw32-gcc $(which i686-w64-mingw32-gcc-posix);
RUN make -C /bitcoin/depends HOST=i686-w64-mingw32 -j${THREADS}

# x86_64-pc-linux-gnu for x86 Linux
FROM base as build-x86_64-pc-linux-gnu
RUN apt-get install -y gperf python3-zmq libdbus-1-dev libharfbuzz-dev
RUN make -C /bitcoin/depends HOST=x86_64-pc-linux-gnu -j${THREADS}

# x86_64-unknown-linux-gnu x86 Linux
FROM base as build-x86_64-unknown-linux-gnu
RUN apt-get install -y gperf python3-zmq libdbus-1-dev libharfbuzz-dev
RUN make -C /bitcoin/depends HOST=x86_64-unknown-linux-gnu -j${THREADS}

FROM base as build-x86_64-unknown-freebsd
RUN apt-get install -y clang-8 gperf python3-zmq libdbus-1-dev libharfbuzz-dev
RUN make -C /bitcoin/depends HOST=x86_64-unknown-freebsd -j${THREADS}

FROM base as build-i686-pc-linux-gnu
RUN make -C /bitcoin/depends HOST=i686-pc-linux-gnu -j${THREADS}

FROM base as build-aarch64-linux-gnu
RUN make -C /bitcoin/depends HOST=aarch64-linux-gnu -j${THREADS}

FROM base as build-arm-linux-gnueabihf
RUN make -C /bitcoin/depends HOST=arm-linux-gnueabihf -j${THREADS}

FROM base as build-powerpc64-linux-gnu
RUN make -C /bitcoin/depends HOST=powerpc64-linux-gnu -j${THREADS}

FROM base as build-powerpc64le-linux-gnu
RUN make -C /bitcoin/depends HOST=powerpc64le-linux-gnu -j${THREADS}

FROM base as build-riscv32-linux-gnu
RUN make -C /bitcoin/depends HOST=riscv32-linux-gnu -j${THREADS}

FROM base as build-riscv64-linux-gnu
RUN make -C /bitcoin/depends HOST=riscv64-linux-gnu -j${THREADS}

FROM base as s390x-linux-gnu
RUN make -C /bitcoin/depends HOST=s390x-linux-gnu -j${THREADS}

FROM base as armv7a-linux-android
RUN make -C /bitcoin/depends HOST=armv7a-linux-android -j${THREADS}

FROM base as aarch64-linux-android
RUN make -C /bitcoin/depends HOST=aarch64-linux-android -j${THREADS}

FROM base as i686-linux-android
RUN make -C /bitcoin/depends HOST=i686-linux-android -j${THREADS}

FROM base as x86_64-linux-android
RUN make -C /bitcoin/depends HOST=x86_64-linux-android -j${THREADS}

FROM base as build-x86_64-apple-darwin11
RUN mkdir -p /bitcoin/depends/SDKs /bitcoin/depends/sdk-sources
RUN if [ ! -f /bitcoin/depends/sdk-sources/MacOSX10.11.sdk.tar.gz ]; then curl --location --fail https://bitcoincore.org/depends-sources/sdks/MacOSX10.11.sdk.tar.gz -o /bitcoin/depends/sdk-sources/MacOSX10.11.sdk.tar.gz; fi
RUN if [ -f /bitcoin/depends/sdk-sources/MacOSX10.11.sdk.tar.gz ]; then tar -C /bitcoin/depends/SDKs -xf /bitcoin/depends/sdk-sources/MacOSX10.11.sdk.tar.gz; fi
RUN apt-get install -y imagemagick libcap-dev librsvg2-bin libz-dev libbz2-dev libtiff-tools
RUN make -C /bitcoin/depends HOST=x86_64-apple-darwin11 -j${THREADS}

FROM base as build-x86_64-apple-darwin
RUN mkdir -p /bitcoin/depends/SDKs /bitcoin/depends/sdk-sources
RUN if [ ! -f /bitcoin/depends/sdk-sources/MacOSX10.11.sdk.tar.gz ]; then curl --location --fail https://bitcoincore.org/depends-sources/sdks/MacOSX10.11.sdk.tar.gz -o /bitcoin/depends/sdk-sources/MacOSX10.11.sdk.tar.gz; fi
RUN if [ -f /bitcoin/depends/sdk-sources/MacOSX10.11.sdk.tar.gz ]; then tar -C /bitcoin/depends/SDKs -xf /bitcoin/depends/sdk-sources/MacOSX10.11.sdk.tar.gz; fi
RUN apt-get install -y imagemagick libcap-dev librsvg2-bin libz-dev libbz2-dev libtiff-tools
RUN make -C /bitcoin/depends HOST=x86_64-apple-darwin -j${THREADS}

FROM scratch as x86_64-unknown-linux-gnu
COPY --from=build-x86_64-unknown-linux-gnu /bitcoin/depends/x86_64-unknown-linux-gnu /

FROM scratch as x86_64-apple-darwin11
COPY --from=build-x86_64-apple-darwin11 /bitcoin/depends/x86_64-apple-darwin11 /

FROM scratch as x86_64-apple-darwin
COPY --from=build-x86_64-apple-darwin /bitcoin/depends/x86_64-apple-darwin /

# x86_64-pc-linux-gnu for x86 Linux
FROM scratch as x86_64-pc-linux-gnu
COPY --from=build-x86_64-pc-linux-gnu /bitcoin/depends/x86_64-pc-linux-gnu /

# i686-pc-linux-gnu for Linux 32 bit
FROM scratch as i686-pc-linux-gnu
COPY --from=build-i686-pc-linux-gnu /bitcoin/depends/i686-pc-linux-gnu /

FROM scratch as x86_64-unknown-freebsd
COPY --from=build-x86_64-unknown-freebsd /bitcoin/depends/x86_64-unknown-freebsd /

# x86_64-w64-mingw32 for Win64
FROM scratch as x86_64-w64-mingw32
COPY --from=build-x86_64-w64-mingw32 /bitcoin/depends/x86_64-w64-mingw32 /

# x86_64-apple-darwin for macOS
FROM scratch as x86_64-apple-darwin
COPY --from=build-x86_64-apple-darwin /bitcoin/depends/x86_64-apple-darwin /

# aarch64-linux-gnu for Linux ARM 64 bit
FROM scratch as aarch64-linux-gnu
COPY --from=build-aarch64-linux-gnu /bitcoin/depends/aarch64-linux-gnu /

# arm-linux-gnueabihf for Linux ARM 32 bit
FROM scratch as arm-linux-gnueabihf
COPY --from=build-arm-linux-gnueabihf /bitcoin/depends/arm-linux-gnueabihf /

# powerpc64-linux-gnu for Linux POWER 64-bit (big endian)
FROM scratch as powerpc64-linux-gnu
COPY --from=build-powerpc64-linux-gnu /bitcoin/depends/powerpc64-linux-gnu /

# powerpc64le-linux-gnu for Linux POWER 64-bit (little endian)
FROM scratch as powerpc64le-linux-gnu
COPY --from=build-powerpc64le-linux-gnu /bitcoin/depends/powerpc64le-linux-gnu /

# riscv32-linux-gnu for Linux RISC-V 32 bit
FROM scratch as riscv32-linux-gnu
COPY --from=build-riscv32-linux-gnu /bitcoin/depends/riscv32-linux-gnu /

# riscv64-linux-gnu for Linux RISC-V 64 bit
FROM scratch as riscv64-linux-gnu
COPY --from=build-riscv64-linux-gnu /bitcoin/depends/riscv64-linux-gnu /

# s390x-linux-gnu for Linux S390X
FROM scratch as s390x-linux-gnu
COPY --from=build-s390x-linux-gnu /bitcoin/depends/s390x-linux-gnu /

# armv7a-linux-android for Android ARM 32 bit
FROM scratch as armv7a-linux-android
COPY --from=build-armv7a-linux-android /bitcoin/depends/armv7a-linux-android /

# aarch64-linux-android for Android ARM 64 bit
FROM scratch as aarch64-linux-android
COPY --from=build-aarch64-linux-android /bitcoin/depends/aarch64-linux-android /

# i686-linux-android for Android x86 32 bit
FROM scratch as i686-linux-android
COPY --from=build-i686-linux-android /bitcoin/depends/i686-linux-android /

# x86_64-linux-android for Android x86 64 bit
FROM scratch as x86_64-linux-android
COPY --from=build-x86_64-linux-android /bitcoin/depends/x86_64-linux-android /




