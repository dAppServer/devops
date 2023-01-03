#!/usr/bin/env bash
# shellcheck shell=bash

# Check for iTw3
if [ ! -d "blockchain/itw3" ]; then
  echo "Cloning iTw3 Blockchain"
  git clone --recursive --branch=main --depth=1 https://github.com/letheanVPN/blockchain-iTw3.git blockchain/itw3
else
  echo "Updating iTw3 Blockchain"
  rm -rf blockchain/bin/itw3* || true
  (cd blockchain/itw3 && git pull)
fi

if [ ! -f "blockchain/bin/itw3d" ]; then
  echo "Building iTw3 Blockchain"
  cd blockchain/itw3 || exit
  make release-testnet -j2
#  make ci-release
  mv build/release/bin/* ../../blockchain/bin
  cd ../../
fi

mkdir -p data/itw3/testnet

echo "FIN"