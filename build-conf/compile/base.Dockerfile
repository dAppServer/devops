FROM ubuntu:bionic
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y build-essential libtool cmake autotools-dev automake pkg-config \
                    bsdmainutils curl git ca-certificates ccache software-properties-common wget \
                    libboost-all-dev libssl-dev libzmq3-dev libunbound-dev libsodium-dev libunwind8-dev liblzma-dev  \
                    libreadline6-dev libldns-dev libexpat1-dev libpgm-dev qttools5-dev-tools libhidapi-dev \
                    libusb-1.0-0-dev libprotobuf-dev protobuf-compiler libudev-dev libgtest-dev libnorm-dev \
                    && cd /usr/src/gtest && cmake . && make && mv libg* /usr/lib/ \
                    && rm -rf /var/lib/apt/lists/*


