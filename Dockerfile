#
# Lethean Docker builder
#
# Maintainer: snider@lethean.io
# Licence: MIT License, see /LICENSE
#
FROM scratch
FROM ubuntu:16.04
RUN buildDeps=' \
      ca-certificates doxygen \
      cmake autoconf \
      g++ automake \
      git libtool \
      libboost1.58-all-dev \
      libssl-dev python3 \
      make rsync \
      pkg-config \
      docker.io \
  ' \
  && apt-get update && apt-get -y --no-install-recommends install libreadline6 libreadline6-dev \
  && apt-get -y --no-install-recommends install $buildDeps \
  ; apt-get clean \
  && rm -rf /var/lib/apt/lists/*

