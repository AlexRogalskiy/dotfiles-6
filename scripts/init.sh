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

command -v gsettings > /dev/null && [ $(uname) == "Linux" ] && {
    gsettings set org.pantheon.terminal.settings tab-bar-behavior 'Hide When Single Tab'
    gsettings set org.gnome.settings-daemon.peripherals.keyboard repeat-interval 15
}

[ -n "$GOPATH" ] && export GOPATH=$HOME/go
command -v vim > /dev/null && {
    echo ">> Installing vim plugins."
    vim !silent +PlugInstall +qall
}
command -v nvim > /dev/null &&  {
    echo ">> Installing neovim plugins."
    nvim !silent +PlugInstall +qall
}

echo ">> Pulling SSH pubkeys from github."
curl -s https://github.com/roboll.keys > ~/.ssh/authorized_keys
