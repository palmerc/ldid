macro( AddLibrary TARGET LIBRARY_NAME )
    set( NAMES ${LIBRARY_NAME} )
    if( ${LIBRARY_NAME} MATCHES "^${CMAKE_STATIC_LIBRARY_PREFIX}" )
        string( REPLACE ${CMAKE_STATIC_LIBRARY_PREFIX} "" SHORT_LIBRARY_NAME ${LIBRARY_NAME} )
        list( APPEND NAMES ${SHORT_LIBRARY_NAME} )
    endif()
    find_library( ${LIBRARY_NAME}_LIBRARY
        NAMES ${NAMES}
        HINTS ${CMAKE_OSX_SYSROOT}/usr
        PATH_SUFFIXES lib
        NO_DEFAULT_PATH )
    find_path( LIBXML2_INCLUDE_DIR 
        NAMES libxml/xpath.h
        HINTS ${CMAKE_OSX_SYSROOT}/usr/include
        PATH_SUFFIXES libxml2 
        NO_DEFAULT_PATH )
    if( ${${LIBRARY_NAME}_LIBRARY} MATCHES "NOTFOUND$" )
        message( FATAL_ERROR ": Library ${LIBRARY_NAME} not found" )
    endif()
endmacro( AddLibrary )
