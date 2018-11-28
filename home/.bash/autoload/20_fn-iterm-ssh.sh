#!/usr/bin/env bash

# change profiles on ssh sessions
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
