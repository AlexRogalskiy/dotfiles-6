#!/usr/bin/env bash

# nodes
alias kno="k get no"
alias knot="k get no"

alias nodeips="k get no -o jsonpath=\"{.items[*].status.addresses[?(@.type == 'InternalIP')].address}\""

alias kma="k get no -l node-role.kubernetes.io/master="
alias ketcd="k get no -l node-role.kubernetes.io/etcd="
alias kcompute="k get no -l node-role.kubernetes.io/compute="

# pods
alias kp="k get po"
alias kpo="k get po"

alias podips="k get pods --all-namespaces -o=custom-columns=NAME:.metadata.name,IP:.status.podIP"

# all
alias ka="k get all --all-namespaces"
alias kall="k get all --all-namespaces"
