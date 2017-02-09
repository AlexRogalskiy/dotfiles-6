#! /usr/bin/env bash

export EDITOR=nvim

export GOPATH=$HOME/dev
export PATH=/usr/local/bin:$HOME/bin:$GOPATH/bin:$PATH

alias g="git"
alias k="kubectl"
alias tf="terraform"

alias notes="vi ~/Dropbox/Notes"

for key in $HOME/.ssh/*_rsa*.pub; do
    ssh-add -K "$(sed s,.pub,,g <<< "$key")" &>/dev/null
done
