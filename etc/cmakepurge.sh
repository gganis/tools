#
# Usage:   source ~/etc/cmakepurge.sh <dir_tag> [path]
#
set `echo "$1"`

if test "x$ROOTSRC" = "x" ; then
   ROOTSRC="$HOME/local/root/GIT/root"
fi

TAG=$1
if test "x$TAG" = "x" ; then
   echo "Passing a tag is mandatory!"
   echo "Syntax:"
   echo "   cmakepurge tag"
   exit 1
fi
XP=$2
if test "x$XP" = "x" ; then
   XP="*"
fi
ROOTLOC="$HOME/local/root"

DIRS="$ROOTLOC/cmake/$TAG $ROOTLOC/build/$TAG $ROOTLOC/install/$TAG"
for dd in $DIRS; do
   if test -d "$dd"; then
      if test "x$XP" = "x*" ; then
         rm -fr $dd/$XP
         echo "Directory $dd purged"
      elif test -f "$dd/$XP"; then
         rm -f $dd/$XP
         echo "File $dd/$XP purged"
      elif test -d "$dd/$XP"; then
         rm -fr $dd/$XP
         echo "Directory $dd/$XP purged"
      else
         echo "Could not purge $dd/$XP : unknown file or directory"
      fi
   else
      echo "Could not purge $dd : directory not found"
   fi
done

echo "Done!"

