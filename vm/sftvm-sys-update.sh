!#/bin/bash

# Guess which system we are (deb or rh), if not specified
SYST=$1
pkgm="apt-get"
if test "x$SYST" = "x" ; then
   if test -f /etc/redhat-release; then
      SYST="rh"
      pkgm=`which dnf`
      if test "x$?" = "x1" ; then
         pkgm="yum"
      fi
   elif test -f /etc/debian_version; then
      SYST="deb"
   else
      echo "Unsupported system"
      exit 1
   fi
fi
echo "Running configuration for $SYST system ..."

# Upgrade to latest version
echo "Upgrading to the last versions of all installed packages ... "
if test "x$SYST" = "xrh" ; then
   $pkgm update
   $pkgm upgrade
else
   $pkgm update
   $pkgm dist-upgrade -y
fi

# Install packages required by ROOT
echo "Installing the packages required by ROOT ..."
if test "x$SYST" = "xrh" ; then
   $pkgm install which git subversion make gcc-c++ gcc gcc-gfortran binutils \
               libX11-devel libXpm-devel libXft-devel libXext-devel \
               cmake ruby valgrind doxygen python-devel curl graphviz \
               ntp openssl-devel glibc-devel.i686 glibc-devel mysql-devel \
	       krb5-devel \
	       libgsl-devel \
               java-1.8.0-openjdk
else
   $pkgm install -y git subversion dpkg-dev make g++ gcc gfortran binutils \
               libx11-dev libxpm-dev libxft-dev libxext-dev \
               cmake ruby valgrind doxygen python-dev curl graphviz ntp libssl-dev libc6-i386 \
	       krb5-user libkrb5-dev \
	       libgsl-dev \
               default-jdk
fi


