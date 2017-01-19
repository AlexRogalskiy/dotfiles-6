#! /usr/bin/env bash

export EDITOR=nvim

export GOPATH=$HOME/dev
export PATH=/usr/local/bin:$HOME/bin:$GOPATH/bin:$PATH

export PROMPT_HOST_COLOR="\[\e[0;36m\]"

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
