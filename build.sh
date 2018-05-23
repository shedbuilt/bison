#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
SHED_PKG_LOCAL_PREFIX='/usr'
if [ -n "${SHED_PKG_LOCAL_OPTIONS[toolchain]}" ]; then
    SHED_PKG_LOCAL_PREFIX='/tools'
fi
SHED_PKG_LOCAL_DOCDIR="${SHED_PKG_LOCAL_PREFIX}/share/doc/${SHED_PKG_NAME}-${SHED_PKG_VERSION}"

# Configure
./configure --prefix="$SHED_PKG_LOCAL_PREFIX" \
            --docdir="$SHED_PKG_LOCAL_DOCDIR" &&

# Build & Install
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install || exit 1

# Prune Documentation
if [ -z "${SHED_PKG_LOCAL_OPTIONS[docs]}" ]; then
    rm -rf "${SHED_FAKE_ROOT}${SHED_PKG_LOCAL_DOCDIR}"
fi
