#
# Lethean Docker builder
#
# Maintainer: snider@lethean.io
# Licence: MIT License, see /LICENSE
#
FROM scratch
FROM ubuntu:16.04
RUN set -x \
&& buildDeps=' \
      ca-certificates \
      cmake \
      g++ \
      git \
      libboost1.58-all-dev \
      libssl-dev \
      make \
      pkg-config \
  ' \
  && apt-get -qq update \
  && apt-get -qq --no-install-recommends install $buildDeps

#RUN git clone --single-branch https://gitlab.com/lthn.io/projects/chain/lethean.git


CMD echo "\nWe Have Built: lthn/build\nDockerfile: FROM lthn/build as builder\n"
