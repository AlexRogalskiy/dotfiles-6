#!/usr/bin/env bash

function install_homebrew() {
	echo "installing homebrew..."
	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
}

function install_apps() {
	brew bundle ~/.homebrew/Brewfile
	brew bundle ~/.homebrew/Caskfile
}

function setup_files() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "LICENSE-MIT.txt" -avh --no-perms . ~
}

alias subl=“”
cd "$(dirname "${BASH_SOURCE}")"
#git pull origin master

if [ "$1" == "init" ]; then
	install_homebrew
	setup_files
	install_apps
elif [ "$1" ==  "osx" ]; then
	setup_files
  ~/.osx
else
	setup_files
  if [ "$1" !=  "nobrew" ]; then
    install_apps
  fi
fi

unset install_homebrew
unset install_apps
unset setup_files

echo "linking app settings"
cd ~/.appsettings && ./link.sh

echo "sourcing bash profile"
source ~/.bash_profile

mkdir ~/Logs 2>/dev/null
mkdir ~/Workspace 2>/dev/null

# sudo kextload /Library/Extensions/tun.kext
# sudo kextload /Library/Extensions/tap.kext
