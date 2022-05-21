#!/usr/bin/env bash

function start_docker() {
  echo "Starting Docker and sleeping for a few seconds"
  dockerd-entrypoint.sh dockerd &>/dev/null &
  sleep 5
}

echo "Lethean Builder Running Command \"$1\""
case $1 in
"lthn/chain")
  shift
  rm src/.lthnkeep || echo "Could not delete .lthnkeep from build directory, not an error if this builds"
  git clone --depth=1 --branch master https://gitlab.com/lthn.io/projects/chain/lethean.git src || exit
  export DOCKER_IMAGE='lthn/chain'
  export BUILD_RESULT_PATH='/home/lthn/bin/chain'
  start_docker
  make build
  make eject-build
  ;;
"lthn/wallet")
  shift
  rm src/.lthnkeep || echo "Could not delete .lthnkeep from build directory, not an error if this builds"
  git clone --depth=1 --branch master https://gitlab.com/lthn.io/projects/chain/wallet.git src || exit
  export DOCKER_IMAGE='lthn/wallet'
  export BUILD_RESULT_PATH='/home/lthn/wallet/build/release/bin/'
  start_docker
  make build
  make eject-build
  ;;
"lthn/vpn")
  shift
  rm src/.lthnkeep || echo "Could not delete .lthnkeep from build directory, not an error if this builds"
  git clone --depth=1 --branch master https://gitlab.com/lthn.io/projects/vpn/node.git src || exit
  export DOCKER_IMAGE='lthn/vpn'
  export BUILD_RESULT_PATH='/home/lthn/bin/vpn'
  start_docker
  make build
  make eject-build
  ;;
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
