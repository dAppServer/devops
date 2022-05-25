# syntax=docker/dockerfile:1
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y

RUN apt-get update && \
    apt-get install -y build-essential libtool cmake autotools-dev automake pkg-config \
                    bsdmainutils curl git ccache wget libgtest-dev \
                    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

COPY --chown=root --chmod=0777 build.sh /usr/local/bin/build

ENTRYPOINT ["build"]
