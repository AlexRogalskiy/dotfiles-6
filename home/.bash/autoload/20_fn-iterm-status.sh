#!/usr/bin/env bash

function iterm-update-kube-status {
    if [[ -z "${KUBECTL_CONTEXT}" ]]; then
        iterm-clear-kube-status
    else
        echo -ne "\033]50;SetUserVar=kubectx=$(echo -ne "⎈ ${KUBECTL_CONTEXT} » ${KUBECTL_NAMESPACE:-default}" | base64)\a"
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
