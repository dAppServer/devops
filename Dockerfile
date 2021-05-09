#
# Lethean Docker builder
#
# Maintainer: snider@lethean.io
# Licence: MIT License, see /LICENSE
#
FROM scratch
FROM ubuntu:16.04
# they have all the versions in this ppa:ubuntu-toolchain-r/test
ARG GCC_VERSION=8
RUN set -ex \
    && apt-get update && apt-get upgrade -y; \
    apt-get install -y software-properties-common python-software-properties libreadline6 libreadline6-dev \
    && add-apt-repository ppa:ubuntu-toolchain-r/test && apt-get update

RUN set -ex \
    && apt-get install -y gcc-7 g++-7 gcc-8 g++-8 gcc-9 g++-9 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 80 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/gcov gcov /usr/bin/gcov-8 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 70 --slave /usr/bin/g++ g++ /usr/bin/g++-7 --slave /usr/bin/gcov gcov /usr/bin/gcov-7 \
    && update-alternatives --config gcc

RUN set -ex \
    && apt update \
    && apt-get install -y --no-install-recommends \
        # base requirements
        dpkg-dev libc6-dev libc-dev make cmake pkg-config libboost-all-dev libssl-dev libzmq3-dev \
        libunbound-dev libsodium-dev libunwind8-dev liblzma-dev libreadline6-dev \
        libldns-dev libexpat1-dev doxygen graphviz libpgm-dev qttools5-dev-tools \
        libhidapi-dev libusb-1.0-0-dev libprotobuf-dev protobuf-compiler libudev-dev \
        ca-certificates git apt-utils

WORKDIR /home/lthn

CMD echo "\nWe Have Built: registry.gitlab.com/lethean.io/sdk/builder\nDockerfile: FROM registry.gitlab.com/lethean.io/sdk/builder as builder\n"
