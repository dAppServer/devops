FROM lthn/build:lthn-compile-base

ENV THREADS=1
ARG QT_VERSION=5.15.2
ENV SOURCE_DATE_EPOCH=1397818193

RUN apt-get update && apt-get install -y  g++-mingw-w64 && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --set x86_64-w64-mingw32-g++ $(which x86_64-w64-mingw32-g++-posix) && \
    update-alternatives --set x86_64-w64-mingw32-gcc $(which x86_64-w64-mingw32-gcc-posix)

RUN git clone --depth 1 --recursive --branch next https://gitlab.com/lthn.io/projects/chain/lethean.git && \
    make -j$THREADS -C /lethean/chain/contrib/depends HOST=x86_64-w64-mingw32


CMD cd lethean/chain && make depends target=x86_64-w64-mingw32 tag=win-x64 -j$THREADS ;