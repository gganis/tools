#
# Source this to set all what you need to use roottest at <roottest_path> 
#
# Usage:
#            source /Path/to/setroottest.sh <roottest_path> [cd]
#
#
set `echo "$1"`

cdtodir="no"
rd="$PWD"
if test ! "x$1" = "x" ; then

  if test "x$1" = "xcd" ; then
     cdtodir="yes"
  else
     rd="$1"
     if test "x$2" = "xcd" ; then
        cdtodir="yes"
     fi
  fi

fi

# Check if there is a request for a sub-dir
subdir=""
rddir=`dirname $rd`
if test "x$rddir" = "x." ; then
  if test -d "$rd/roottest"; then
     subdir="$rd/roottest"
  else
     subdir="$rd"
  fi
else
  rddirn=`dirname $rddir`
  if test "x$rddirn" = "x." ; then
     subdir="$rd"
  fi
fi
if test ! "x$subdir" = "x" ; then
   rd="$HOME/local/roottest/$subdir"
fi

pwdsave="$PWD"

if test ! -d $rd ; then
   docreate="no"
   echo "Directory $rd does not exist: do you want to create it? (N/y)"
   read ans
   if test "x$ans" = "xY" || test "x$ans" = "xy" ; then
      docreate="yes"
   fi
   if test "x$docreate" = "xyes" ; then
      mkdir -p $rd
   else
      exit 1
   fi
fi

cd "$rd"
rd="$PWD"
echo "Using roottest at $rd"
export ROOTTEST_HOME="$rd"
if test "x$cdtodir" = "xno" ; then
   cd "$pwdsave"
fi


