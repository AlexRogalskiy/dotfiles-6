#!/usr/bin/env zsh

# zsh
export PROMPT='%F{blue}%B%3~%b%(?.%F{green}.%F{red}) %(!.#.$) %f'
export RPROMPT='%(?..%F{red}%?)%f'

export EDITOR="nvim"

export PAGER="nvim -c PAGER -"
export MANPAGER="nvim -c MANPAGER -"

export GOPATH="$HOME/dev"
export PATH="$GOPATH/bin:$PATH"

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# datadog only
export PATH="$GOPATH/src/github.com/DataDog/devtools/bin:$PATH"
