FROM lthn/build:compile as build

ARG THREADS=1
ARG BRANCH=next
ARG HOST=x86_64-w64-mingw32
ARG PACKAGE="g++-mingw-w64-x86-64 qttools5-dev-tools"
ARG GIT_REPO=https://gitlab.com/lthn.io/projects/chain/lethean.git
ARG BUILD_PATH=/lethean/chain/contrib/depends

RUN apt-get update && apt-get install -y ${PACKAGE}

RUN if [ ${HOST} = x86_64-w64-mingw32 ] || [ ${HOST} = i686-w64-mingw32 ]; then \
    update-alternatives --set ${HOST}-g++ $(which ${HOST}-g++-posix) && \
    update-alternatives --set ${HOST}-gcc $(which ${HOST}-gcc-posix); \
    fi

RUN git clone --depth 1 --branch ${BRANCH} ${GIT_REPO} && \
        make -j${THREADS} -C ${BUILD_PATH} HOST=${HOST}

FROM scratch as export-image
ARG HOST=x86_64-w64-mingw32
COPY --from=build /lethean/chain/contrib/depends/${HOST} /
COPY --from=build /lethean/chain/contrib/depends/built /
