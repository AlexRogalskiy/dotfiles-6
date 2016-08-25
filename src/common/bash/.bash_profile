#! /usr/bin/env bash
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups:ignorespace
export HISTIGNORE="pwd:exit:date"
shopt -s histappend
shopt -s checkwinsize
shopt -s cdspell
shopt -s nocaseglob

alias vi=nvim
alias vim=nvim

alias reload="exec \$SHELL -l"

for file in $HOME/.bash/{$(hostname),all,path,mac,linux,prompt}.bash; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done

[ -f "$HOME/.secrets" ] && source "$HOME/.secrets"
unset file
