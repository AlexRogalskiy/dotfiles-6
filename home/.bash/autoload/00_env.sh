#!/usr/bin/env bash

export EDITOR="nvim"
# export PAGER=vimpager
# export MANPAGER="nvim -c MANPAGER -"

export GOPATH="$HOME/dev"

export AWS_VAULT_KEYCHAIN_NAME="login"

PATH="/usr/local/bin:$HOME/bin:$GOPATH/bin:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH
