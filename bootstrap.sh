#! /usr/bin/env bash

if [ ! `which git` ]; then
  echo 'git is required'
  exit 1
fi

git clone --recursive https://github.com/robertcboll/dotfiles.git ~/.dotfiles
exec ~/.dotfiles/install.sh
