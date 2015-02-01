#!/bin/bash

# add alfred to dotfiles

setup_mac() {
  echo "configuring mac environment"
  install_homebrew

  ./.bootstrap_osx.sh
  ~/.appsettings/link.sh
}

setup_linux() {
  echo "configuring linux environment"
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

migrate_dotfiles() {
  #stolen from github.com/ianferguson/dotfiles
  STOWAWAYS=(bash git bin psql vim ssh sbt)
  for STOWAWAY in ${STOWAWAYS[@]}; do
    echo "stowing $STOWAWAY"
    stow -R -t ~ $STOWAWAY
  done;

  if [[ `uname` == "Darwin" ]]; then
    STOWAWAYS=(iterm2 cron docker)
    for STOWAWAY in ${STOWAWAYS[@]}; do
      echo "stowing $STOWAWAY"
      stow -R -t --adopt ~ $STOWAWAY
    done;
  fi
}

run() {
  cd "$(dirname "${BASH_SOURCE}")"

  if [[ -f ~/.local_config.sh ]]; then
    source ~/.local_config.sh
  else
    echo "WARN: ~/.local_config.sh did not exist. did you set a computer name?"
    sleep 5
  fi

  export COMPUTER_NAME=${COMPUTER_NAME:-rb-mac}
  echo "Computer name set to '$COMPUTER_NAME'."
 
  if [[ `uname` == "Darwin" ]]; then
    setup_mac
    boot2docker init
    crontab ~/.crontab
    sudo sh -c "echo '\n\n#docker vm\n192.168.59.103\tdocker\n' >> /etc/hosts"
    sudo touch /var/log/upup.log
    sudo chmod g+w /var/log/upup.log
  fi

  migrate_dotfiles

  mkdir -p ~/dev
  source ~/.bash_profile

  curl https://github.com/robertcboll.keys >> ~/.ssh/authorized_keys 
}

run
