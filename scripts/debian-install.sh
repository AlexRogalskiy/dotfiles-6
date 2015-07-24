#! /bin/bash

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

apt-get update -y >/tmp/dotfiles.log && 
  apt-get install -y curl vim stow git exuberant-ctags >/tmp/dotfiles.log
