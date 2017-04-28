#! /usr/bin/env bash
set -euo pipefail

install() {
    [ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bk
    [ -f ~/.bash_profile ] && mv ~/.bash_profile ~/.bash_profile.bk

    log_info "Stowing home."
    stow -t "$HOME" home

    log_info "Installing from gem."
    sudo gem install mdl

    log_info "Installing from npm."
    sudo npm install -g js-yaml jsonlint recess

    log_info "Installing from pip."
    command -v pip > /dev/null && sudo pip install neovim
    command -v pip2 > /dev/null && sudo pip2 install neovim
    command -v pip3 > /dev/null && sudo pip3 install neovim

    [ -n "$GOPATH" ] && export GOPATH=$HOME/dev
    command -v nvim > /dev/null && {
        log_info "Installing neovim plugins."
        nvim !silent +PlugInstall +qall
    }
}
