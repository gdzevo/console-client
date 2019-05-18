#!/bin/bash

FOLDER=$(dirname $0)
if [[ "X$1" == "Xrelease" ]]; then
 CMAKE="cmake -DCMAKE_INSTALL_PREFIX=../release ."
 MAKE="make install"
else
 CMAKE="cmake ."
 MAKE="make"
fi

${FOLDER}/clean.sh && cd "${FOLDER}/../pCloudCC" && ${CMAKE} && ${MAKE} && cd - && ${FOLDER}/clean.sh

exit 0
