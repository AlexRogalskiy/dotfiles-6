#! /usr/bin/env bash
set -e

echo ">> Installing for OS X."
"$(dirname "${BASH_SOURCE}")"/configure.sh

command -v brew >/dev/null 2>&1 || {
    echo ">> Installing homebrew."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

echo ">> Installing from homebrew."
brew update --all
brew upgrade --all

# install cask first
brew install caskroom/cask/brew-cask

# first
brew install stow
brew cask install iterm2
ln -sf ~/.iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/

brew cask install slack \
    1password dropbox \
    caffeine alfred switchresx \
    google-chrome spotify \
    pritunl
#brew cask install flexiglass # paid for on app store

# basics
brew install bash bash-completion coreutils ack
brew install tree ctags hg git gist hub ghi
brew install findutils gnu-tar gnu-sed homebrew/dupes/grep --with-default-names

brew install python python3 ruby node go

brew tap neovim/neovim
brew install neovim

brew install wget --with-iri
brew install vim --override-system-vi --with-lua
brew install vimpager

#brew cask install openzfs
#brew cask install osxfuse
#brew install homebrew/fuse/encfs

# java and friends, and unzip jdk_source
brew cask install java
#brew cask install intellij-idea-ce visualvm

brew install scala gradle leiningen sbt ant nailgun maven

for i in /Library/Java/JavaVirtualMachines/*; do
    sudo mkdir -p "$i/Contents/Home/jdk_source"
    sudo chmod g+w "$i/Contents/Home/jdk_source"
    sudo unzip -quo "$i/Contents/Home/src.zip" -d "$i/Contents/Home/jdk_source"
done

# pg
brew install postgresql
brew cask install pgadmin3

# virt
brew cask install vagrant virtualbox

brew install \
    keybase \
    jsonpp jq \
    docker docker-machine \
    closure-compiler shellcheck markdown \
    ansible awscli

# fonts
brew cask install \
    caskroom/fonts/font-inconsolata \
    caskroom/fonts/font-inconsolata-dz \
    caskroom/fonts/font-inconsolata-dz-for-powerline

# quicklook plugins
brew cask install \
    quicklook-json \
    quicklook-csv \
    qlcolorcode \
    qlmarkdown \
    qlprettypatch \
    betterzipql

brew cleanup
brew cask cleanup
