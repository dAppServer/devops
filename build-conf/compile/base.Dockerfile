FROM ubuntu:trusty
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential libtool cmake autotools-dev automake pkg-config \
                    bsdmainutils curl git ca-certificates ccache \
                    && rm -rf /var/lib/apt/lists/*

