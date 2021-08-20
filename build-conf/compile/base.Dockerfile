FROM debian:11-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates pkg-config git curl bzip2 wget tar zip unzip rsync make qttools5-dev-tools \
                    cmake ccache doxygen graphviz automake autopoint bison gettext  gperf  python3 libtool-bin \
                    xutils-dev build-essential libtool autotools-dev bsdmainutils python3-zmq \
                    && rm -rf /var/lib/apt/lists/*

