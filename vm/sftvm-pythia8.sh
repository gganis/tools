#!/bin/bash

# Installing pythia8
wget http://test-sftnight.web.cern.ch/test-sftnight/aob/getpythia8.sh -o getpythia8.sh
chmod a+x getpythia8.sh
# Uncomment if requiring the old CXX11_ABI (on new Ubuntus, typically)
# sudo USRCXXFLAGS=-D_GLIBCXX_USE_CXX11_ABI=0 ./getpythia8.sh /opt/pythia8
sudo ./getpythia8.sh /opt/pythia8
if test -d /opt/pythia8/lib64 ; then
   echo "/opt/pythia8/lib64" > /etc/ld.so.conf.d/pythia8.conf
else
   echo "/opt/pythia8/lib" > /etc/ld.so.conf.d/pythia8.conf
fi
/sbin/ldconfig -v


