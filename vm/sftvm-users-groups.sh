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

# Groups and users
if test "x$SYST" = "xrh" ; then
   groupadd --gid 2735 sf
   useradd --shell /bin/bash --uid 14806 --gid 2735 sftnight
else
   addgroup --gid 2735 sf
   adduser -s /bin/bash -u 14806 -g 2735 -m -C SFTNight sftnight
   adduser -c Ubuntu -m -g 1000 -u 1001 -s /bin/bash ubuntu
fi
passwd sftnight


