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
   yum install git subversion make gcc-c++ gcc gfortran binutils \
               libX11-devel libXpm-devel libXft-devel libXext-devel \
               cmake ruby valgrind doxygen python-devel curl graphviz \ 
               ntp openssl-devel glibc-devel.i686 glibc-devel mysql-devel
else
   apt-get install -y git subversion dpkg-dev make g++ gcc gfortran binutils \
               libx11-dev libxpm-dev libxft-dev libxext-dev \
               cmake ruby valgrind doxygen python-dev curl graphviz ntp libssl-dev libc6-i386

fi

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

# Disable SElinux
if test "x$SYST" = "xrh" ; then
   echo "Disabling SElinux ..."
   if test -f /etc/selinux/config ; then
   	  mv /etc/selinux/config /etc/selinux/config.origin
   	  sed -e "s|SELINUX=enforcing|SELINUX=disabled|" < /etc/selinux/config.origin > /etc/selinux/config
   	  echo "0" > /selinux/enforce
   fi
fi

# Groups and users
if test "x$SYST" = "xrh" ; then
   groupadd --gid 2735 sf
   useradd --shell /bin/bash --uid 14806 --gid 2735 sftnight
else
   addgroup --gid 2735 sf
   adduser --shell /bin/bash --uid 14806 --gid 2735 sftnight
   adduser -c Ubuntu -m -g 1000 -u 1001 -s /bin/bash ubuntu
fi
passwd sftnight

# Install c15n
echo "Installing c15n ..."
if test "x$SYST" = "xrh" ; then
   wget http://test-sftnight.web.cern.ch/test-sftnight/c15n/c15n
   mv c15n /etc/init.d
   chmod a+x /etc/init.d/c15n
   chkconfig --add c15n
else
   wget http://test-sftnight.web.cern.ch/test-sftnight/ubuntu/c15n/c15n
   mv c15n /etc/init.d
   chmod a+x /etc/init.d/c15n
   /usr/sbin/update-rc.d c15n defaults
fi

# Installing xrootd
echo "Installing XRootD ... "
wget http://test-sftnight.web.cern.ch/test-sftnight/aob/installXrootd.sh
chmod a+x installXrootd.sh
sudo mkdir /opt/xrootd	
sudo ./installXrootd.sh -v 3.3.6 --no-vers-subdir /opt/xrootd
if test -d /opt/xrootd/lib64 ; then
   echo "/opt/xrootd/lib64" >> /etc/ld.so.conf.d/xrootd.conf
else
   echo "/opt/xrootd/lib" >> /etc/ld.so.conf.d/xrootd.conf
fi
/sbin/ldconfig -v

# Installing pythia8
wget http://test-sftnight.web.cern.ch/test-sftnight/aob/getpythia8.sh
chmod a+x getpythia8.sh
sudo ./getpythia8.sh /opt/pythia8
if test -d /opt/pythia8/lib64 ; then
   echo "/opt/pythia8/lib64" >> /etc/ld.so.conf.d/pythia8.conf
else
   echo "/opt/pythia8/lib" >> /etc/ld.so.conf.d/pythia8.conf
fi
/sbin/ldconfig -v

# Get the agent
ecagent="ElectricCommander-4.2.3.64287"
scp sftnight@lxplus.cern.ch:/afs/cern.ch/user/s/sftnight/EC/agents/linux/$ecagent .
chmod a+x $ecagent


