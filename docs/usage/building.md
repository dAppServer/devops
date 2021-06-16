Compiles the project and copies the build assets to the mount point

### Lethean Blockchain

=== "Windows"

    ``` shell
    docker run --privileged -v %cd%:/home/build/dist -it lthn/build lthn/chain
    ```

=== "Linux"

    ``` shell
    docker run --privileged -v $(pwd):/home/build/dist -it lthn/build lthn/chain
    ```

=== "Mac"

    ``` shell
    docker run --privileged -v $(pwd):/home/build/dist -it lthn/build lthn/chain
    ```

### Compiling Another Project: Monero

=== "Windows"

    ``` shell
    docker run --privileged -v %cd%:/home/build/dist -it lthn/build compile https://github.com/monero-project/monero.git
    ```

=== "Linux"

    ``` shell
    docker run --privileged -v $(pwd):/home/build/dist -it lthn/build compile https://github.com/monero-project/monero.git
    ```

=== "Mac"

    ``` shell
    docker run --privileged -v $(pwd):/home/build/dist -it lthn/build compile https://github.com/monero-project/monero.git
    ```
## Base Images

=== "Blockchain"

    ```dockerfile
    # Starts a new file system, any layers before are discarded 
    FROM lthn/build:chain-linux as build
    # demo sakes, use any location
    WORKDIR /src
    # this takes the build context and puts it into /src
    COPY . .
    # run the make file
    RUN make release-static
    # Built, simples. Let's make a new image layer to remove development libs
    FROM ubuntu:16.04
    # --from=build lets you take from the previous layer, its still there while we build
    COPY --from=build /src/build/release/bin /usr/bin
    RUN chmod +x /user/bin/lethean-*
    # Done. 
    ENTRYPOINT bash 
    ```
