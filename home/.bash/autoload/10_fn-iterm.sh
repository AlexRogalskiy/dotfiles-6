#!/usr/bin/env bash

function iterm-profile() {
    NAME="$1"; if [ -z "$NAME" ]; then NAME="default"; fi
    echo -ne "\033]50;SetProfile=$NAME\a"
}

function iterm-reset() {
    NAME="default"
    echo -ne "\033]50;SetProfile=$NAME\a"
}

function iterm-title {
    echo -ne "\033]0;"$*"\007"
}

function get-kubectl-context {
    cache="${HOME}/.prompt-kubectl-context"

    # if cache exists
    if test -f "${cache}"; then
        now="$(date +%s)"
        mtime="$(stat -c %Y "${cache}")"

        # if cache is less than 10s old
        if [[ $mtime -gt $(($now - 5)) ]]; then
            cat "${cache}"
            return
        fi
    fi

    ctx="$(kubectl config current-context)"
    echo -ne "${ctx}" > "${cache}"
    echo -ne "${ctx}"
}

function get-kubectl-namespace {
    cache="${HOME}/.prompt-kubectl-namespace"

    # if cache exists
    if test -f "${cache}"; then
        now="$(date +%s)"
        mtime="$(stat -c %Y "${cache}")"

        # if cache is less than 10s old
        if [[ $mtime -gt $(($now - 5)) ]]; then
            cat "${cache}"
            return
        fi
    fi

    ns="$(kubectl config get-contexts $1 --no-headers | awk ' { print $5; }')"
    echo -ne "${ns}" > "${cache}"
    echo -ne "${ns}"
}

function iterm-update-kube-status {
    kubectx="$(get-kubectl-context)"
    kubens="$(get-kubectl-namespace $kubectx)"

    echo -ne "\033]50;SetUserVar=kubectx=$(echo -ne "⎈ ${kubectx}" | base64)\a"
    echo -ne "\033]50;SetUserVar=kubens=$(echo -ne "» ${kubens}" | base64)\a"
}

function iterm-clear-kube-status {
    echo -ne "\033]50;SetUserVar=kubectx=$(echo -ne "" | base64)\a"
    echo -ne "\033]50;SetUserVar=kubens=$(echo -ne "" | base64)\a"
}

function iterm-clear-status {
    iterm-clear-kube-status
}

function iterm-update-status {
    iterm-update-kube-status
}
