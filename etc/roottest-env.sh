#
# Source this to set all what you need to use roottest at <roottest_path> 
#
# Usage:
#            source /Path/to/setroottest.sh <roottest_path> [cd]
#
#
set `echo "$1"`

roottest_dir=""
dirs="$1 $HOME/local/roottest/$1"
for d in $dirs ; do
   if test -d $d ; then
      roottest_dir="$d"
      break
   fi
done

export ROOTTEST_HOME="$roottest_dir"

echo "Using roottest at $roottest_dir"

if test "x$2" = "xcd" ; then
   cd $roottest_dir
fi


