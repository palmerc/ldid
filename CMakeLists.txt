cmake_minimum_required( VERSION 3.8 )

if( NOT DEFINED CMAKE_TOOLCHAIN_FILE )
    message( WARNING "You did not define a toolchain file. Building for macOS" )
    set( SDK macosx CACHE STRING "" )
    set( CMAKE_C_COMPILER clang )
    set( CMAKE_CXX_COMPILER clang++ )
    set( CMAKE_OSX_ARCHITECTURES x86_64 CACHE STRING "" )
endif()

project( ldid )

set( CMAKE_CXX_STANDARD 11 )

# Add libplist submodule
add_subdirectory( libplist )

# Add External Project OpenSSL
add_subdirectory( openssl )
add_library( openssl_crypto STATIC IMPORTED )
set_property( TARGET openssl_crypto
        PROPERTY
            IMPORTED_LOCATION ${OPENSSL_CRYPTO_PATH} )
add_dependencies( openssl_crypto ${OPENSSL_TARGET} )

add_library( openssl_ssl STATIC IMPORTED )
set_property( TARGET openssl_ssl
        PROPERTY
            IMPORTED_LOCATION ${OPENSSL_SSL_PATH} )
message( "OPENSSL_INCLUDE_DIR ${OPENSSL_INCLUDE_DIR}" )
include_directories( ${OPENSSL_INCLUDE_DIR} )
add_dependencies( openssl_ssl ${OPENSSL_TARGET} )

# Add osx sysroot version of libxml2
set( XML2_INCLUDES_PATH ${CMAKE_OSX_SYSROOT}/usr/lib/libxml2.tbd )
include_directories( ${XML2_INCLUDES_DIR} )


set( HEADER_FILES
    ldid.hpp
    sha1.h )

set( SOURCE_FILES
    lookup2.c
    ldid.cpp )

add_executable( ldid ${SOURCE_FILES} )
add_dependencies( ldid ${OPENSSL_TARGET} )
target_link_libraries( ldid
    xml2
    plist
    cnary
    openssl_crypto
    openssl_ssl )
