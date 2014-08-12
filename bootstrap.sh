#! /usr/bin/env bash

# to run this
# curl -fsSL https://raw.githubusercontent.com/robertcboll/dotfiles/master/bootstrap.sh > /tmp/bootstrap.sh && sh /tmp/bootstrap.sh && rm /tmp/bootstrap.sh

mkdir -p ~/dev
cd ~/dev
git clone --recursive https://github.com/robertcboll/dotfiles.git
sh ~/dev/dotfiles/init.sh

