#!/bin/bash
case "$SHED_BUILDMODE" in
    toolchain)
        ./configure --prefix=/tools || return 1
        ;;
    *)
        ./configure --prefix=/usr \
                    --docdir=/usr/share/doc/bison-3.0.4 || return 1
        ;;
esac
make -j $SHED_NUMJOBS || return 1
make DESTDIR="$SHED_FAKEROOT" install || return 1
