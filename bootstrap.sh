#! /usr/bin/env bash

if [ ! `which git` ]; then
  echo 'trying to install git'
  try_install_git || exit 1
fi

echo "cloning dotfiles"
git clone --recursive https://github.com/robertcboll/dotfiles.git ~/.dotfiles
exec ~/.dotfiles/install.sh

try_install_git() {
  case `uname` in
    "Darwin")
      exec "xcode-select --install"
      ;;
    "Linux")
      if [ -f /etc/debian_version]; then
        exec "apt-get install -y git"
      else
        echo "could not install git"
        return 1
      fi
      ;;
  esac
}
