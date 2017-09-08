#!/bin/bash -e

if [ $# -gt 0 ]; then
  # if `docker run` only has one arguments, we assume user is running alternate command like `bash` to inspect the image
  exec "$@"
else
  mkdir -p ${ZLIB_BASE}/${VERSION}
  cp -R /zlib_dist/usr/local ${ZLIB_BASE}/${ZLIB_VERSION}/

  mkdir -p ${ZLIB_MODULEFILES}
  cat <<EOF > ${ZLIB_MODULEFILES}/${ZLIB_VERSION}
  #%Module
  prepend-path LD_LIBRARY_PATH ${ZLIB_BASE}/${ZLIB_VERSION}/lib
  prepend-path CPATH ${ZLIB_BASE}/${ZLIB_VERSION}/include
  prepend-path MANPATH ${ZLIB_BASE}/${ZLIB_VERSION}/share/man
EOF
fi