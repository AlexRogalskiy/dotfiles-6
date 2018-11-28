#!/usr/bin/env bash

alias k="kubectl"

# config
alias kconf="kubectl config use-context"

function kns() {
    kubectl config set-context $(kubectl config current-context) --namespace=$@
}

# nodes
alias kno="kubectl get no"
alias knot="kubectl get no"

alias nodeips="kubectl get no -o jsonpath=\"{.items[*].status.addresses[?(@.type == 'InternalIP')].address}\""

alias kma="kubectl get no -l node-role.kubernetes.io/master="
alias ketcd="kubectl get no -l node-role.kubernetes.io/etcd="
alias kcompute="kubectl get no -l node-role.kubernetes.io/compute="

# pods
alias kp="kubectl get po"
alias kpo="kubectl get po"

alias podips="kubectl get pods --all-namespaces -o=custom-columns=NAME:.metadata.name,IP:.status.podIP"

# all
alias ka="kubectl get all --all-namespaces"
alias kall="kubectl get all --all-namespaces"
