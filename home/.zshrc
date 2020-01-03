#!/usr/bin/env zsh

# source includes
if [ -d "${HOME}/.zsh" ]; then
  for file in ${HOME}/.zsh/*.zsh; do
    source "${file}"
  done
fi

# allow bash style comments on cli
setopt interactivecomments

# always use nvim
alias vi="nvim"
alias vim="nvim"

# allow interpolation in prompt
setopt prompt_subst

# shell prompt
__prompt_newline=$'\n'
export PROMPT='%(?..%F{red}[exit code: %?]${__prompt_newline}%f)%F{blue}%B%3~%b%F{white} %(!.#.$) %f'
export RPROMPT='${__K8S_PROMPT}'

function precmd {
  _set_k8s_prompt

  return 0
}
