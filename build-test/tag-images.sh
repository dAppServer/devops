#!/usr/bin/env bash

export CI_REGISTRY_IMAGE='lthn.io/projects/sdk/build'
export CI_REGISTRY='registry.gitlab.com'
export DOCKER_REGISTRY='docker.io'
export DOCKER_REGISTRY_IMAGE='lthn/build'

docker pull ${CI_REGISTRY_IMAGE} -a
docker images ${CI_REGISTRY_IMAGE} --filter "since=${DOCKER_REGISTRY}/${DOCKER_REGISTRY_IMAGE}"  --format "docker tag {{.Repository}}:{{.Tag}} ${DOCKER_REGISTRY}/{{.Repository}}:{{.Tag}} | docker push ${DOCKER_REGISTRY}/{{.Repository}}:{{.Tag}}" | echo
