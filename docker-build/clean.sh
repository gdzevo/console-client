#!/bin/bash

PCLOUDCC=$( cd "$(dirname $0)/../pCloudCC" ; pwd -P )
#
rm -f ${PCLOUDCC}/pcloudcc
rm -f ${PCLOUDCC}/libpcloudcc_lib.so
#
rm -rf ${PCLOUDCC}/CMakeFiles
rm -rf ${PCLOUDCC}/*_build-prefix/
rm -f ${PCLOUDCC}/CMakeCache.txt
rm -f ${PCLOUDCC}/Makefile
rm -f ${PCLOUDCC}/cmake_install.cmake
rm -f ${PCLOUDCC}/install_manifest.txt
rm -rf ${PCLOUDCC}/lib/mbedtls/include/CMakeFiles
rm -f ${PCLOUDCC}/lib/mbedtls/include/Makefile
rm -f ${PCLOUDCC}/lib/mbedtls/include/cmake_install.cmake
rm -f ${PCLOUDCC}/lib/mbedtls/Makefile
rm -rf ${PCLOUDCC}/lib/mbedtls/CMakeFiles
rm -f ${PCLOUDCC}/lib/mbedtls/CMakeCache.txt
rm -f ${PCLOUDCC}/lib/mbedtls/cmake_install.cmake
rm -f ${PCLOUDCC}/lib/mbedtls/library/*.a
rm -f ${PCLOUDCC}/lib/mbedtls/library/Makefile
rm -f ${PCLOUDCC}/lib/mbedtls/library/cmake_install.cmake
rm -rf ${PCLOUDCC}/lib/mbedtls/library/CMakeFiles
rm -f ${PCLOUDCC}/lib/mbedtls/*.cbp

rm -f ${PCLOUDCC}/lib/pclsync/*.a
rm -f ${PCLOUDCC}/lib/pclsync/*.o
rm -f ${PCLOUDCC}/*.a
rm -f ${PCLOUDCC}/*.o
rm -f ${PCLOUDCC}/*.cbp

exit 0
