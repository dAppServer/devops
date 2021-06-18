FROM lthn/build:base-ubuntu-16-04

RUN apt-get install -y --no-install-recommends software-properties-common
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test
RUN apt-get update

RUN apt-get install --no-install-recommends -y gcc g++ gcc-6 g++-6 gcc-7 g++-7 gcc-8 g++-8 gcc-9 g++-9

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 80 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/gcov gcov /usr/bin/gcov-8
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 70 --slave /usr/bin/g++ g++ /usr/bin/g++-7 --slave /usr/bin/gcov gcov /usr/bin/gcov-7
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6 --slave /usr/bin/gcov gcov /usr/bin/gcov-6

RUN apt-get install -y --no-install-recommends  pkg-config libgtest-dev automake autoconf libtool-bin curl pkg-config \
    graphviz doxygen

#Cmake
ARG CMAKE_VERSION=3.11.4
ARG CMAKE_VERSION_DOT=v3.11
ARG CMAKE_HASH=8f864e9f78917de3e1483e256270daabc4a321741592c5b36af028e72bff87f5
RUN set -ex \
    && curl -s -O https://cmake.org/files/${CMAKE_VERSION_DOT}/cmake-${CMAKE_VERSION}.tar.gz \
    && echo "${CMAKE_HASH}  cmake-${CMAKE_VERSION}.tar.gz" | sha256sum -c \
    && tar -xzf cmake-${CMAKE_VERSION}.tar.gz \
    && cd cmake-${CMAKE_VERSION} \
    && ./configure \
    && make \
    && make install

# Readline
ARG READLINE_VERSION=7.0
ARG READLINE_HASH=750d437185286f40a369e1e4f4764eda932b9459b5ec9a731628393dd3d32334
RUN set -ex \
    && curl -s -O https://ftp.gnu.org/gnu/readline/readline-${READLINE_VERSION}.tar.gz \
    && echo "${READLINE_HASH}  readline-${READLINE_VERSION}.tar.gz" | sha256sum -c \
    && tar -xzf readline-${READLINE_VERSION}.tar.gz \
    && cd readline-${READLINE_VERSION} \
    && CFLAGS="-fPIC" CXXFLAGS="-fPIC" ./configure \
    && make \
    && make install