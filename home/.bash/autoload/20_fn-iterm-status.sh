#!/usr/bin/env bash

function iterm-update-kube-status {
    config="${HOME}/.kube/config"
    marker="${HOME}/.prompt-kubectl-lastrun"

    if [ "${marker}" -ot "${config}" ]; then
        echo "marker is older than the config" >&2

        kubectx="$(kubectl config current-context)"
        kubens="$(kubectl config get-contexts ${kubectx} --no-headers | awk ' { print $5; }')"

        echo -ne "\033]50;SetUserVar=kubectx=$(echo -ne "⎈ ${kubectx}" | base64)\a"
        echo -ne "\033]50;SetUserVar=kubens=$(echo -ne "» ${kubens}" | base64)\a"

        touch "${marker}"
        return
    fi
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
