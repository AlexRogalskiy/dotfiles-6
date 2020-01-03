#!/usr/bin/env zsh

# case insensitive autocomplete match
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
