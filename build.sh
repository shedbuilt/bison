#!/bin/bash
case "$SHED_BUILD_MODE" in
    toolchain)
        ./configure --prefix=/tools || exit 1
        ;;
    *)
        ./configure --prefix=/usr \
                    --docdir=/usr/share/doc/${SHED_PKG_NAME}-${SHED_PKG_VERSION} || exit 1
        ;;
esac
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install
