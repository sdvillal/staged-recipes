#!/bin/bash

set -ex

RPM=$(find ${PWD}/binary -name "*.rpm")
mkdir -p ${PREFIX}/x86_64-conda_cos6-linux-gnu/sysroot
pushd ${PREFIX}/x86_64-conda_cos6-linux-gnu/sysroot
cpio -idmv ${RECIPE_DIR}/binary
popd
