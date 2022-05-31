# syntax=docker/dockerfile:1
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y

RUN apt-get update && \
    apt-get install -y build-essential libtool cmake autotools-dev automake pkg-config \
                    bsdmainutils curl git ccache wget libgtest-dev \
                    libssl-dev libzmq3-dev libunbound-dev libsodium-dev libunwind8-dev liblzma-dev libreadline6-dev \
                    libldns-dev libexpat1-dev libpgm-dev qttools5-dev-tools libhidapi-dev libusb-1.0-0-dev libprotobuf-dev \ 
                    protobuf-compiler libudev-dev libboost-chrono-dev libboost-date-time-dev libboost-filesystem-dev \
                    libboost-locale-dev libboost-program-options-dev libboost-regex-dev libboost-serialization-dev \
                    libboost-system-dev libboost-thread-dev python3 ccache doxygen graphviz \
                    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

COPY --chown=root --chmod=0777 build.sh /usr/local/bin/build

ENTRYPOINT ["build"]
