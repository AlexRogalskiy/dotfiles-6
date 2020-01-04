#!/usr/bin/env zsh

function _set_git_prompt {
  if git_branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"; then
    __GIT_PROMPT=" %F{yellow}(${git_branch})%f"
  else
    __GIT_PROMPT=""
  fi
}
