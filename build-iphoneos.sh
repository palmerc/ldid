#!/bin/bash

BUILD_DIR="build-iphoneos/"
rm -rf "${BUILD_DIR}"
mkdir "${BUILD_DIR}"
DIR=$( pwd )

pushd "${BUILD_DIR}"
cmake -GNinja -DCMAKE_TOOLCHAIN_FILE="${DIR}/cmake/iphoneos.toolchain.cmake" ..
cmake --build .
popd
