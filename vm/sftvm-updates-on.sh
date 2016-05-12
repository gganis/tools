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

# Enable automatic updates
if test "x$SYST" = "xdeb" ; then
   echo "Enabling automatic updates ..."
   sudo apt-get install unattended-upgrades
   f10="/etc/apt/apt.conf.d/10periodic"
   f50="/etc/apt/apt.conf.d/50unattended-upgrades"
   if test -f $f50 && test -f $f10 ; then
      ed=`which emacs`
      if test ! "x$?" = "x0" ; then
         ed=`which nano`
         if test ! "x$?" = "x0" ; then
            echo "Neither emacs not nano available: please install an editor - exit"
            exit 1
         fi
      fi
      echo "Uncomment the line containing \$\{distro_codename\}-updates"
      $ed $f50
      echo "Trying to modify $f10 automatically ..."
      mv $f10 "$f10.origin"
      sed -e "s|APT::Periodic::Download-Upgradeable-Packages \"0\";|APT::Periodic::Download-Upgradeable-Packages \"1\";|" < "$f10.origin" > $f10
      mv $f10 "$f10.origin"
      sed -e "s|APT::Periodic::AutocleanInterval \"0\";|APT::Periodic::AutocleanInterval \"7\";|" < "$f10.origin" > $f10
      echo "APT::Periodic::Unattended-Upgrade \"1\";" >> $f10      
   else
      echo "Could not find $f50 or $f10 - do nothing"
   fi
fi

