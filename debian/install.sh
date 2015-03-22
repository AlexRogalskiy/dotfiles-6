#! /bin/bash

echo "(apt output in apt.log)"
sudo apt-get update -y >apt.log && 
  sudo apt-get install -y curl vim stow git >apt.log
