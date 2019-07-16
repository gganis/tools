#
# Usage:   source ~/etc/rprep.sh <dir_tag>
#
if test "x$ROOTSRC" = "x" ; then
   ROOTSRC="$HOME/local/root/GIT/root"
fi

TAG=$1
if test "x$TAG" = "x" ; then
   echo "Passing a tag is mandatory!"
   echo "Syntax:"
   echo "   cmakeprep tag"
   exit 1
fi
ROOTLOC="$HOME/local/root"

DIRS="$ROOTLOC/build/$TAG $ROOTLOC/install/$TAG"
for dd in $DIRS; do
   if test ! -d "$dd"; then
      mkdir -p $dd
      if test ! -d "$dd"; then
         echo "Could not create $dd : quitting"
         exit 1
      fi
   fi
done

echo "Going to $ROOTLOC/build/$TAG ..."
cd $ROOTLOC/build/$TAG

echo "Basic build:           rcmake"
echo "Basic debug build:     rcmake debug"
echo "Basic xrootd build:    rcmake xrootd"
echo "Basic build w/ tests:  rcmake test"

