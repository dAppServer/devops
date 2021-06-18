FROM lthn/build:tool-gcc

RUN apt-get install -y libunbound-dev libsodium-dev libunwind8-dev liblzma-dev libreadline6-dev libssl-dev \
    libldns-dev libexpat1-dev doxygen graphviz libpgm-dev qttools5-dev-tools libzmq3-dev \
    libhidapi-dev libusb-1.0-0-dev libprotobuf-dev protobuf-compiler libudev-dev libboost-all-dev

#RUN git clone https://gitlab.com/lthn.io/projects/chain/lethean.git && cd lethean && make release-static