FROM lthn/build:lthn-compile-base

ENV THREADS=1
ARG QT_VERSION=5.15.2
ENV SOURCE_DATE_EPOCH=1397818193

RUN apt-get update && apt-get install -y  g++-arm-linux-gnueabihf gcc-arm-linux-gnueabihf

RUN git clone --depth 1 --recursive --branch next https://gitlab.com/lthn.io/projects/chain/lethean.git && \
    make -j$THREADS -C /lethean/chain/contrib/depends HOST=arm-linux-gnueabihf


CMD cd lethean/chain && make depends target=arm-linux-gnueabihf -j$THREADS ;