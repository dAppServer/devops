ARG GCC_BASE_IMAGE=base-ubuntu-16-04
FROM lthn/build:${GCC_BASE_IMAGE}

RUN apt-get install -y --no-install-recommends gcc g++ pkg-config libgtest-dev automake autoconf libtool-bin curl pkg-config \
    graphviz doxygen libssl-dev lsb-release

WORKDIR /usr/local

