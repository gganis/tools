#!/bin/sh

XBIN=$1/bin
XLIB=$1/lib

if test ! "x$2" = "x"; then
   XBIN=$1
   XLIB=$2
fi

export PATH=$XBIN:$PATH
export LD_LIBRARY_PATH=$XLIB:$LD_LIBRARY_PATH

arch=`uname -s | tr '[A-Z]' '[a-z]'`
if test "x$arch" = "xdarwin"; then
   export DYLD_LIBRARY_PATH=$XLIB:$DYLD_LIBRARY_PATH
fi
