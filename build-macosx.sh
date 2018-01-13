#!/bin/bash

BUILD_DIR="build-macosx/"
rm -rf "${BUILD_DIR}"
mkdir "${BUILD_DIR}"
DIR=$( pwd )

pushd "${DIR}/${BUILD_DIR}"
cmake -GNinja ..
cmake --build .
popd
