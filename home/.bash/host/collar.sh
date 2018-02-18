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
alias k="kubectl"
alias tf="terraform"

for key in $HOME/.ssh/*_rsa*.pub; do
    ssh-add -K "${key%.pub}"
done

function make() {
    /usr/bin/make -j "$@"
}

function cdr() { cd $GOPATH/src/github.com/roboll/$@; }
function cdd() { cd $GOPATH/src/github.com/DataDog/$@; }

function vapor {
    case "$1" in
        up)     _vapor-up ;;
        down)   _vapor-down ;;
        status) _vapor-status ;;
        *)
            echo "up, down, ssh, or status"
            return 1
            ;;
    esac
}

function _vapor-status { linode show vapor | awk '/status/ { $1=""; print "vapor:"$0 }'; }
function _vapor-down { linode stop vapor; }
function _vapor-up {
    linode show vapor | awk '/status/ { print $2 }' | grep -q running || linode start vapor
    until linode show vapor | grep -q "status: running"; do
        echo 'Waiting for vapor status running.'
        sleep 5
    done

    echo "!! Enter decrypt passphrase, then control-a d to disconnect from login prompt."
    ssh -t linode vapor
}
