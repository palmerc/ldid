cmake_minimum_required( VERSION 3.8 )

if( NOT DEFINED CMAKE_TOOLCHAIN_FILE )
    message( WARNING "You did not define a toolchain file. Building for macOS" )
    set( SDK macosx CACHE STRING "" )
    set( CMAKE_C_COMPILER clang )
    set( CMAKE_CXX_COMPILER clang++ )
    set( CMAKE_OSX_ARCHITECTURES x86_64 CACHE STRING "" )
    execute_process( COMMAND xcrun --sdk ${SDK} --show-sdk-path
            OUTPUT_VARIABLE CMAKE_OSX_SYSROOT
            OUTPUT_STRIP_TRAILING_WHITESPACE )
    set( CMAKE_OSX_SYSROOT ${CMAKE_OSX_SYSROOT} CACHE PATH "sysroot" )
endif()

project( ldid )

set( CMAKE_CXX_STANDARD 11 )

# Add libplist submodule
add_subdirectory( libplist )

# Add External Project OpenSSL
set( LIBRESSL_APPS OFF )
set( LIBRESSL_TESTS OFF )
set( LIBRESSL_SKIP_INSTALL ON )

add_subdirectory( libressl )

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
target_link_libraries( ldid
    xml2
    plist
    cnary
    crypto
    ssl )

install( TARGETS ldid
    RUNTIME DESTINATION bin )
