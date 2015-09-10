#! /bin/bash
echo "installing fedora components"

yum update -y &&
  yum install -y curl vim stow git ctags-etags
