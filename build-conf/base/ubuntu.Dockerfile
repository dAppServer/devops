ARG UBUNTU_VERSION=16.04
FROM scratch as parent

FROM ubuntu:${UBUNTU_VERSION} as ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN set -ex && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get --no-install-recommends --yes install \
        ca-certificates pkg-config git curl bzip2 \
        wget tar zip unzip rsync

