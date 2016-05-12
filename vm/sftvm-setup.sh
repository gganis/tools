#!/bin/bash

# Upgrade to latest version and install packages required by ROOT
./sftvm-sys-update.sh

# Update ntp
./sftvm-ntp-setup.sh

# Disable SElinux
./sftvm-selinux-off.sh

# Groups and users
./sftvm-users-groups.sh

# Make sure /build is there
./sftvm-assert-build.sh
   
# Installing xrootd
./sftvm-xrootd.sh

# Installing pythia8
./sftvm-pythia8.sh


