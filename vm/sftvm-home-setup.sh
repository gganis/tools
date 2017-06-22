#!/bin/bash

# Create dirs
mkdir -p local/root/GIT
mkdir -p local/jenkins

# Config git
git config --global user.email "Gerardo.Ganis@cern.ch"
git config --global user.name "Gerardo Ganis"

# # Get tools
# cd local
# git clone https://github.com/gganis/tools.git
# cd ..

# Set symlinks
ln -sf local/tools/bin bin
ln -sf local/tools/etc etc
ln -sf local/tools/.git-prompt.sh .git-prompt.sh

# Complete .bashrc
cat local/tools/.bashrc >> .bashrc

# Get software
cd local/root/GIT
git clone https://github.com/root-project/root.git
git clone https://github.com/root-project/roottest.git
git clone https://github.com/root-project/rootspi.git

# Get to jenkins area
cd ~/local/jenkins
ln -sf ~/local/tools/jenkins tools
ln -sf ~/local/root/GIT/rootspi/jenkins GIT



