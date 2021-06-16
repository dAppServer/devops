# Platform Agnostic Build Tool

The tool has a few aspects, for detailed instructions: https://build.lethean.help

## Docker Tags

### Lethean Build Images

* [lthn-chain-linux](https://hub.docker.com/r/lthn/build/tags?page=1&ordering=last_updated&name=lthn-chain-linux),
  [lthn-wallet-linux](https://hub.docker.com/r/lthn/build/tags?page=1&ordering=last_updated&name=lthn-wallet-linux),
  [lthn-wallet-windows](https://hub.docker.com/r/lthn/build/tags?page=1&ordering=last_updated&name=lthn-wallet-linux),
  [lthn-wallet-android](https://hub.docker.com/r/lthn/build/tags?page=1&ordering=last_updated&name=lthn-wallet-linux)
  
``` dockerfile
FROM lthn/build:lthn-chain-linux as build

RUN git clone --branch=master --depth=1 https://gitlab.com/lthn.io/projects/chain/lethean.git
    
WORKDIR /lethean

RUN make release-static

FROM lthn/build:base-ubuntu-20.04

COPY --from=build /lethean/build /tmp/build

ENTRYPOINT bash 
```

### Container Base Images

These are the base OS images, primed with "the basics" but not exactly tooling.

#### Ubuntu
*base-ubuntu* Will be the latest LTS
* [base-ubuntu](https://hub.docker.com/r/lthn/build/tags?page=1&ordering=last_updated&name=base-ubuntu),
  [base-ubuntu-16.04](https://hub.docker.com/r/lthn/build/tags?page=1&ordering=last_updated&name=base-ubuntu-16.04), 
  [base-ubuntu-18.04](https://hub.docker.com/r/lthn/build/tags?page=1&ordering=last_updated&name=base-ubuntu-18.04), 
  [base-ubuntu-20.04](https://hub.docker.com/r/lthn/build/tags?page=1&ordering=last_updated&name=base-ubuntu-20.04) 


