#!/bin/bash
   
# Installing xrootd
echo "Installing XRootD ... "
wget http://test-sftnight.web.cern.ch/test-sftnight/aob/installXrootd.sh
chmod a+x installXrootd.sh
sudo mkdir /opt/xrootd	
# Uncomment if requiring the old CXX11_ABI (on new Ubuntus, typically)
# sudo ./installXrootd.sh -v 4.3.0 --no-vers-subdir --xrdopts="-DENABLE_PYTHON=FALSE" --xrdopts="-DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0"  /opt/xrootd
sudo ./installXrootd.sh -v 4.3.0 --no-vers-subdir --xrdopts="-DENABLE_PYTHON=FALSE" /opt/xrootd
if test -d /opt/xrootd/lib64 ; then
   echo "/opt/xrootd/lib64" >> /etc/ld.so.conf.d/xrootd.conf
else
   echo "/opt/xrootd/lib" >> /etc/ld.so.conf.d/xrootd.conf
fi
/sbin/ldconfig -v


