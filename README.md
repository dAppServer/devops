# Compile images

- `lthn/build:compile` Compile base image

## x86_64

- `lthn/build:depends-x86_64-w64-mingw32` precompiled Libs to make Windows 64
- `lthn/build:depends-x86_64-apple-darwin11` MacOSX
- `lthn/build:depends-x86_64-unknown-linux-gnu` Linux 64
- `lthn/build:depends-x86_64-unknown-freebsd`  FreeBSD 64

## i686 

- `lthn/build:depends-i686-pc-linux-gnu` Linux 32
- `lthn/build:depends-i686-w64-mingw32` Windows 32

## ARM

- `lthn/build:depends-arm-linux-gnueabihf` Linux ARM 32 bit
- `lthn/build:depends-aarch64-linux-gnu` Linux ARM 64 bit

## RISCV

- `lthn/build:depends-riscv64-linux-gnu` RISCV 64 bit

## Using the precompiled assets

```dockerfile
FROM lthn/build:compile as build

WORKDIR /lethean

COPY . .
COPY --from=lthn/build:depends-riscv64-linux-gnu --chown=root:root / /lethean/chain/contrib/depends

ARG THREADS=1

RUN git submodule update --init --force --depth 1

RUN make -j${THREADS} -C /lethean/chain depends target=riscv64-linux-gnu
    

FROM scratch as export-image
COPY --from=builder /lethean/chain/build/release/bin/ /
```

Run the above Dockerfile using the -o flag to export the 'export-image' stage to your local directory.

`docker build -t lthn/chain:riscv64-linux-gnu -o artifacts .`


