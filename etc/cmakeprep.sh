#
# Usage:   source ~/etc/cmakeprep.sh <dir_tag>
#
if test "x$ROOTSRC" = "x" ; then
   ROOTSRC="/home/ganis/local/root/GIT/root"
fi

TAG=$1
if test "x$TAG" = "x" ; then
   echo "Passing a tag is mandatory!"
   echo "Syntax:"
   echo "   cmakeprep tag"
   exit 1
fi
ROOTLOC="/home/ganis/local/root"

DIRS="$ROOTLOC/cmake/$TAG $ROOTLOC/build/$TAG $ROOTLOC/install/$TAG"
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

echo "Basic build:           rootcmake"
echo "Basic debug build:     rootcmake debug"
echo "Basic xrootd build:    rootcmake xrootd"
echo "Basic build w/ tests:  rootcmake test"

