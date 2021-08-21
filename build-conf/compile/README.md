# Compile images

These docker images create linux environment that is able to cross-compile for any arch.

We are using ubuntu trusty for the build stage, each image exports the build assets to a blank fs.

Rather than asking people to repeat this prep step, we host all the images on Docker Hub.

- `lthn/build:compile` Base OS with packages needed to compile linux binaries
- `lthn/build:depends-x86_64-w64-mingw32` precompiled Libs to make Windows 64
- `lthn/build:depends-i686-w64-mingw32` precompiled libs to make Windows 32
- `lthn/build:depends-arm-linux-gnueabihf` precompiled libs to make Linux ARM 32 bit
- `lthn/build:depends-aarch64-linux-gnu` precompiled libs to make Linux ARM 64 bit
- `lthn/build:depends-riscv64-linux-gnu` precompiled libs to make Linux RISCV 64 bit
- `lthn/build:depends-x86_64-apple-darwin11`precompiled libs to make MacOSX

## Using the precompiled assets

```dockerfile
FROM lthn/build:compile as build

WORKDIR /lethean

COPY . .
WORKDIR /lethean/chain
ENV USE_SINGLE_BUILDDIR=1
ARG THREADS=1

RUN git submodule update --init --force --depth 1

COPY --from=lthn/build:depends-arm-linux-gnueabihf / /lethean/chain/contrib/depends

RUN make depends target=arm-linux-gnueabihf -j${THREADS} 
    

FROM scratch as export-image
COPY --from=builder /lethean/chain/build/release/bin/ /
```

Run the above Dockerfile using the -o flag to export the 'export-image' stage to your local directory.

`docker build -t lthn/wallet:arm-32 -o artifacts .`