## build

Performs an internal docker build

=== "Command"

    ``` shell
    docker run --privileged -v $(pwd):/home/build/dist -it lthn/build build
    ```

=== "Action"

    ``` dockerfile
    docker build -f "$(DOCKER_FILE)" -t "$(DOCKER_IMAGE)" src || exit
    ```

## build-git

Builds a internal docker image from git url

=== "Command"

    ``` shell
    docker run --privileged -v $(pwd):/home/build/dist -it lthn/build build-git
    ```

=== "Action"

    ``` dockerfile
    docker build -t "$(DOCKER_IMAGE)" ${BUILD_GIT_REPO} || exit
    ```

## compile-git

This never gets called direct, runs a `make` on the folder src which has been pre cloned by the builds at this point.

=== "Command"

    ``` shell
    docker run --privileged -v $(pwd):/home/build/dist -it lthn/build compile-git
    ```

=== "Action"

    ``` dockerfile
    docker build -f "$(DOCKER_FILE)" -t "$(DOCKER_IMAGE)" src || exit
    ```

## eject-build

Takes the build result and extracts the files.

=== "Command"

    ``` shell
    docker run --privileged -v $(pwd):/home/build/dist -it lthn/build eject-build
    ```

=== "Action"

    ``` dockerfile
    docker run --name "$(DOCKER_NAME_NORMALISED)" -d "$(DOCKER_IMAGE)"
    docker cp "$(DOCKER_NAME_NORMALISED)":"$(BUILD_RESULT_PATH)" ./dist
    docker stop "$(DOCKER_NAME_NORMALISED)"
    docker rm "$(DOCKER_NAME_NORMALISED)" && docker rmi "$(DOCKER_IMAGE)"
    echo "Ejected Build to ${BUILD_RESULT_PATH}"
    ```


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