#! /usr/bin/env bash

export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups:ignorespace
export HISTIGNORE="pwd:exit:date"
shopt -s histappend
shopt -s checkwinsize
shopt -s cdspell
shopt -s nocaseglob

if [ -f ~/.bashrc ]; then source ~/.bashrc; fi

hostfile="$HOME/.bash/host/$(hostname).sh"
if [ -f "$hostfile" ]; then source "$hostfile"; fi

secretfile="$HOME/.secrets.sh"
if [ -f "$secretfile" ]; then source "$secretfile"; fi

if [ "$(uname)" == "Darwin" ]; then source "$HOME/.bash/mac.sh"; fi
if [ "$(uname)" == "Linux"  ]; then source "$HOME/.bash/linux.sh"; fi

for file in $HOME/.bash/{config,util,prompt}.sh; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
