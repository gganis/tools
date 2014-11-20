#
# Source this to set all what you need to use the ROOT
# vesrion installed starting from the present PATH
#
# Usage:
#            source ~/etc/root-env.csh [root_path] [cd]
#
#
set `echo "$1"`

WRKSYS=`uname -s`

drop_from_path()
{
   # Assert that we got enough arguments
   if test $# -ne 2 ; then
      echo "drop_from_path: needs 2 arguments"
      return 1
   fi

   p=$1
   drop=$2

   newpath=`echo $p | sed -e "s;:${drop}:;:;g" \
                          -e "s;:${drop};;g"   \
                          -e "s;${drop}:;;g"   \
                          -e "s;${drop};;g"`
}

if [ -n "${ROOTSYS}" ] ; then
   old_rootsys=${ROOTSYS}
fi

if [ -n "${old_rootsys}" ] ; then
   if [ -n "${PATH}" ]; then
      drop_from_path "$PATH" ${old_rootsys}/bin
      PATH=$newpath
   fi
   if [ -n "${LD_LIBRARY_PATH}" ]; then
      drop_from_path $LD_LIBRARY_PATH ${old_rootsys}/lib
      LD_LIBRARY_PATH=$newpath
   fi
   if [ -n "${DYLD_LIBRARY_PATH}" ]; then
      drop_from_path $DYLD_LIBRARY_PATH ${old_rootsys}/lib
      DYLD_LIBRARY_PATH=$newpath
   fi
   if [ -n "${SHLIB_PATH}" ]; then
      drop_from_path $SHLIB_PATH ${old_rootsys}/lib
      SHLIB_PATH=$newpath
   fi
   if [ -n "${LIBPATH}" ]; then
      drop_from_path $LIBPATH ${old_rootsys}/lib
      LIBPATH=$newpath
   fi
   if [ -n "${PYTHONPATH}" ]; then
      drop_from_path $PYTHONPATH ${old_rootsys}/lib
      PYTHONPATH=$newpath
   fi
   if [ -n "${MANPATH}" ]; then
      drop_from_path $MANPATH ${old_rootsys}/man
      MANPATH=$newpath
   fi
fi

if [ -z "${MANPATH}" ]; then
   # Grab the default man path before setting the path to avoid duplicates
   if `which manpath > /dev/null 2>&1` ; then
      default_manpath=`manpath`
   else
      default_manpath=`man -w 2> /dev/null`
   fi
fi

# do not touch
tpath="$PATH"
tldpath="$LD_LIBRARY_PATH"
tdyldpath="$DYLD_LIBRARY_PATH"


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

bindir="$ROOTSYS/bin"
libdir="$ROOTSYS/lib"
mandir="$ROOTSYS/man"

if [ -z "${PATH}" ]; then
   PATH=$bindir; export PATH
else
   PATH=$bindir:$PATH; export PATH
fi

if [ -z "${LD_LIBRARY_PATH}" ]; then
   LD_LIBRARY_PATH=$libdir; export LD_LIBRARY_PATH       # Linux, ELF HP-UX
else
   LD_LIBRARY_PATH=$libdir:$LD_LIBRARY_PATH; export LD_LIBRARY_PATH
fi

if test "x$WRKSYS" = "xDarwin" ; then
  if [ -z "${DYLD_LIBRARY_PATH}" ]; then
     DYLD_LIBRARY_PATH=$libdir; export DYLD_LIBRARY_PATH   # Mac OS X
  else
     DYLD_LIBRARY_PATH=$libdir:$DYLD_LIBRARY_PATH; export DYLD_LIBRARY_PATH
  fi
fi


if [ -z "${PYTHONPATH}" ]; then
   PYTHONPATH=$libdir; export PYTHONPATH
else
   PYTHONPATH=$libdir:$PYTHONPATH; export PYTHONPATH
fi

if [ -z "${MANPATH}" ]; then
   MANPATH=`dirname $mandir`:${default_manpath}; export MANPATH
else
   MANPATH=`dirname $mandir`:$MANPATH; export MANPATH
fi

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
