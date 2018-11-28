#!/usr/bin/env bash

export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups:ignorespace
export HISTIGNORE="pwd:exit:date"
shopt -s histappend
shopt -s checkwinsize
shopt -s cdspell
shopt -s nocaseglob

if [ -f ~/.bashrc ]; then source ~/.bashrc; fi

secretfile="$HOME/.secrets.sh"
if [ -f "$secretfile" ]; then source "$secretfile"; fi

for file in $(find "$HOME/.bash/autoload/" -type f | sort); do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done

# when not in tmux
# disabled because not using tmux locally right now
#test -z "$TMUX" && {
    # load ssh keys into ssh-agent
    for key in $HOME/.ssh/*_rsa*.pub; do
        ssh-add -K "${key%.pub}"
    done

    # exec create/attach
    # exec tmux -2CC new -A -s "${HOSTNAME}"
    # tmux -2CC
#}
