#! /bin/bash

# check for computer name
if [ -z $COMPUTER_NAME ]; then
  echo "getting computer name from ~/.name"
  if [ ! -f ~/.name ]; then
    echo "[ERROR] ~/.name not found!"
    echo "create it, and press any key to continue..."
    read
  fi
  export COMPUTER_NAME=`cat ~/.name`
fi

# check for homebrew
if [ ! `which brew` ]; then
  echo "installing homebrew"

  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install > /tmp/homebrew-install.rb
  ruby /tmp/homebrew-install.rb
  rm /tmp/homebrew-install.rb
fi

# homebrew apps
echo "installing apps from homebrew"
osx/homebrew/Brewfile
osx/homebrew/Caskfile

pushd . &>/dev/null

cd osx
# stow config files
stow --adopt -t ~ stow

popd &>/dev/null

# app setup
boot2docker init
ln -sf ~/.appsettings/iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist 2> /dev/null

# osx defaults
osx/defaults.sh
