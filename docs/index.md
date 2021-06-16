# Host Platform Agnostic Build Tool

Our build system is a framework that allows any project to utilise and automate derivative docker base images via CI Pipelines

Without additional work, all users of the project get access to platform agnostic, dev tools, one line commands that are simple and not confusing to document

## Why?

Compiling is easy, it should "just work", they said, it will be fun they said!

it's now 10 hours later, you're questioning if you have the IQ to classify as a human,
the README has broken your mouse finger... then in confused tiredness you just replaced a system library with a version that breaks your world.

Lethean Builder, true to the meaning of "Lethean", to forget; is a forgetful & private builder that abstracts all that geeky stuff for a few reasons: `performance`, `security` & `Compute Reuse(e.g being kinder to the planet)`.

compiling takes time, uses power, it's also wasteful when repeated for no real reason, but most solutions to this get complicated, Dockerfiles are the easy way.

### Caching

Most projects get you to compile your own assets, then you have to recompile, often (in docker land or just when switching versions).
using our builder, and some adjustments with settings we can do a full compile of our blockchain in just under 2 minutes, or about 15 minutes without pushing limits.

The layers here enable us to deliver fast builds in an acceptable timeframe, instantiated from a terminal or script, on a framework that can be customised to compile literally anything with all options fully exposed and customisable.

### Security


When you are compiling code, you are trusting the author of the code to not do something like install a virus.

Our builder is an 84 MB Alpine linux image, it starts an internal docker daemon and passes build commands to the internal daemon.

Once the task is complete, we run the image and extract the build assets with a simple file copy and store the result of that in the mounted directory.

This enables you to run builds with docker in an isolated context, it is not the way to use docker, don't copy my docker abuse, this is a build tool.

### Compute Reuse
 
It is wasteful to ask N+1 users to do the same task, using checksums we can prove if some code is safe to compile or use.

If the source code is the same as the published checksum, the resulting compile checksum is the same and verified by a trusted source.

Why redo what others have already done? Thousands of hours wasted, the base functionality to provide this comes as standard with Docker. 

# Quick Start

## Builder Service

The builder requires some environment variables set, for lethean projects you can just ask for the project with its
docker tag

* Chain `docker run --privileged -v $(pwd):/home/build/dist -it lthn/build lthn/chain`
* Vpn `docker run --privileged -v $(pwd):/home/build/dist -it lthn/build lthn/vpn`
* Wallet `docker run --privileged -v $(pwd):/home/build/dist -it lthn/build lthn/wallet`

## As a Base image

These are pre-configured base images for lethean projects with everything you need preinstalled for that project

```dockerfile
# Starts a new file system, any layers before are discarded 
FROM lthn/build as build
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
