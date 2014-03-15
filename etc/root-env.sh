#
# Source this to set all what you need to use the ROOT
# vesrion installed starting from the present PATH
#
# Usage:
#            source ~/etc/root-env.csh [root_path] [cd]
#
#
set `echo "$1"`

# Strip present settings, if there
if test ! "x$ROOTSYS" = "x" ; then

   # Trim $PATH
   tpath=""
   idx0="0"
   idxt=`expr index "${PATH}" ':'`
   idxl=`expr $idxt - 1`
   while test ! "x$idxt" = "x0" ; do
      spath="${PATH:$idx0:$idxl}"
      if test ! "x$ROOTSYS/bin" = "x$spath" ; then
         if test ! "x$spath" = "x" ; then
            tpath="$tpath:$spath"
         fi
      fi
      idx0=`expr $idx0 + $idxt`
      idxt=`expr index "${PATH:$idx0}" ':'`
      idxl=`expr $idxt - 1`
   done
   spath="${PATH:$idx0}"
   if test ! "x$ROOTSYS/bin" = "x$spath" ; then
      tpath="$tpath:$spath"
   fi

   # Trim $LD_LIBRARY_PATH
   tldpath=""
   idx0="0"
   idxt=`expr index "${LD_LIBRARY_PATH}" ':'`
   idxl=`expr $idxt - 1`
   while test ! "x$idxt" = "x0" ; do
      spath="${LD_LIBRARY_PATH:$idx0:$idxl}"
      if test ! "x$ROOTSYS/lib" = "x$spath" ; then
         if test ! "x$spath" = "x" ; then
            tldpath="$tldpath:$spath"
         fi
      fi
      idx0=`expr $idx0 + $idxt`
      idxt=`expr index "${LD_LIBRARY_PATH:$idx0}" ':'`
      idxl=`expr $idxt - 1`
   done
   spath="${LD_LIBRARY_PATH:$idx0}"
   if test ! "x$ROOTSYS/lib" = "x$spath" ; then
      tldpath="$tldpath:$spath"
   fi
else

   # do not touch
   tpath="$PATH"
   tldpath="$LD_LIBRARY_PATH"
fi


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
echo "rd: $rd, rddir: $rddir"
if test "x$rddir" = "x." ; then
  if test -d "$rd/root"; then
     subdir="$rd/root"
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
   rd="$HOME/local/root/$subdir"
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
echo "Using ROOT at $rd"
export ROOTSYS="$rd"
if test "x$cdtodir" = "xno" ; then
   cd "$pwdsave"
fi

export PATH="$ROOTSYS/bin:$tpath"
export LD_LIBRARY_PATH="$ROOTSYS/lib:$tldpath"

# Try to guess the related xrootd
if test -f $ROOTSYS/bin/setxrd.sh ; then
   if test -f $ROOTSYS/config/Makefile.config ; then
      set `grep XRDLIBDIR $ROOTSYS/config/Makefile.config`
      xrdsyslib=`echo $3 | sed 's|-L||'`
      xrdsys=`dirname $xrdsyslib`
      if test -d $xrdsys/include/xrootd ; then
         source $ROOTSYS/bin/setxrd.sh $xrdsys
      else
         echo "It looks like '$xrdsys' is not a standard xrootd installation path - do nothing"
      fi
   else
      echo "File $ROOTSYS/config/Makefile.config does not exist: re-run after configuration"
   fi
fi
