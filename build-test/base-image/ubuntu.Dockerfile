FROM lthn/build:base-ubuntu-16-04
RUN apt-get -y install make
# Demo Build
RUN git clone --branch=master --depth=1 https://gitlab.com/lthn.io/projects/chain/lethean.git

WORKDIR /lethean

RUN make release-static

FROM ubuntu:16.04

COPY --from=build /lethean/build /tmp/build

ENTRYPOINT bash