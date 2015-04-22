#! /bin/bash

echo "(apt output in /tmp/apt.log)"
sudo apt-get update -y >/tmp/apt.log && 
  sudo apt-get install -y curl vim stow git exuberant-ctags >/tmp/apt.log
