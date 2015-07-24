#! /bin/bash

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

yum update >/tmp/dotfiles.log && 
  yum install curl vim stow git exuberant-ctags >/tmp/dotfiles.log
