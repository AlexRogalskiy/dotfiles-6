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
	source ~/.bash_profile
	~/.osx
}

cd "$(dirname "${BASH_SOURCE}")"
#git pull origin master

if [ "$1" == “—-setup” ]; then
	install_homebrew
	setup_files
	install_apps
	cd ~/.appsettings && ./link.sh
else
	setup_files
fi

unset install_homebrew
unset install_apps
unset setup_files
