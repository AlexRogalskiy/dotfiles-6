#!/usr/bin/env bash

# enable sudo'ing aliases
alias sudo='sudo '
alias reload="exec \$SHELL -l"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias tf="terraform"

alias vi="nvim"
alias vim="nvim"

alias localip="ipconfig getifaddr en0"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias myips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
