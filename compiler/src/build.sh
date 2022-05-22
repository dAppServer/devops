#!/usr/bin/env bash

function start_docker() {
  echo "Starting Docker and sleeping for a few seconds"
  dockerd-entrypoint.sh dockerd &>/dev/null &
  sleep 5
}

echo "Builder Running Command \"$1\""
case $1 in


"c" | "compile")
  shift
  rm src/.lthnkeep || echo "Could not delete .lthnkeep from build directory, not an error if this builds"
  export BUILD_GIT_REPO="$*"
  export DOCKER_IMAGE='compile'
  export BUILD_RESULT_PATH='/compile/build'
  git clone --depth=1 --branch master --recurse-submodules "${BUILD_GIT_REPO}" src || exit
  start_docker
  make build
  make eject-build
  ;;
"b" | "build")
  shift
  export BUILD_GIT_REPO="$*"
  start_docker
  make build-git
  make eject-build
  ;;
"bash")
  /usr/bin/env bash
  ;;
"sh")
  /usr/bin/env sh
  ;;
"ci-scan")
  rm src/.lthnkeep || echo "Could not delete .lthnkeep from build directory, not an error if this builds"
  export BUILD_GIT_REPO="$*"
  git clone --depth=1 --branch master --recurse-submodules "${BUILD_GIT_REPO}" src || exit
  cd src
  make release-static
  ;;
*)
  rm src/.lthnkeep || echo "Could not delete .lthnkeep from build directory, not an error if this builds"
  export BUILD_GIT_REPO="$*"
  git clone --depth=1 --branch master --recurse-submodules "${BUILD_GIT_REPO}" src || exit
  start_docker
  make build
  make eject-build
  ;;

esac
