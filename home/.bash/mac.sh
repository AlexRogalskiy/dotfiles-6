#! /usr/bin/env bash

# homebrew autocomplete
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
	source "$(brew --prefix)/etc/bash_completion"
fi

# empty trash and clear system logs
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

function iterm-profile() {
  NAME=$1; if [ -z "$NAME" ]; then NAME="default"; fi
  echo -e "\033]50;SetProfile=$NAME\a"
}

function iterm-reset() {
    NAME="default"
    echo -e "\033]50;SetProfile=$NAME\a"
}

function iterm-ssh() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "iterm-reset" INT EXIT
        if grep -q "prod" <<< $*; then
            iterm-profile ssh-prod
        else
            iterm-profile ssh
        fi
    fi
    ssh $*
    iterm-reset
}

alias ssh="iterm-ssh"
