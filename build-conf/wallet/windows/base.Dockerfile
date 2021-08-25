FROM ubuntu:20.04 as base

ARG THREADS=1
ARG QT_VERSION=5.15.2
ENV SOURCE_DATE_EPOCH=1397818193

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential cmake g++-mingw-w64 gettext git libtool pkg-config \
    python libssl-dev && \
    rm -rf /var/lib/apt/lists/*

RUN update-alternatives --set x86_64-w64-mingw32-g++ $(which x86_64-w64-mingw32-g++-posix) && \
    update-alternatives --set x86_64-w64-mingw32-gcc $(which x86_64-w64-mingw32-gcc-posix)

COPY --from=lthn/build:depends-x86_64-w64-mingw32 / /depends
