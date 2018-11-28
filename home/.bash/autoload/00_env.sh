#!/usr/bin/env bash

PROMPT_COMMAND='git-prompt'

export EDITOR="nvim"
export PAGER="nvim -c PAGER -"
export MANPAGER="nvim -c MANPAGER -"

export GOPATH="$HOME/dev"

export AWS_VAULT_KEYCHAIN_NAME="login"

PATH="/usr/local/bin:$HOME/bin:$GOPATH/bin:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH
