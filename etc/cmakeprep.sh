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

else

   ROOTLOC="/home/ganis/local/root"

   failed="false"
   DIRS="$ROOTLOC/cmake/$TAG $ROOTLOC/build/$TAG $ROOTLOC/install/$TAG"
   for dd in $DIRS; do
      if test ! -d "$dd"; then
         mkdir -p $dd
         if test ! -d "$dd"; then
            echo "Could not create $dd : quitting"
            failed="true"
            break
         fi
      fi
   done

   if test "x$failed" = "xfalse" ; then

      echo "Going to $ROOTLOC/build/$TAG ..."
      cd $ROOTLOC/build/$TAG
      
      echo "Basic build:           rootcmake"
      echo "Basic debug build:     rootcmake debug"
      echo "Basic xrootd build:    rootcmake xrootd"
      echo "Basic build w/ tests:  rootcmake test"

   else

      echo "problems creating one of the directories ..."
 
   fi
fi
 
