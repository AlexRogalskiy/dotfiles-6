#!/usr/bin/env bash

function setup_mac() {
  echo "configuring mac environment"
  install_homebrew

  ./.bootstrap_osx.sh
  ~/.appsettings/link.sh
}

function setup_linux() {
  echo "configuring linux environment"
}

function install_homebrew() {
  if [[ ! `command -v brew` ]]; then
    echo "installing homebrew..."
    curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install > homebrew-install.rb
    ruby homebrew-install.rb
    rm homebrew-install.rb
  fi

  brew bundle homebrew/Brewfile
  brew bundle homebrew/Caskfile
}

function migrate_dotfiles() {
  rsync --exclude ".git/" \
        --exclude ".DS_Store" \
        --exclude "bootstrap.sh" \
        --exclude ".bootstrap_osx.sh" \
        --exclude ".local_config" \
        --exclude "homebrew" \
        --exclude "README.md" \
        --exclude "LICENSE-MIT.txt" \
        -avh --no-perms . ~
}

function run() {
  cd "$(dirname "${BASH_SOURCE}")"
  source .local_config

  migrate_dotfiles

  if [[ $OS == "mac" ]]; then
    setup_mac
  fi

  mkdir -P ~/dev 2>/dev/null
  source ~/.bash_profile
}

if [ "$1" == "init" ]; then
  run
else
  echo "no option given. did you mean 'init'?"
fi
