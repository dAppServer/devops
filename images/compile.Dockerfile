FROM ubuntu:20.04 as build-base

ARG THREADS=1

ENV SOURCE_DATE_EPOCH=1397818193
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y build-essential libicu-dev git curl g++ ca-certificates make pkg-config  \
            zlib1g-dev mesa-common-dev libglu1-mesa-dev python-dev autotools-dev libbz2-dev

WORKDIR /root

FROM build-base as build-prep
##########################################################
# Split download & compile to use dockers caching layers #
##########################################################

# Download CMake
ARG CMAKE_VERSION_DOT=3.15.5
ARG CMAKE_HASH=62e3e7d134a257e13521e306a9d3d1181ab99af8fcae66699c8f98754fc02dda
RUN set -ex \
    && curl https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION_DOT}/cmake-${CMAKE_VERSION_DOT}-Linux-x86_64.sh -OL\
    && echo "${CMAKE_HASH}  cmake-${CMAKE_VERSION_DOT}-Linux-x86_64.sh" | sha256sum -c

# Download Boost
ARG BOOST_VERSION=1_70_0
ARG BOOST_VERSION_DOT=1.70.0
ARG BOOST_HASH=430ae8354789de4fd19ee52f3b1f739e1fba576f0aded0897c3c2bc00fb38778
RUN set -ex \
    && curl -L -o  boost_${BOOST_VERSION}.tar.bz2 https://downloads.sourceforge.net/project/boost/boost/${BOOST_VERSION_DOT}/boost_${BOOST_VERSION}.tar.bz2 \
    &&  sha256sum boost_${BOOST_VERSION}.tar.bz2 \
    && echo "${BOOST_HASH}  boost_${BOOST_VERSION}.tar.bz2" | sha256sum -c\
    && tar -xvf boost_${BOOST_VERSION}.tar.bz2


# Download OpenSSL
ARG OPENSSL_VERSION_DOT=1.1.1n
ARG OPENSSL_HASH=40dceb51a4f6a5275bde0e6bf20ef4b91bfc32ed57c0552e2e8e15463372b17a

RUN curl https://www.openssl.org/source/openssl-${OPENSSL_VERSION_DOT}.tar.gz -OL \
    &&  sha256sum openssl-${OPENSSL_VERSION_DOT}.tar.gz \
    && echo "${OPENSSL_HASH} openssl-${OPENSSL_VERSION_DOT}.tar.gz" | sha256sum -c


# Compile CMake
RUN set -ex \
    && mkdir /opt/cmake \
    && sh cmake-3.15.5-Linux-x86_64.sh --prefix=/opt/cmake --skip-license\
    && ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake\
    && cmake --version\
    && rm cmake-3.15.5-Linux-x86_64.sh

# Compile Boost
RUN set -ex \
    && cd boost_${BOOST_VERSION} \
    && ./bootstrap.sh --with-libraries=system,filesystem,thread,date_time,chrono,regex,serialization,atomic,program_options,locale,timer,log \
    && ./b2
ENV BOOST_ROOT /root/boost_${BOOST_VERSION}

# Compile OpenSSL
RUN set -ex \
    && tar xaf openssl-${OPENSSL_VERSION_DOT}.tar.gz \
    && rm openssl-${OPENSSL_VERSION_DOT}.tar.gz \
    && cd openssl-${OPENSSL_VERSION_DOT} \
    && ./config --prefix=/root/openssl --openssldir=/root/openssl shared zlib \
    && make \
    && make test \
    && make install \
    && cd .. \
    && rm -rf openssl-${OPENSSL_VERSION_DOT}

ENV OPENSSL_ROOT_DIR=/root/openssl