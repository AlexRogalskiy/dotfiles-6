#! /usr/bin/env bash
set -e

pushd "$(dirname "${BASH_SOURCE}")/../src" >/dev/null

stows=($(ls -d */))
for dir in "${stows[@]}"; do stow --adopt -t ~ "$dir"; done;

popd &>/dev/null

echo ">> Installing from gem."
sudo gem install mdl

echo ">> Installing from npm."
sudo npm install -g js-yaml jsonlint recess

echo ">> Installing from pip."
sudo pip install neovim
sudo pip3 install neovim

echo ">> Installing vim plugins."
[ -n "$GOPATH" ] && export GOPATH=$HOME/go
command -v vim > /dev/null && vim !silent +PlugInstall +qall
command -v nvim > /dev/null && nvim !silent +PlugInstall +qall

echo ">> Pulling SSH pubkeys from github."
curl -s https://github.com/roboll.keys > ~/.ssh/authorized_keys
