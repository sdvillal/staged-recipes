#!/bin/bash

if [[ $(uname) == MSYS* ]]; then
  if [[ ${ARCH} == 32 ]]; then
    HOST_BUILD="--host=i686-w64-mingw32 --build=i686-w64-mingw32"
  else
    HOST_BUILD="--host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32"
  fi
  PREFIX=${PREFIX}/Library/mingw-w64
fi

# It seems we need clang 3.9 or greater for avx512
# https://bugs.chromium.org/p/webm/issues/detail?id=1475
if [ "${SHORT_OS_STR}" == "Darwin" ]; then
    AVX512_CONFIGURE_FLAGS="--disable-avx512"
fi

./configure --prefix=${PREFIX}           \
            ${AVX512_CONFIGURE_FLAGS}    \
            ${HOST_BUILD}                \
            --as=yasm                    \
            --enable-runtime-cpu-detect  \
            --enable-shared              \
            --enable-pic                 \
            --disable-install-docs       \
            --disable-install-srcs       \
            --enable-vp8                 \
            --enable-postproc            \
            --enable-vp9                 \
            --enable-vp9-highbitdepth    \
            --enable-experimental        \
            --enable-spatial-svc || exit 1

make -j${CPU_COUNT} ${VERBOSE_AT}
make install
