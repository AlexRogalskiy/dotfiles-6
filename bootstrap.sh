#! /usr/bin/env bash

# to run this
# curl -fsSL https://raw.githubusercontent.com/robertcboll/dotfiles/master/bootstrap.sh > /tmp/bootstrap.sh && sh /tmp/bootstrap.sh && rm /tmp/bootstrap.sh

if [ -z $NOGIT ]; then
  curl -#L https://github.com/robertcboll/dotfiles/tarball/master | tar -xzv -C ~/.dotfiles
else
  git clone --recursive https://github.com/robertcboll/dotfiles.git ~/.dotfiles
fi

exec ~/.dotfiles/install.sh
