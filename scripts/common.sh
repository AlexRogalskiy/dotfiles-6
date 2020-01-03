#! /usr/bin/env bash
set -euo pipefail

install() {
    log_info "Stowing home."
    stow -t "$HOME" home

    command -v gem >/dev/null && {
        log_info "Installing from gem."
        sudo gem install mdl
    }

    command -v npm >/dev/null && {
        log_info "Installing from npm."
        sudo npm install -g js-yaml jsonlint recess
    }

    command -v pip >/dev/null && {
        log_info "Installing from pip."
        sudo pip install neovim
    }
    command -v pip3 >/dev/null && {
        log_info "Installing from pip3."
        sudo pip3 install neovim
    }

    export GOPATH=$HOME/dev
    command -v nvim >/dev/null && {
        log_info "Installing neovim plugins."
        nvim !silent +PlugInstall +qall
    }
}
