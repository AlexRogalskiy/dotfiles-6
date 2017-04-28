#! /usr/bin/env bash

export EDITOR=nvim
alias vi="nvim"
alias vim="nvim"

export GOPATH=$HOME/dev

PATH=/usr/local/bin:$HOME/bin:$HOME/macbin:$GOPATH/bin:$PATH
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH

alias g="git"
alias k="kubectl"
alias tf="terraform"
alias vi="nvim"


function cdr() { cd $GOPATH/src/github.com/roboll/$@; }

for key in $HOME/.ssh/*_rsa*.pub; do
    ssh-add -K "$(sed s,.pub,,g <<< "$key")" &>/dev/null
done
