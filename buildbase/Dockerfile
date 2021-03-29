# Multistage docker build, requires docker 17.05

# builder stage
FROM ubuntu:16.04
RUN set -ex \
    && apt update \
    && apt upgrade -y \
    && apt install -y --no-install-recommends \
        # base requirements
        build-essential cmake pkg-config libboost-all-dev libssl-dev libzmq3-dev \
        libunbound-dev libsodium-dev libunwind8-dev liblzma-dev libreadline6-dev \
        libldns-dev libexpat1-dev doxygen graphviz libpgm-dev qttools5-dev-tools \
        libhidapi-dev libusb-1.0-0-dev libprotobuf-dev protobuf-compiler libudev-dev \
        ca-certificates git

WORKDIR /usr/local
