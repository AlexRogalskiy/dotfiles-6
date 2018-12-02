#!/usr/bin/env bash

function iterm-update-kube-status {
    config="${HOME}/.kube/config"
    marker="${HOME}/.prompt-kubectl-lastrun"

    if [ -z "${kubeprompt}" ] || [ "${marker}" -ot "${config}" ]; then
        kubectx="$(kubectl config current-context 2>/dev/null)"
        if [ -z "${kubectx}" ]; then
            kubeprompt="$(date +%s)"
            touch "${marker}"

            return
        fi

        kubens="$(kubectl config get-contexts "${kubectx}" --no-headers | awk ' { print $5; }')"
        echo -ne "\033]50;SetUserVar=kubectx=$(echo -ne "⎈ ${kubectx} » ${kubens}" | base64)\a"

        kubeprompt="$(date +%s)"
        touch "${marker}"

        return
    fi
}

function iterm-clear-kube-status {
    echo -ne "\033]50;SetUserVar=kubectx=$(echo -ne "" | base64)\a"
}

function iterm-clear-status {
    iterm-clear-kube-status
}

function iterm-update-status {
    iterm-update-kube-status
}
