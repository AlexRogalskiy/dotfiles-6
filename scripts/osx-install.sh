#! /bin/bash

# check for computer name
if [ -z $COMPUTER_NAME ]; then
  if [ ! -f ~/.name ]; then
    echo "computer name not found; enter a name.."
    read name
    echo $name > ~/.name
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

# install homebrew apps
echo "installing apps from homebrew"
pushd "$(dirname "${BASH_SOURCE}")" >/dev/null
./../homebrew/Brewfile
./../homebrew/Caskfile

./osx-install-extras.sh
./osx-defaults.sh
popd >/dev/null

ln -sf ~/.iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/
