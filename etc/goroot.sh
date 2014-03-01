#
# Usage:   source ~/etc/goroot.sh <dir_tag>
#
if test "x$ROOTSRC" = "x" ; then
   ROOTSRC="/home/ganis/local/root/GIT/root"
fi

SRC=$1
if test "x$SRC" = "x" ; then
   SRC="$ROOTSRC"
fi
if test ! -d $SRC ; then
   echo "Directory $SRC does not exist"
   return
fi

if test ! -f $SRC/LICENSE ; then
   SRC="$SRC/root"
   if test ! -f $SRC/LICENSE ; then
      echo "Could not find a valid ROOT source dir for $1"
      return
   fi
fi

echo "Going to $SRC ..."
cd $SRC
