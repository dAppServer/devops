FROM lthn/build:compile as build

ARG THREADS=1
ARG BRANCH=next
ARG HOST=x86_64-w64-mingw32
ARG PACKAGE="g++-mingw-w64-x86-64 qttools5-dev-tools"
ARG GIT_REPO=https://gitlab.com/lthn.io/projects/chain/lethean.git
ARG BUILD_PATH=/lethean/chain/contrib/depends

RUN apt-get update && apt-get install -y ${PACKAGE}

RUN if [ ${HOST} = *-mingw32 ]; then \
    update-alternatives --set ${HOST}-g++ $(which ${HOST}-g++-posix) && \
    update-alternatives --set ${HOST}-gcc $(which ${HOST}-gcc-posix); \
    fi

ENV CCACHE_COMPRESS=1
ENV CCACHE_DIR=/lethean/chain/contrib/depends/${HOST}/.ccache
ENV CCACHE_SIZE=100M
ENV CCACHE_TEMPDIR=/tmp/.ccache-temp

RUN git clone --depth 1 --branch ${BRANCH} ${GIT_REPO} && \
        make -j${THREADS} -C ${BUILD_PATH} HOST=${HOST}  NO_QT=1

FROM scratch as export-image
COPY --from=build /lethean/chain/contrib/depends /
