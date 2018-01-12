cmake_minimum_required( VERSION 3.8 )

set( CMAKE_OSX_ARCHITECTURES arm64 CACHE STRING "" )
set( CMAKE_CXX_STANDARD 11 )

project( ldid )

include( add_library.cmake )
add_subdirectory( libplist )
add_subdirectory( openssl )
add_library( openssl_crypto STATIC IMPORTED )
set_property( TARGET openssl_crypto PROPERTY IMPORTED_LOCATION                  ${OPENSSL_CRYPTO_PATH} )
add_library( openssl_ssl STATIC IMPORTED )
set_property( TARGET openssl_ssl PROPERTY IMPORTED_LOCATION                     ${OPENSSL_SSL_PATH} )
include_directories( ${OPENSSL_INCLUDE_PATH} )

AddLibrary( ldid xml2 )
set( XML2_INCLUDES_DIR ${CMAKE_OSX_SYSROOT}/usr/include/libxml2 )
include_directories( ${XML2_INCLUDES_DIR} )

set( HEADER_FILES
    ldid.hpp
    sha1.h )

set( SOURCE_FILES
    lookup2.c
    ldid.cpp )

add_executable( ldid ${SOURCE_FILES} )
add_dependencies( ldid ${OPENSSL_TARGETS} )
target_link_libraries( ldid
    plist
    cnary
    openssl_crypto
    openssl_ssl )
