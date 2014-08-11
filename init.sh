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

  if [[ -f local_config.sh ]]; then
    source local_config.sh
  else
    echo "WARN: local_config.sh did not exist. did you set a computer name?"
    sleep 5
  fi

  export COMPUTER_NAME=${COMPUTER_NAME:-rb-mac}
  echo "Computer name set to '$COMPUTER_NAME'."
 
  if [[ `uname` == "Darwin" ]]; then
    setup_mac
  fi

  migrate_dotfiles

  mkdir -p ~/dev
  source ~/.bash_profile
  crontab ~/.crontab
  sudo sh -c "echo '\n\n#docker vm\n192.168.59.103\tdocker\n' >> /etc/hosts"
  sudo touch /var/log/upup.log
  sudo chmod g+w /var/log/upup.log
}

run
