#!/usr/bin/env zsh

export EDITOR="nvim"

export PAGER="nvim -c PAGER -"
export MANPAGER="nvim -c MANPAGER -"

export GOPATH="$HOME/dev"
export PATH="$GOPATH/bin:$PATH"

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# datadog only
export PATH="$GOPATH/src/github.com/DataDog/devtools/bin:$PATH"
