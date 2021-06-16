# Platform Agnostic Build Tool

This is the source repository for: https://hub.docker.com/r/lthn/build

For instructions please see: https://build.lethean.help


## As a Base image

These are pre-configured base images for lethean projects with everything you need preinstalled for that project

```dockerfile
# Starts a new file system, any layers before are discarded 
FROM lthn/build:base-ubuntu-16.04 as build
# demo sakes, use any location
WORKDIR /src
# this takes the build context and puts it into /src
COPY . .
# run the make file
RUN make release
# Built, simples. Let's make a new image layer to remove development libs
FROM lthn/build:base-ubuntu-20.04 as image
# --from=build lets you take from the previous layer, its still there while we build
COPY --from=build /src/build/release/bin /home/lthn/cli
# Done. 
ENTRYPOINT bash 
```

