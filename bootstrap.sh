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

if [ “$1” == “setup” ]; then
	install_homebrew
	install_apps
	setup_files
	cd ~/.appsettings && ./link.sh;
elif [ “$1” == “osx” ]; then
	~/.osx
else
	setup_files
fi

unset install_homebrew
unset install_apps
unset setup_files

source ~/.bash_profile

