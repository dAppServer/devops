#!/usr/bin/env bash

echo "Starting Docker and sleeping for a few seconds"
dockerd-entrypoint.sh dockerd &>/dev/null &
sleep 5

echo "Lethean Builder Running Command \"$1\""
case $1 in
  "lthn/chain")
    shift
    rm src/.lthnkeep || echo "Could not delete .lthnkeep from build directory, not an error if this builds"
    git clone --branch master https://gitlab.com/lthn.io/projects/chain/lethean.git src || exit
    export DOCKER_IMAGE='lthn/chain'
    export BUILD_RESULT_PATH='/home/lthn/bin/chain'
    make build
    make eject-build
  ;;
  "lthn/wallet")
    shift
    rm src/.lthnkeep || echo "Could not delete .lthnkeep from build directory, not an error if this builds"
    git clone --branch master https://gitlab.com/lthn.io/projects/chain/wallet.git src || exit
    export DOCKER_IMAGE='lthn/wallet'
    export BUILD_RESULT_PATH='/home/lthn/bin/wallet'
    make build
    make eject-build
  ;;
  "lthn/vpn")
    shift
    rm src/.lthnkeep || echo "Could not delete .lthnkeep from build directory, not an error if this builds"
    git clone --branch master https://gitlab.com/lthn.io/projects/vpn/node.git src || exit
    export DOCKER_IMAGE='lthn/vpn'
    export BUILD_RESULT_PATH='/home/lthn/bin/vpn'
    make build
    make eject-build
  ;;

*)
  export BUILD_GIT_REPO="$*"
  make build-git
  make eject-build
  ;;

esac
