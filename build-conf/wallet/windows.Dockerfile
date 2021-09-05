ARG IMG_PREFIX=lthn
FROM ${IMG_PREFIX}/build:wallet-windows-base
ARG QT_VERSION=5.15.2
ARG THREADS=1
ENV BRANCH=next
ENV SOURCE_DATE_EPOCH=1397818193


COPY --from=registry.gitlab.com/lthn.io/projects/sdk/build:wallet-lib-windows-qt / /depends
COPY --from=registry.gitlab.com/lthn.io/projects/sdk/build:wallet-lib-windows-libx / /depends
COPY --from=lthn/build:wallet-lib-windows-cmake / /usr/bin

CMD git clone --branch ${BRANCH} --recursive --depth 1 https://gitlab.com/lthn.io/projects/chain/wallet-gui.git \
    && cd /wallet-gui && make depends root=/depends target=x86_64-w64-mingw32 tag=win-x64 -j${THREADS}