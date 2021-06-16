# Building

Compiles the project and copies the build assets to the mount point

## Lethean Blockchain

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

## Compiling Another Project: Monero

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