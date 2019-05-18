include(ExternalProject)

cmake_minimum_required(VERSION 2.8)
project(pcloudcc)

#INCLUDE(CPack)

set(Boost_USE_STATIC_LIBS ON)
set(Boost_USE_MULTITHREADED ON)
unset(Boost_INCLUDE_DIR CACHE)
unset(Boost_LIBRARY_DIRS CACHE)

find_package(Boost COMPONENTS system program_options REQUIRED)
include_directories(${Boost_INCLUDE_DIR})
link_directories(${Boost_LIBRARY_DIR})
#set (CMAKE_CXX_FLAGS "-static -Wl,-Bstatic")
#set (CMAKE_CXX_FLAGS "-Wl,-Bstatic")
set (CMAKE_C_FLAGS "-fPIC")
set (PCLSYNC_PATH ${CMAKE_CURRENT_SOURCE_DIR}/lib/pclsync)
set (MBEDTLS_PATH ${CMAKE_CURRENT_SOURCE_DIR}/lib/mbedtls)
set (SQLITE3_PATH ${CMAKE_CURRENT_SOURCE_DIR}/lib/sqlite)
set (OVERLAY_CLENT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/lib/poverlay_linux)
#
include_directories(${SQLITE3_PATH})
include_directories(${PCLSYNC_PATH})
include_directories(${OVERLAY_CLENT_PATH})
include_directories(${MBEDTLS_PATH})
#
ExternalProject_Add(pclsync_build
    BUILD_IN_SOURCE 1
    SOURCE_DIR ${PCLSYNC_PATH}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND make clean fs
    INSTALL_COMMAND ""
    LOG_BUILD 1
    LOG_MERGED_STDOUTERR 1
)

add_library(pclsync STATIC IMPORTED)
add_dependencies(pclsync pclsync_build)
set_property(TARGET pclsync PROPERTY IMPORTED_LOCATION ${PCLSYNC_PATH}/libpsynclib.a)
#
ExternalProject_Add(mbedtls_build
    DEPENDS pclsync
    BUILD_IN_SOURCE 1
    SOURCE_DIR ${MBEDTLS_PATH}
    BUILD_COMMAND make clean all
    INSTALL_COMMAND ""
    LOG_BUILD 1
    LOG_MERGED_STDOUTERR 1
)

add_library(mbedtls STATIC IMPORTED)
add_dependencies(mbedtls mbedtls_build)
set_property(TARGET mbedtls PROPERTY IMPORTED_LOCATION ${MBEDTLS_PATH}/library/libmbedtls.a)

# sqlite
add_library(sqlite3 STATIC ${SQLITE3_PATH}/sqlite3.c)
target_link_libraries(sqlite3 z dl)

# libpcloudcc_lib.so
add_library(pcloudcc_lib SHARED pclsync_lib_c.cpp pclsync_lib.cpp control_tools.cpp ${OVERLAY_CLENT_PATH}/overlay_client.c ${OVERLAY_CLENT_PATH}/debug.c )
target_link_libraries(pcloudcc_lib pclsync mbedtls sqlite3 fuse pthread)

## pcloudcc
add_executable(pcloudcc main.cpp)
target_link_libraries(pcloudcc pcloudcc_lib ${Boost_LIBRARIES})
#
install(TARGETS pcloudcc RUNTIME DESTINATION bin)
install(TARGETS pcloudcc_lib LIBRARY DESTINATION lib)
