#!/bin/bash

# add alfred to dotfiles

setup_mac() {
  echo "configuring mac environment"
  install_homebrew

  ./.bootstrap_osx.sh
  ~/.iterm2/link.sh
}

setup_linux() {
  echo "configuring linux environment"
  sudo apt-get install -y stow
  sudo apt-get install -y git
}

install_homebrew() {
  if [ ! `command -v brew` ]; then
    echo "installing homebrew..."
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install > homebrew-install.rb
    ruby homebrew-install.rb
    rm homebrew-install.rb
  fi

  echo "installing brew packages..."
  homebrew/Brewfile
  homebrew/Caskfile
}

link_dotfiles() {
  #stolen from github.com/ianferguson/dotfiles
  STOWAWAYS=(bash git bin psql vim ssh sbt)

  if [[ `uname` == "Darwin" ]]; then
    stowopts="-R -t --adopt"
  else
    stowopts="-R -t --adopt"
  fi

  for STOWAWAY in ${STOWAWAYS[@]}; do
    echo "stowing $STOWAWAY"
    stow $stowopts ~ $STOWAWAY
  done;

  if [[ `uname` == "Darwin" ]]; then
    STOWAWAYS=(iterm2 intellij cron docker)
    for STOWAWAY in ${STOWAWAYS[@]}; do
      echo "stowing $STOWAWAY"
      stow $stowopts ~ $STOWAWAY
    done;
  fi
}

run() {
  cd "$(dirname "${BASH_SOURCE}")"

  if [[ -f ~/.hostname ]]; then
    BOX_NAME=$(cat ~/.hostname)
  else
    echo "WARN: ~/.hostname did not exist. did you set a computer name?"
    sleep 5
  fi

  export BOX_NAME=${BOX_NAME:-default}
  echo "Computer name set to '$BOX_NAME'."
 
  if [[ `uname` == "Darwin" ]]; then
    setup_mac
    boot2docker init
    crontab ~/.crontab
    sudo sh -c "echo '\n\n#docker vm\n192.168.59.103\tdocker\n' >> /etc/hosts"
    sudo touch /var/log/upup.log
    sudo chmod g+w /var/log/upup.log
  fi

  link_dotfiles

  mkdir -p ~/dev
  source ~/.bash_profile

  curl https://github.com/robertcboll.keys >> ~/.ssh/authorized_keys 
}

run
