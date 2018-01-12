#!/bin/bash

rm -rf build/
mkdir build
DIR=$( pwd )

pushd build/
cmake -GNinja -DCMAKE_TOOLCHAIN_FILE="${DIR}/iphoneos.toolchain.cmake" ..
cmake --build .
popd
