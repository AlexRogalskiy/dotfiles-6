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
alias vi="nvim"

for key in $HOME/.ssh/*_rsa*.pub; do
    ssh-add -K "$(sed s,.pub,,g <<< "$key")" &>/dev/null
done

function cdr() { cd $GOPATH/src/github.com/roboll/$@; }

function vapor-status { linode show vapor | awk '/status/ { $1=""; print "vapor:"$0 }'; }
function vapor-down { linode stop vapor; }
function vapor-up {
    linode show vapor | awk '/status/ { print $2 }' | grep -q running || linode start vapor
    until linode show vapor | grep -q "status: running"; do
        echo 'Waiting for vapor status running.'
        sleep 5
    done

    ssh -t linode vapor
}
