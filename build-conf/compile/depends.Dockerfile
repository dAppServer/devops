FROM lthn/build:compile as build

ARG THREADS=1
ARG BRANCH=next
ARG CC_TARGET=g++-mingw-w64
ARG PACKAGE=x86_64-w64-mingw32

RUN apt-get update && apt-get install -y ${PACKAGE}

RUN git clone --depth 1 --branch ${BRANCH} https://gitlab.com/lthn.io/projects/chain/lethean.git && \
        cd lethean/chain && \
        cp -a contrib/depends / && \
        cd ../.. && \
        rm -rf lethean

RUN make -j$THREADS -C /depends HOST=${CC_TARGET}  NO_QT=1

FROM scratch as export-image
COPY --from=build /depends /
