#! /usr/bin/env bash

export EDITOR=nvim
export PAGER=vimpager
export MANPAGER="nvim -c MANPAGER -"

alias vi="nvim"
alias vim="nvim"
alias cat="vimcat"

export GOPATH=$HOME/dev

PATH=/usr/local/bin:$HOME/bin:$GOPATH/bin:$PATH
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH

alias g="git"
alias k="kubectl"
alias tf="terraform"

for key in $HOME/.ssh/*_rsa*.pub; do
    ssh-add -K "${key%.pub}"
done

function cdr() { cd $GOPATH/src/github.com/roboll/$@; }
