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
  STOWAWAYS=(bash git bin appsettings vim ssh cron docker ondeck)
  for STOWAWAY in ${STOWAWAYS[@]}; do
    echo "stowing $STOWAWAY"
    stow -R --adopt -t ~ $STOWAWAY
  done;
}

function run() {
  cd "$(dirname "${BASH_SOURCE}")"
  source bash/.local_config

  if [[ $OS == "mac" ]]; then
    setup_mac
  fi

  migrate_dotfiles

  mkdir -p ~/dev
  source ~/.bash_profile
  crontab ~/.crontab
  sudo sh -c "echo '\n\n#docker ip\n192.168.59.103\tdocker\n' >> /etc/hosts"
  sudo touch /var/log/upup.log
  sudo chmod g+w /var/log/upup.log
}

run
