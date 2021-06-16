FROM scratch
FROM ubuntu:16.04 as base-ubuntu-16-04

ENV DEBIAN_FRONTEND=noninteractive

RUN set -ex && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get --no-install-recommends --yes install \
        ca-certificates pkg-config git curl bzip2 \
        wget tar zip unzip rsync

