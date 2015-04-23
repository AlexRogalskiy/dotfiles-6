#! /usr/bin/env bash

# tries to install git based on dist
try_install_git() {
  case `uname` in
    "Darwin")
      echo "installing xcode cli tools"
      xcode-select --install
      ;;
    "Linux")
      if [ -f /etc/debian_version ]; then
        echo "(apt output in /tmp/apt.log)"
        apt-get install -y git >/tmp/apt.log
      else
        echo "could not install git"
        return 1
      fi
      ;;
  esac
}

# run
if [ ! `which git` ]; then
  echo 'trying to install git'
  try_install_git || exit 1
fi

echo "updating dotfiles"
if [ ! -d ~/.dotfiles ]; then
  git clone --recursive --quiet https://github.com/robertcboll/dotfiles.git ~/.dotfiles
else
  pushd ~/.dotfiles >/dev/null
  git pull
  popd >/dev/null
fi
exec ~/.dotfiles/install.sh
