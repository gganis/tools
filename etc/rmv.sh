#
# Usage:   source ~/etc/rmv.sh <dir_tag> <new_dir_tag>
#
set `echo "$1"`

if test "x$ROOTSRC" = "x" ; then
   ROOTSRC="$HOME/local/root/GIT/root"
fi

TAG=$1
if test "x$TAG" = "x" ; then
   echo "Passing a tag is mandatory!"
   echo "Syntax:"
   echo "   cmakemv oldtag newtag"
   exit 1
fi
NTAG=$2
if test "x$NTAG" = "x" ; then
   echo "Passing a new tag is mandatory!"
   echo "Syntax:"
   echo "   cmakemv oldtag newtag"
   exit 1
fi
if test "x$NTAG" = "x$TAG" ; then
   echo "New tag and old tag are the same!"
   exit 1
fi

ROOTLOC="$HOME/local/root"

DIRS="$ROOTLOC/build $ROOTLOC/install"
for dd in $DIRS; do
   odir="$dd/$TAG"
   ndir="$dd/$NTAG"
   if test -d "$odir"; then
      mv $odir $ndir
      echo "Directory $odir moved to $ndir"
   else
      echo "Could not move $odir : directory not found"
   fi
done

echo "Done!"

