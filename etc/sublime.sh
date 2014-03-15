#!/bin/sh
# Open a given file with sublime. Search for the file in the following order:
#
#					1. Given <path>
#					2. $ROOTSYS/<path> or <path> under $ROOTSYS
# 					3. Any parent ROOT dir (identified by the presence of core/base/inc/RVersion.h)
#

# Verbose
dbg="$SOVERBOSE"
#dbg="y"
# Verbosity function
verbose() {
   	if test "x$dbg" = "xy" ; then
		echo "Checking: $1"
	fi
}


# Determine path to be open
path=$1
fpath=""
if test ! -f $path ; then
	if test ! "x$ROOTSYS" = "x" ; then
		verbose "$ROOTSYS/$path"
		if test -f $ROOTSYS/$path ; then
			fpath="$ROOTSYS/$path"
	 	else
	 		fpath=`find $ROOTSYS -name $path`
  			verbose "$fpath"
  			if test ! -f $fpath ; then
  				fpath=""
  			fi
  		fi
  	else
  		rootv="core/base/inc/RVersion.h"
  		rdir=`pwd`
  		tdir="$rdir"
  		while test "x$fpath" = "x" && test ! "x$tdir" = "x/" ; do
 			verbose "$tdir/$path"
  			if test ! -f $tdir/$path ; then
  				if test -f $tdir/$rootv ; then
  					fpath=`find $tdir -name $path`
 					verbose "$fpath"
  					if test ! -f $fpath ; then
  						fpath=""
  					fi
  				fi
  			else
  				fpath="$tdir/$path"
  			fi
  			rdir=$tdir
  			tdir=`dirname $rdir`
  		done
    fi
else
    fpath="$path"
fi

# open path if found
if test ! "x$fpath" = "x" ; then
	sublime $fpath
else
	echo "Path $path not found!"
fi



