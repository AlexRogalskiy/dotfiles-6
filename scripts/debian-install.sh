#! /bin/bash
echo "installing debian components"

apt-get update -y &&
    apt-get install -y sudo curl vim-nox stow git exuberant-ctags
