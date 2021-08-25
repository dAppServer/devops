FROM lthn/build:wallet-base as xorgproto
ARG THREADS=1
RUN git clone -b xorgproto-2020.1 --depth 1 https://gitlab.freedesktop.org/xorg/proto/xorgproto && \
    cd xorgproto && \
    git reset --hard c62e8203402cafafa5ba0357b6d1c019156c9f36 && \
    ./autogen.sh && \
    make -j$THREADS && \
    make -j$THREADS install