#!/usr/bin/env bash

function setup_mac() {
  echo "configuring mac environment"
  if [ ! $NOBREW ]; then
    install_homebrew
  else
    echo "skipping homebrew install"
  fi

  ./.bootstrap_osx.sh
  ~/.appsettings/link.sh
}

function setup_linux() {
  echo "configuring linux environment"
}

function install_homebrew() {
  if [ ! `command -v brew` ]; then
    echo "installing homebrew..."
    curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install > homebrew-install.rb
    ruby homebrew-install.rb
    rm homebrew-install.rb
  fi

  echo "installing brew packages..."
  brew bundle homebrew/Brewfile
  brew bundle homebrew/Caskfile
}

function migrate_dotfiles() {
  #stolen from github.com/ianferguson/dotfiles
  STOWAWAYS=(bash git bin appsettings vim)
  for STOWAWAY in ${STOWAWAYS[@]}; do
    echo "stowing $STOWAWAY"
    stow -R --adopt -t ~ $STOWAWAY
  done;
}

function run() {
  if [[ $1 == "nobrew" ]]; then
    NOBREW=true
  else
    NOBREW=false
  fi

  cd "$(dirname "${BASH_SOURCE}")"
  source bash/.local_config

  if [[ $OS == "mac" ]]; then
    setup_mac
  fi

  migrate_dotfiles

  mkdir -p ~/dev
  source ~/.bash_profile
}

if [[ $1 == "init" ]]; then
  run
elif [[ $1 == "up" ]]; then
  run nobrew
fi
