ARG IMG_PREFIX=lthn
FROM ${IMG_PREFIX}/build:wallet-windows-base
ARG QT_VERSION=5.15.2
ARG THREADS=1
ENV SOURCE_DATE_EPOCH=1397818193


COPY --from=registry.gitlab.com/lthn.io/build:wallet-lib-windows-qt /depends /depends
COPY --from=registry.gitlab.com/lthn.io/build:wallet-lib-windows-libx /depends /depends
COPY --from=registry.gitlab.com/lthn.io/build:wallet-lib-windows-cmake /usr /usr