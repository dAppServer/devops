#!/usr/bin/env bash
# shellcheck shell=bash

# Check for Lethean
if [ ! -d "blockchain/lthn" ]; then
  echo "Cloning Lethean Blockchain"
  git clone --recursive --depth=1 https://github.com/letheanVPN/blockchain-iz.git blockchain/lthn
else
  echo "Updating Lethean Blockchain"
  (cd blockchain/lthn && git pull)
fi

# Check for WrkzCoin
if [ ! -d "blockchain/wrkz" ]; then
  echo "Cloning WrkzCoin Blockchain"
  git clone --recursive --depth=1 https://github.com/wrkzcoin/wrkzcoin.git blockchain/wrkz
else
  echo "Updating WrkzCoin Blockchain"
  (cd blockchain/wrkz && git pull)
fi

# Check for iTw3
if [ ! -d "blockchain/itw3" ]; then
  echo "Cloning iTw3 Blockchain"
  git clone --recursive --depth=1 https://github.com/dAppServer/itw3.git blockchain/itw3
else
  echo "Updating iTw3 Blockchain"
  (cd blockchain/itw3 && git pull)
fi


if [ ! -f "blockchain/bin/lthn/letheand" ]; then
  echo "Building Lethean Blockchain"
  mkdir -p blockchain/bin/lthn
  cd blockchain/lthn || exit
  make -j2 release-static-linux-x86_64-boost
  make ci-release
  mv build/packaged/* blockchain/bin/lthn/
  cd ../../
fi

if [ ! -f "blockchain/bin/itw3/itw3d" ]; then
  echo "Building iTw3 Blockchain"
  mkdir -p blockchain/bin/iTw3
  cd blockchain/iTw3 || exit
  USE_SINGLE_BUILDDIR=1 make -j2
#  make ci-release
  mv build/release/bin/* blockchain/bin/itw3/
  cd ../../
fi

if [ ! -f "blockchain/bin/wrkz/wrkzd" ]; then
  echo "Building WrkzCoin Blockchain"
  mkdir -p blockchain/bin/wrkz
  cd blockchain/wrkz || exit
  cd build || mkdir build
  cmake ..
  make -j2
  mv build/src/wrkz* blockchain/bin/wrkz/
  cd ../../
fi


echo "FIN"