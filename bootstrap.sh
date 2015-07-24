#! /usr/bin/env bash

install_git_mac() {
  xcode-select --install
}

install_git_linux() {
  if [ "$(which apt-get)" ]; then
    apt-get install -y git
  fi
}

# delegates to platform specific install methods
install_git() {
  case $(uname) in 
    darwin ) install_git_mac    ;;
    linux  ) install_git_linux  ;;
  esac
}


# run
if [ ! "$(which git)" ]; then
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
