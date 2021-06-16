FROM scratch as parent
FROM ubuntu:16.04

RUN set -ex && \
    apt-get update && \
    apt-get --no-install-recommends --yes install \
        ca-certificates pkg-config git curl bzip2 \
        wget tar zip
