# syntax=docker/dockerfile:1
FROM lthn/build:compile as builder

ARG THREADS=1
ARG BRANCH=master
ARG BUILD=x86_64-w64-mingw32
ARG GIT_REPO=https://github.com/Snider/blockchain.git
ARG BUILD_PATH=/build/contrib/depends

COPY --from=lthn/build:sources-linux /output.tar.gz /cache/linux
COPY --from=lthn/build:sources-win /output.tar.gz /cache/win
COPY --from=lthn/build:sources-osx /output.tar.gz /cache/osx

## Clone depends for the project
RUN  if [ !-f "/build/Makefile" ]; then \
            git clone --depth 1 --recursive --branch ${BRANCH} ${GIT_REPO} /src \
            && cp -R /src/contrib/depends /depends; \
        fi

WORKDIR /build
ENV PACKAGE=""
RUN case ${BUILD} in \
    x86_64-unknown-linux-gnu) \
     PACKAGE="gperf cmake python3-zmq libdbus-1-dev libharfbuzz-dev"; \
      cp -r /cache/linux /depends/sources; \
    ;; \
    i686-pc-linux-gnu) \
     PACKAGE="gperf cmake g++-multilib python3-zmq"; \
     cp -r /cache/linux /depends/sources; \
    ;; \
    arm-linux-gnueabihf) \
     PACKAGE="python3 gperf g++-arm-linux-gnueabihf"; \
     cp -r /cache/linux /depends/sources; \
    ;; \
    aarch64-linux-gnu) \
     PACKAGE="python3 gperf g++-aarch64-linux-gnu"; \
     cp -r /cache/linux /depends/sources; \
    ;; \
    x86_64-w64-mingw32) \
     PACKAGE="cmake python3 g++-mingw-w64-x86-64 qttools5-dev-tools"; \
    cp -r /cache/win /depends/sources; \
    ;; \
    i686-w64-mingw32) \
     PACKAGE="python3 g++-mingw-w64-i686 qttools5-dev-tools"; \
      cp -r /cache/win /depends/sources; \
    ;; \
    riscv64-linux-gnu) \
     PACKAGE="python3 gperf g++-riscv64-linux-gnu"; \
     cp -r /cache/linux /depends/sources; \
    ;; \
    x86_64-unknown-freebsd) \
     PACKAGE="clang-8 gperf cmake python3-zmq libdbus-1-dev libharfbuzz-dev"; \
     cp -r /cache/linux /depends/sources; \
    ;; \
    esac \
    && apt-get update && apt-get install -y $PACKAGE;

# windows CC
RUN if [ ${BUILD} = x86_64-w64-mingw32 ] || [ ${BUILD} = i686-w64-mingw32 ]; then \
    update-alternatives --set ${BUILD}-g++ $(which ${BUILD}-g++-posix) && \
    update-alternatives --set ${BUILD}-gcc $(which ${BUILD}-gcc-posix); \
    fi

ENV BUILD_TARGET=${BUILD}
ENV BUILD_THREADS=1
ENV CCACHE_SIZE=100M
ENV CCACHE_TEMPDIR=/tmp/.ccache-temp
ENV CCACHE_COMPRESS=1
ENV CCACHE_DIR=/ccache

RUN pwd && mem_avail_gb=$(( $(getconf _AVPHYS_PAGES) * $(getconf PAGE_SIZE) / (1024 * 1024 * 1024) )) &&\
            make_job_slots=$(( $mem_avail_gb < 4 ? 1 : $mem_avail_gb / 4)) &&\
            echo make_job_slots=$make_job_slots &&\
            set -x &&\
            make -j $make_job_slots -C ${BUILD_PATH} HOST=${BUILD}

RUN pwd && mem_avail_gb=$(( $(getconf _AVPHYS_PAGES) * $(getconf PAGE_SIZE) / (1024 * 1024 * 1024) )) &&\
        make_job_slots=$(( $mem_avail_gb < 4 ? 1 : $mem_avail_gb / 4)) &&\
        echo make_job_slots=$make_job_slots &&\
        set -x &&\
        if [ -f "/build/Makefile" ]; then \
         (cd /build && git submodule update --init --depth 1); \
    fi && \
    make -j $make_job_slots depends target=${BUILD_TARGET} && \
    mkdir -p /build/dist/${BUILD_TARGET} && \
    mv -f /build/build/release/bin/* /build/dist/${BUILD_TARGET};

ONBUILD ADD --from=builder /depends/built /build/contrib/depends/built

CMD pwd && mem_avail_gb=$(( $(getconf _AVPHYS_PAGES) * $(getconf PAGE_SIZE) / (1024 * 1024 * 1024) )) &&\
            make_job_slots=$(( $mem_avail_gb < 4 ? 1 : $mem_avail_gb / 4)) &&\
            echo make_job_slots=$make_job_slots &&\
            set -x &&\
            make depends -j $make_job_slots target=${BUILD_TARGET}