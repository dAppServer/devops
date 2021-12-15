FROM ubuntu:18.04 as base
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

RUN apt-get update && apt-get install -y build-essential libtool cmake autotools-dev automake pkg-config bsdmainutils \
 curl git ca-certificates ccache

WORKDIR /lethean

COPY ./contrib/depends /lethean/contrib/depends

RUN make -C /lethean/contrib/depends download-win
RUN make -C /lethean/contrib/depends download-linux
RUN make -C /lethean/contrib/depends download-osx
RUN mkdir -p /lethean/build/release

RUN ccache --max-size=150M
RUN ccache --set-config=compression=true

FROM base as depends-x86_64-w64-mingw32
RUN update-alternatives --set x86_64-w64-mingw32-g++ $(which x86_64-w64-mingw32-g++-posix) && \
    update-alternatives --set x86_64-w64-mingw32-gcc $(which x86_64-w64-mingw32-gcc-posix);
RUN apt-get install -y cmake python3 g++-mingw-w64-x86-64 qttools5-dev-tools
RUN make -C /lethean/contrib/depends HOST=x86_64-w64-mingw32 -j${THREADS}

FROM base as depends-i686-w64-mingw32
RUN update-alternatives --set i686-w64-mingw32-g++ $(which i686-w64-mingw32-g++-posix) && \
    update-alternatives --set i686-w64-mingw32-gcc $(which i686-w64-mingw32-gcc-posix);
RUN apt-get install -y cmake python3 g++-mingw-w64-i686 qttools5-dev-tools
RUN make -C /lethean/contrib/depends HOST=i686-w64-mingw32 -j${THREADS}

FROM base as depends-x86_64-unknown-linux-gnu
RUN apt-get install -y gperf cmake python3-zmq libdbus-1-dev libharfbuzz-dev
RUN make -C /lethean/contrib/depends HOST=x86_64-unknown-linux-gnu -j${THREADS}

FROM base as depends-x86_64-unknown-freebsd
RUN apt-get install -y clang-8 gperf cmake python3-zmq libdbus-1-dev libharfbuzz-dev
RUN make -C /lethean/contrib/depends HOST=x86_64-unknown-freebsd -j${THREADS}

FROM base as depends-i686-pc-linux-gnu
RUN apt-get install -y gperf cmake g++-multilib python3-zmq
RUN make -C /lethean/contrib/depends HOST=i686-pc-linux-gnu -j${THREADS}

FROM base as depends-aarch64-linux-gnu
RUN apt-get install -y python3 gperf g++-aarch64-linux-gnu
RUN make -C /lethean/contrib/depends HOST=aarch64-linux-gnu -j${THREADS}

FROM base as depends-arm-linux-gnueabihf
RUN apt-get install -y python3 gperf g++-arm-linux-gnueabihf
RUN make -C /lethean/contrib/depends HOST=arm-linux-gnueabihf -j${THREADS}

FROM base as depends-riscv64-linux-gnu
RUN apt-get install -y python3 gperf g++-riscv64-linux-gnu
RUN make -C /lethean/contrib/depends HOST=riscv64-linux-gnu -j${THREADS}

FROM base as depends-x86_64-apple-darwin11
RUN mkdir -p /lethean/contrib/depends/SDKs /lethean/contrib/depends/sdk-sources
RUN if [ ! -f /lethean/contrib/depends/sdk-sources/MacOSX10.11.sdk.tar.gz ]; then curl --location --fail https://bitcoincore.org/depends-sources/sdks/MacOSX10.11.sdk.tar.gz -o /lethean/contrib/depends/sdk-sources/MacOSX10.11.sdk.tar.gz; fi
RUN if [ -f /lethean/contrib/depends/sdk-sources/MacOSX10.11.sdk.tar.gz ]; then tar -C /lethean/contrib/depends/SDKs -xf /lethean/contrib/depends/sdk-sources/MacOSX10.11.sdk.tar.gz; fi
RUN apt-get install -y cmake imagemagick libcap-dev librsvg2-bin libz-dev libbz2-dev libtiff-tools python-dev python3-setuptools-git
RUN make -C /lethean/contrib/depends HOST=x86_64-apple-darwin11 -j${THREADS}
