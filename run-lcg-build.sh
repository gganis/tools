#!/bin/bash -x

export LABEL=$1
export LCG_INSTALL_PREFIX=/cvmfs/sft.cern.ch/lcg/releases
export LCG_IGNORE=
export VERSION_MAIN=master
export TARGET=all
export TEST_LABELS=Release
export VERSION_JENKINS=master
export LCG_EXTRA_OPTIONS="-DLCG_SOURCE_INSTALL=OFF;-DLCG_TARBALL_INSTALL=ON;-Wno-dev"
export LCG_VERSION=dev4
export BUILDMODE=nightly
export DOCKER_CPUS=
unset CVMFS_INSTALL
unset RUN_TEST
export COMPILER=gcc8binutils
export BUILDTYPE=Release

bash -x lcgjenkins/docker-runbuild.sh
export PLATFORM=$(grep $WORKSPACE/properties.txt -e PLATFORM | cut -d'=' -f2)
