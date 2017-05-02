#! /usr/bin/env bash

export EDITOR=nvim
alias vi="nvim"
alias vim="nvim"

export GOPATH=$HOME/dev

PATH=/usr/local/bin:$HOME/bin:$GOPATH/bin:$PATH
export PATH

alias g="git"
alias k="kubectl"
alias tf="terraform"
alias vi="nvim"

eval `gimme 1.8`

for key in $HOME/.ssh/*_rsa*.pub; do
    ssh-add -K "$(sed s,.pub,,g <<< "$key")" &>/dev/null
done

function cdr() { cd $GOPATH/src/github.com/roboll/$@; }

function tmx() {
    [ -z "$TMUX" ] && {
        tmux -2 new-session -A -s "uber"
        builtin exit
    }
}

function exit() {
  [ -z "$TMUX" ] || {
    if [[ "$(tmux list-panes | wc -l)" == "1" ]]; then
      tmux detach
    else
      tmux kill-pane
    fi
  }
}

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  tmx
fi
