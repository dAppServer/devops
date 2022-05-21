FROM lthn/build:compile as build

ARG BRANCH=main
ARG BUILD=osx
ARG GIT_REPO=https://github.com/Snider/blockchain.git
ARG BUILD_PATH=/build/contrib/depends

ENV PACKAGE=""

RUN git clone --depth 1 --branch ${BRANCH} ${GIT_REPO} && \
        make -C ${BUILD_PATH} download-${BUILD}

FROM scratch as export-image
COPY --from=build /build/contrib/depends/sources /
