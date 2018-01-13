# LDID

This is Saurik's [ldid][1] built with CMake. I've provided two scripts to kick off a build and I've provided the git submodules necessary to build `OpenSSL` and `libplist` with one CMake invocation.

## After cloning

Once you've cloned you'll need the submodules too:

    git submodule update --init

## Ninja

My build scripts call the [Ninja][2] generator. If you don't have ninja just remove the `-GNinja` option in the script.

## Building

Run the `build-macosx.sh` or `build-iphoneos.sh` file

    mkdir build
    cd build
    cmake ..
    cmake --build .

[1]: https://git.saurik.com/ldid.git 
[2]: https://ninja-build.org
