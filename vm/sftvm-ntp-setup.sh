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

# Update ntp
echo " " >> /etc/ntp.conf
echo "# CERN time servers" >> /etc/ntp.conf
if test "x$SYST" = "xrh" ; then
   echo "server ip-time-0.cern.ch iburst" >> /etc/ntp.conf
   echo "server ip-time-1.cern.ch iburst" >> /etc/ntp.conf
   service ntpd restart
else
   echo "server ip-time-0.cern.ch" >> /etc/ntp.conf
   echo "server ip-time-1.cern.ch" >> /etc/ntp.conf
   service ntp restart
fi


