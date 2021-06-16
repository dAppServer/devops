# Interactions

These are used internally.

## run-docker

=== "Command"

    ``` shell
    docker run --privileged -v $(pwd):/home/build/dist -it lthn/build run-docker
    ```

=== "Action"

    ``` dockerfile
    docker run --name "$(DOCKER_NAME_NORMALISED)" -d "$(DOCKER_IMAGE)"
    ```

## stop-docker

=== "Command"

    ``` shell
    docker run --privileged -v $(pwd):/home/build/dist -it lthn/build stop-docker
    ```

=== "Action"

    ``` dockerfile
    docker stop "$(DOCKER_NAME_NORMALISED)"
    ```

## clean-docker

=== "Command"

    ``` shell
    docker run --privileged -v $(pwd):/home/build/dist -it lthn/build clean-docker
    ```

=== "Action"

    ``` dockerfile
    docker rm "$(DOCKER_NAME_NORMALISED)" && docker rmi "$(DOCKER_IMAGE)"
    ```

## eject-docker


=== "Command"

    ``` shell
    docker run --privileged -v $(pwd):/home/build/dist -it lthn/build eject-docker
    ```

=== "Action"

    ``` dockerfile
    docker cp "$(DOCKER_NAME_NORMALISED)":"$(BUILD_RESULT_PATH)" ./dist
    ```

## check-docker

=== "Command"

    ``` shell
    docker run --privileged -v $(pwd):/home/build/dist -it lthn/build check-docker
    ```

=== "Action"

    ``` dockerfile
    docker stats || exit
    ```