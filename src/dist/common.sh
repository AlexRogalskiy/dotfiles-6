#! /usr/bin/env bash
set -eo pipefail

install_dotfiles() {
    if [ -d common ]; then
        [ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.old
        [ -f ~/.bash_profile ] && mv ~/.bash_profile ~/.bash_profile.old

        pushd common >/dev/null
        stows=($(ls -d */))
        log_info "Stowing ${stows[*]}."
        for dir in "${stows[@]}"; do stow -t ~ "$dir"; done;
        popd >/dev/null
    fi

    if [ -d "$DISTRO" ]; then
        pushd "$DISTRO" >/dev/null
        stows=($(ls -d */))
        log_info "Stowing ${stows[*]}."
        for dir in "${stows[@]}"; do stow -t ~ "$dir"; done;
        popd >/dev/null
    fi

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

    command -v vim > /dev/null && {
        log_info "Installing vim plugins."
        vim !silent +PlugInstall +qall
    }
}
