Base images that are slightly more usable.

## Ubuntu

=== "16.04"

    ``` dockerfile
    FROM lthn/build:base-ubuntu-16.04 as build

    # Demo Build
    RUN git clone --branch=master --depth=1 https://gitlab.com/lthn.io/projects/chain/lethean.git
    
    WORKDIR /lethean

    RUN make release-static

    FROM ubuntu:16.04

    COPY --from=build /lethean/build /tmp/build

    ENTRYPOINT bash 
    ```
=== "18.04"

    ``` dockerfile
    FROM lthn/build:base-ubuntu-18.04 as build

    # Demo Build
    RUN git clone --branch=master --depth=1 https://gitlab.com/lthn.io/projects/chain/lethean.git
    
    WORKDIR /lethean

    RUN make release-static

    FROM ubuntu:18.04

    COPY --from=build /lethean/build /tmp/build

    ENTRYPOINT bash 
    ```

=== "20.04"

    ``` dockerfile
    FROM lthn/build:base-ubuntu-20.04 as build

    # Demo Build
    RUN git clone --branch=master --depth=1 https://gitlab.com/lthn.io/projects/chain/lethean.git
    
    WORKDIR /lethean

    RUN make release-static

    FROM ubuntu:20.04

    COPY --from=build /lethean/build /tmp/build

    ENTRYPOINT bash 
    ```
