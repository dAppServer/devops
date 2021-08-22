FROM lthn/build:compile as build

ARG THREADS=20
ARG BRANCH=next
ARG BUILD=x86_64-w64-mingw32
ARG GIT_REPO=https://gitlab.com/lthn.io/projects/chain/lethean.git
ARG BUILD_PATH=/lethean/chain/contrib/depends

ENV PACKAGE=""
RUN case ${BUILD} in \
    x86_64-unknown-linux-gnu) \
     PACKAGE="gperf cmake python3-zmq libdbus-1-dev libharfbuzz-dev"; \
    ;; \
    i686-pc-linux-gnu) \
     PACKAGE="gperf cmake g++-multilib python3-zmq"; \
    ;; \
    arm-linux-gnueabihf) \
     PACKAGE="python3 gperf g++-arm-linux-gnueabihf"; \
    ;; \
    aarch64-linux-gnu) \
     PACKAGE="python3 gperf g++-aarch64-linux-gnu"; \
    ;; \
    x86_64-w64-mingw32) \
     PACKAGE="cmake python3 g++-mingw-w64-x86-64 qttools5-dev-tools"; \
    ;; \
    i686-w64-mingw32) \
     PACKAGE="python3 g++-mingw-w64-i686 qttools5-dev-tools"; \
    ;; \
    riscv64-linux-gnu) \
     PACKAGE="python3 gperf g++-riscv64-linux-gnu"; \
    ;; \
    x86_64-unknown-freebsd) \
     PACKAGE="clang-8 gperf cmake python3-zmq libdbus-1-dev libharfbuzz-dev"; \
    ;; \
    esac \
    && apt-get update && apt-get install -y $PACKAGE;


RUN if [ ${BUILD} = x86_64-w64-mingw32 ] || [ ${BUILD} = i686-w64-mingw32 ]; then \
    update-alternatives --set ${BUILD}-g++ $(which ${BUILD}-g++-posix) && \
    update-alternatives --set ${BUILD}-gcc $(which ${BUILD}-gcc-posix); \
    fi

RUN git clone --depth 1 --branch ${BRANCH} ${GIT_REPO} && \
        make -j${THREADS} -C ${BUILD_PATH} HOST=${BUILD}

FROM scratch as export-image
COPY --from=build /lethean/chain/contrib/depends/built /built
