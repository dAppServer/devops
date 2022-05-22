# syntax=docker/dockerfile:1
FROM lthn/build:compile as build

ARG BRANCH=master
ARG BUILD=osx
ARG GIT_REPO=https://github.com/Snider/blockchain.git
ARG BUILD_PATH=/build/contrib/depends

ENV PACKAGE=""

RUN git clone --depth 1 --branch ${BRANCH} ${GIT_REPO} /build && \
    pwd && mem_avail_gb=$(( $(getconf _AVPHYS_PAGES) * $(getconf PAGE_SIZE) / (1024 * 1024 * 1024) )) &&\
            make_job_slots=$(( $mem_avail_gb < 4 ? 1 : $mem_avail_gb / 4)) &&\
            echo make_job_slots=$make_job_slots &&\
            set -x &&\
        make -j $make_job_slots -C ${BUILD_PATH} download-${BUILD}

FROM scratch as export-image
COPY --from=build /build/contrib/depends/sources /output.tar.gz
