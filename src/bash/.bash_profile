#! /usr/bin/env bash

export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups:ignorespace
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"
shopt -s histappend
shopt -s checkwinsize
shopt -s cdspell
shopt -s nocaseglob

export EDITOR=vim
export PAGER=vimpager
export MANPAGER=vimpager

alias reload="exec \$SHELL -l"

for file in $HOME/.bash/{all,path,mac,home,home_prompt}.bash; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file
