#!/usr/bin/env bash

function k() {
    test -z "${KUBECTL_CONTEXT}" && { echo "KUBECTL_CONTEXT not set, run kc" >&2 && return 1; }
    kubectl --context "${KUBECTL_CONTEXT}" --namespace "${KUBECTL_NAMESPACE:-default}" $@
}

function kc() {
    KUBECTL_CONTEXT="${@}"
}

function kcns() {
    KUBECTL_NAMESPACE="${@}"
}

function _kc_completion() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(kubectl config get-contexts -o name)

    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
    return 0
}

complete -F _kc_completion kc

function _kcns_completion() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(k get ns -o name | sed s,namespace/,,g)

    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
    return 0
}

complete -F _kcns_completion kcns
