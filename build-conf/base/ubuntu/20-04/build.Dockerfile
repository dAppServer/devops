FROM ubuntu:20.04 as base-ubuntu-20-04

ENV DEBIAN_FRONTEND=noninteractive

RUN set -ex && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get --yes install \
        ca-certificates pkg-config git curl bzip2 \
        wget tar zip unzip rsync make cmake \
        ccache doxygen graphviz automake autopoint bison gettext  gperf  python3  \
        xutils-dev build-essential libtool

