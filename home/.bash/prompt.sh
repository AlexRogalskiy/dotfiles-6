#! /usr/bin/env bash

color_reset="\[\e[0;0m\]"
color_main="\[\e[0;34m\]"

color_symbol="\[\e[2;32m\]"
color_accent="\[\e[1;31m\]"
color_dark="\[\e[1;30m\]"

color_path="\[\e[0;32m\]"
color_prompt="\[\e[0;31m\]"
color_type="\[\e[2;38m\]"

git_prompt_prefix="${color_type}git${color_reset}"

git_prompt() {
  workdir="$(pwd)"

  # check if in git repo
  if git rev-parse 2>/dev/null; then
    # in git
    gitroot="$(git rev-parse --show-toplevel)"
    gitowner="$(pushd $gitroot/.. > /dev/null && echo `basename $(pwd)` && popd > /dev/null)"
    gitbase="${color_path}${gitowner}/$(basename "$gitroot")${color_reset}"
    gitbranch="${color_symbol}[$(git rev-parse --abbrev-ref HEAD)]${color_reset}"
    # detect if in a symlink
    if [[ $workdir != $gitroot*  ]]; then
      printf "%s %s%s %s"  "$git_prompt_prefix" "${workdir/$HOME/~}" "$gitbranch" "$color_dark[-> ${gitroot/$HOME/~}]$color_reset"
    else
      printf "%s%s %s" "$git_prompt_prefix" "$gitbranch" "$gitbase${workdir/$gitroot/}"
    fi
  else
    # not in git
    printf "%s" "${workdir/$HOME/~}"
  fi
}

set_bash_prompt() {
  new_line=""
  COLS=$(tput cols)
  NOCOLOR_PROMPT_STRING="\u@$HOST_COLOR\h:$(git_prompt) \$"

  if [[ $COLS -lt ${#NOCOLOR_PROMPT_STRING} ]]; then
    new_line="\n"
  fi

  extra=""
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    extra="$color_accent[ssh] $color_reset"
  fi
  PS1="$extra$color_main\u$color_symbol@${PROMPT_HOST_COLOR:-$color_main}\h$color_main:$color_path$(git_prompt)$color_prompt $new_line\$ $color_reset"
}

NOCOLOR_PROMPT_STRING=COLOR_PROMPT_STRING=

PROMPT_COMMAND='set_bash_prompt'
