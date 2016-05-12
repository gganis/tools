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

# Disable SElinux
if test "x$SYST" = "xrh" ; then
   echo "Disabling SElinux ..."
   if test -f /etc/selinux/config ; then
   	  mv /etc/selinux/config /etc/selinux/config.origin
   	  sed -e "s|SELINUX=enforcing|SELINUX=disabled|" < /etc/selinux/config.origin > /etc/selinux/config
   	  echo "0" > /selinux/enforce
   fi
fi
