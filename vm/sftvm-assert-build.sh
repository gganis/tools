#!/bin/bash

# Guess which system we are (deb or rh), if not specified
SYST=$1
if test "x$SYST" = "x" ; then
   if test -f /etc/redhat-release; then
      SYST="rh"
   elif test -f /etc/debian_version; then
      SYST="deb"
   else
      echo "Unsupported system"
      exit 1
   fi
fi
echo "Running configuration for $SYST system ..."

# Make sure /build is there
echo "Asserting /build ..."
wget http://test-sftnight.web.cern.ch/test-sftnight/assertbuild/assertbuild
mv assertbuild /etc/init.d
chmod a+x /etc/init.d/assertbuild
if test "x$SYST" = "xrh" ; then
    chkconfig --add assertbuild
else
   /usr/sbin/update-rc.d assertbuild defaults
fi
