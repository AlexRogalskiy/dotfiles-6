#!/usr/bin/env zsh

# k8s shortcuts
alias k="kubectl"
alias kpo="kubectl get pods"
alias kno="kubectl get nodes"

function kc {
  if [[ -z "${@}" ]]; then
    kubectl config unset current-context
  else
    kubectl config use-context "${@}"
  fi
}

function _kc {
  local contexts

  zstyle -s ':kc:' contexts contexts

  if [[ -z "$contexts" ]] || _kubeconfig_is_modified; then
    contexts=$(kubectl config get-contexts -oname)
    zstyle ':kc:' contexts "$contexts"
  fi

  _arguments -C "1: :($contexts)"
}

compdef _kc kc

function kns {
  kubectl config set-context --current --namespace="${@}"
}

function _kns {
  local namespaces="$(kubectl get ns -o custom-columns=":metadata.name" --no-headers)"
  _arguments -C "1: :(${namespaces})"
}

compdef _kns kns

# utilities
function _kubeconfig_is_modified {
  local kubeconfig configfile kubeconfig_modtime kubeconfig_lastmodtime

  kubeconfig="$HOME/.kube/config"
  if [[ -n "$KUBECONFIG" ]]; then
    kubeconfig="$KUBECONFIG"
  fi

  # concatenate modtime of all kubeconfig files
  while read -d ":" configfile; do
    if ! kubeconfig_modtime="${kubeconfig_modtime}$(stat -L -f%m "$configfile" 2>/dev/null)"; then
      echo "$configfile doesn't exist"
      return 1
    fi
  done <<< "${kubeconfig}:"

  # compare kubeconfig_modtime with stored value, if same, no change
  zstyle -s ':zsh-kubeconfig-prompt:' kubeconfig_modtime kubeconfig_lastmodtime
  if [[ "$kubeconfig_modtime" == "$kubeconfig_lastmodtime" ]]; then
    return 1
  fi

  zstyle ':zsh-kubeconfig-prompt:' kubeconfig_modtime "$kubeconfig_modtime"
  return 0
}

# prompt
function _set_k8s_prompt {
  if _kubeconfig_is_modified; then
    if context="$(kubectl config current-context 2>/dev/null)"; then
      ns="$(kubectl config view -o "jsonpath={.contexts[?(@.name==\"$context\")].context.namespace}")"
      [[ -z "$ns" ]] && ns="default"

      __K8S_PROMPT="(${context}/${ns})"
    else
      __K8S_PROMPT=""
    fi
  fi
}
