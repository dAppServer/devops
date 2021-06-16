# Configuration Values
```makefile
DOCKER_COMPOSE ?= ./src/docker-compose.yml
DOCKER_FILE ?= ./Dockerfile
K8_BUILD_DIR ?= ./build-dist/dist/k8
DOCKER_IMAGE ?= lthn/build
BUILD_RESULT_PATH ?= /home/build/build
BUILD_GIT_REPO ?= "https://gitlab.com/lthn.io/projects/sdk/build.git#master"

# Internal Behaviour Settings
DOCKER_NAME_NORMALISED ?= lthn-$(subst /,-,$(DOCKER_IMAGE))
```