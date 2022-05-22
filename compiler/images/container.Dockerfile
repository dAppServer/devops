FROM lthn/build:compile as x86_64-unknown-linux-gnu
COPY --from=lthn/build-depends-x86_64-unknown-linux-gnu /lethean/depends/x86_64-unknown-linux-gnu /

FROM lthn/build:compile as x86_64-apple-darwin11
COPY --from=lthn/build-depends-x86_64-apple-darwin11 /lethean/depends/x86_64-apple-darwin11 /

FROM lthn/build:compile as x86_64-apple-darwin
COPY --from=lthn/build-depends-x86_64-apple-darwin /lethean/depends/x86_64-apple-darwin /

# x86_64-pc-linux-gnu for x86 Linux
FROM lthn/build:compile as x86_64-pc-linux-gnu
COPY --from=lthn/build-depends-x86_64-pc-linux-gnu /lethean/depends/x86_64-pc-linux-gnu /

# i686-pc-linux-gnu for Linux 32 bit
FROM lthn/build:compile as i686-pc-linux-gnu
COPY --from=lthn/build-depends-i686-pc-linux-gnu /lethean/depends/i686-pc-linux-gnu /

FROM lthn/build:compile as x86_64-unknown-freebsd
COPY --from=lthn/build-depends-x86_64-unknown-freebsd /lethean/depends/x86_64-unknown-freebsd /

# x86_64-w64-mingw32 for Win64
FROM lthn/build:compile as x86_64-w64-mingw32
COPY --from=lthn/build-depends-x86_64-w64-mingw32 /lethean/depends/x86_64-w64-mingw32 /

# x86_64-apple-darwin for macOS
FROM lthn/build:compile as x86_64-apple-darwin
COPY --from=lthn/build-depends-x86_64-apple-darwin /lethean/depends/x86_64-apple-darwin /

# aarch64-linux-gnu for Linux ARM 64 bit
FROM lthn/build:compile as aarch64-linux-gnu
COPY --from=lthn/build-depends-aarch64-linux-gnu /lethean/depends/aarch64-linux-gnu /

# arm-linux-gnueabihf for Linux ARM 32 bit
FROM lthn/build:compile as arm-linux-gnueabihf
COPY --from=lthn/build-depends-arm-linux-gnueabihf /lethean/depends/arm-linux-gnueabihf /

# powerpc64-linux-gnu for Linux POWER 64-bit (big endian)
FROM lthn/build:compile as powerpc64-linux-gnu
COPY --from=lthn/build-depends-powerpc64-linux-gnu /lethean/depends/powerpc64-linux-gnu /

# powerpc64le-linux-gnu for Linux POWER 64-bit (little endian)
FROM lthn/build:compile as powerpc64le-linux-gnu
COPY --from=lthn/build-depends-powerpc64le-linux-gnu /lethean/depends/powerpc64le-linux-gnu /

# riscv32-linux-gnu for Linux RISC-V 32 bit
FROM lthn/build:compile as riscv32-linux-gnu
COPY --from=lthn/build-depends-riscv32-linux-gnu /lethean/depends/riscv32-linux-gnu /

# riscv64-linux-gnu for Linux RISC-V 64 bit
FROM lthn/build:compile as riscv64-linux-gnu
COPY --from=lthn/build-depends-riscv64-linux-gnu /lethean/depends/riscv64-linux-gnu /

# s390x-linux-gnu for Linux S390X
FROM lthn/build:compile as s390x-linux-gnu
COPY --from=lthn/build-depends-s390x-linux-gnu /lethean/depends/s390x-linux-gnu /

# armv7a-linux-android for Android ARM 32 bit
FROM lthn/build:compile as armv7a-linux-android
COPY --from=lthn/build-depends-armv7a-linux-android /lethean/depends/armv7a-linux-android /

# aarch64-linux-android for Android ARM 64 bit
FROM lthn/build:compile as aarch64-linux-android
COPY --from=lthn/build-depends-aarch64-linux-android /lethean/depends/aarch64-linux-android /

# i686-linux-android for Android x86 32 bit
FROM lthn/build:compile as i686-linux-android
COPY --from=lthn/build-depends-i686-linux-android /lethean/depends/i686-linux-android /

# x86_64-linux-android for Android x86 64 bit
FROM lthn/build:compile as x86_64-linux-android
COPY --from=lthn/build-depends-x86_64-linux-android /build/depends/x86_64-linux-android /
