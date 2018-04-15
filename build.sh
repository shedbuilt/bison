#!/bin/bash
case "$SHED_BUILD_MODE" in
    toolchain)
        ./configure --prefix=/tools || return 1
        ;;
    *)
        ./configure --prefix=/usr \
                    --docdir=/usr/share/doc/bison-3.0.4 || return 1
        ;;
esac
make -j $SHED_NUM_JOBS || return 1
make DESTDIR="$SHED_FAKE_ROOT" install || return 1
