# Lethean Docker Builder

This is the source repository for: https://hub.docker.com/r/lthn/build

For instructions please see: https://build.lethean.help

# Quick Start

## Builder Service

The builder requires some environment variables set, for lethean projects you can just ask for the project with its
docker tag

* Chain `docker run --privileged -v $(pwd):/home/build/dist -it lthn/build lthn/chain`
* Vpn `docker run --privileged -v $(pwd):/home/build/dist -it lthn/build lthn/vpn`
* Wallet `docker run --privileged -v $(pwd):/home/build/dist -it lthn/build lthn/wallet`

### Building Git Repos

To compile a repo with `make` from its url and have the build returned to you in your working directory

*Linux/Mac*

`docker run --privileged -v $(pwd):/home/build/dist -it lthn/build compile https://gitlab.com/lthn.io/projects/chain/lethean.git`

*Windows:(i think~ will remove when tested)*

`docker run --privileged -v %cd%:/home/build/dist -it lthn/build compile https://gitlab.com/lthn.io/projects/chain/lethean.git`

### Sandboxed Docker image Build

As docker lets you build a docker image with a git url, this lets you populate internal docker from git.

`docker run --privileged -v $(pwd):/home/build/dist -it lthn/build https://github.com/monero-project/monero.git`

## As a Base image

These are pre-configured base images for lethean projects with everything you need preinstalled for that project

```dockerfile
# Starts a new file system, any layers before are discarded 
FROM lthn/build:chain-linux as build
# demo sakes, use any location
WORKDIR /src
# this takes the build context and puts it into /src
COPY . .
# run the make file
RUN make release
# Built, simples. Let's make a new image layer to remove development libs
FROM ubuntu:16.04
# --from=build lets you take from the previous layer, its still there while we build
COPY --from=build /src/build/release/bin /home/lthn/cli
# Done. 
ENTRYPOINT bash 
```

