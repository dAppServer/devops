FROM ubuntu:bionic
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y build-essential libtool cmake autotools-dev automake pkg-config \
                    bsdmainutils curl git ca-certificates ccache software-properties-common wget

