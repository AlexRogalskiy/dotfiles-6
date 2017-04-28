#! /usr/bin/env bash

export EDITOR=nvim
alias vi="nvim"
alias vim="nvim"

export GOPATH=$HOME/dev

PATH=/usr/local/bin:$HOME/bin:$GOPATH/bin:$PATH
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH

alias g="git"
alias k="kubectl"
alias tf="terraform"

alias notes="vi ~/Dropbox/Notes"

for key in $HOME/.ssh/*_rsa*.pub; do
    ssh-add "$HOME/.ssh/$key" &>/dev/null
done
