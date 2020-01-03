#!/usr/bin/env zsh

# allow bash style comments on cli
setopt interactivecomments

# case insensitive match
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# allow interpolation in prompt
setopt prompt_subst

# shell prompt
__prompt_newline=$'\n'
export PROMPT="%(?..%F{red}[exit code: %?]${__prompt_newline}%f)%F{blue}%B%3~%b%F{white} %(!.#.$) %f"
export RPROMPT='${__K8S_PROMPT}'

# utility functions
function extract {
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz) tar xzf "$1" ;;
      *.bz2) bunzip2 "$1" ;;
      *.rar) rar x "$1" ;;
      *.gz) gunzip "$1" ;;
      *.tar) tar xf "$1" ;;
      *.tbz2) tar xjf "$1" ;;
      *.tgz) tar xzf "$1" ;;
      *.zip) unzip "$1" ;;
      *.Z) uncompress "$1" ;;
      *.7z) 7z x "$1" ;;
      *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function is_kubeconfig_modified {
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

function precmd {
  if is_kubeconfig_modified; then
    context="$(kubectl config current-context 2>/dev/null)"
    ns="$(kubectl config view -o "jsonpath={.contexts[?(@.name==\"$context\")].context.namespace}")"
    [[ -z "$ns" ]] && ns="default"

    __K8S_PROMPT="(${context}/${ns})"
  fi
  return 0
}

# always use nvim
alias vi="nvim"
alias vim="nvim"

# k8s shortcuts
alias k="kubectl"
alias kpo="kubectl get pods"
alias kno="kubectl get nodes"

function kc {
  kubectl config use-context ${@}
}

function _kc {
  local k8s_clusters

  zstyle -s ':kc-completion:' k8s_contexts k8s_contexts

  if [[ -z "$k8s_contexts" ]] || is_kubeconfig_modified; then
    k8s_contexts=$(kubectl config get-contexts -oname)
    zstyle ':kc-completion' k8s_contexts k8s_contexts
  fi

  _arguments -C "1: :($k8s_contexts)"
}

compdef _kc kc

function kns {
  kubectl config set-context --current --namespace=${@}
}

function _kns {
  local namespaces=$(kubectl get ns -o custom-columns=":metadata.name" --no-headers)
  _arguments -C "1: :(${namespaces})"
}

compdef _kns kns
