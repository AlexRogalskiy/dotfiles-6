#! /usr/bin/env bash

export EDITOR=nvim
alias vi="nvim"
alias vim="nvim"

export GOPATH=$HOME/dev

export AWS_VAULT_KEYCHAIN_NAME=login

PATH=/usr/local/bin:$HOME/bin:$GOPATH/bin:$PATH
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

export PATH

alias git="hub"
alias g="git"
alias tf="terraform"

for key in $HOME/.ssh/*_rsa*.pub; do
    ssh-add -K "${key%.pub}"
done

function make() {
    /usr/bin/make -j "$@"
}
