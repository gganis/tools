!#/bin/bash

# Guess which system we are (deb or rh), if not specified
SYST=$1
if test "x$SYST" = "x" ; then
   if test -f /etc/redhat-release; then
      SYST="rh"
   elif test -f /etc/debian_version; then
      SYST="deb"
      apt-get install -y aptitude
   else
      echo "Unsupported system"
      exit 1
   fi
fi
echo "Running configuriation for $SYST system ..."

# Upgrade to latest version
echo "Upgrading to the last versions of all installed packages ... "
if test "x$SYST" = "xrh" ; then
   yum update
   yum upgrade
else
   apt-get update
   apt-get dist-upgrade -y
fi

# Install packages required by ROOT
echo "Installing the packages required by ROOT ..."
if test "x$SYST" = "xrh" ; then
   yum install which git make gcc-c++ gcc gfortran binutils \
               libX11-devel libXpm-devel libXft-devel libXext-devel \
               cmake valgrind python-devel curl \ 
               openssl-devel glibc-devel.i686 glibc-devel mysql-devel \
               emacs
else
   apt-get install -y git dpkg-dev make g++ gcc gfortran binutils \
               libx11-dev libxpm-dev libxft-dev libxext-dev \
               cmake valgrind python-dev curl libssl-dev libc6-i386 \
               emacs
fi

# Groups and users
if test "x$SYST" = "xrh" ; then
   groupadd --gid 2735 sf
   useradd --shell /bin/bash --uid  2759 --gid 2735 ganis
   useradd --shell /bin/bash --uid 58070 --gid 2735 proofadm
   groupadd --gid 1307 zp
   useradd --shell /bin/bash --uid 35687 --gid 1307 gganis
else
   groupadd --gid 2735 sf
   useradd -s /bin/bash -u  2759 -g 2735 -m -c ganis ganis
   useradd -s /bin/bash -u 58070 -g 2735 -m -c proofadm proofadm
   groupadd --gid 1307 zp
   useradd -s /bin/bash -u 35687 -g 1307 -m -c gganis gganis
fi
passwd ganis
passwd gganis
passwd proofadm

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
   
# Installing xrootd
echo "Installing XRootD ... "
wget http://test-sftnight.web.cern.ch/test-sftnight/aob/installXrootd.sh
chmod a+x installXrootd.sh
sudo mkdir /opt/xrootd	
# Uncomment if requiring the old CXX11_ABI (on new Ubuntus, typically)
# sudo ./installXrootd.sh -v 4.3.0 --no-vers-subdir --xrdopts="-DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0" /opt/xrootd
sudo ./installXrootd.sh -v 4.3.0 /opt/xrootd
if test -d /opt/xrootd/lib64 ; then
   echo "/opt/xrootd/lib64" >> /etc/ld.so.conf.d/xrootd.conf
else
   echo "/opt/xrootd/lib" >> /etc/ld.so.conf.d/xrootd.conf
fi
/sbin/ldconfig -v


