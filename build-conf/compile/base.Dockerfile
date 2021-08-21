FROM ubuntu:trusty
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y build-essential libtool cmake autotools-dev automake pkg-config \
                    bsdmainutils curl git ca-certificates ccache software-properties-common wget

RUN add-apt-repository ppa:ubuntu-toolchain-r/test

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN add-apt-repository -s 'deb [arch=amd64] http://apt.llvm.org/trusty/ llvm-toolchain-trusty-8 main'


