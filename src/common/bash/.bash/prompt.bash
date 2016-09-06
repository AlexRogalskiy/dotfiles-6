#! /bin/bash

color_reset="\[\e[0;0m\]"
color_main="\[\e[0;34m\]"

color_symbol="\[\e[0;32m\]"
color_accent="\[\e[1;31m\]"
color_dark="\[\e[1;30m\]"

color_path="\[\e[0;32m\]"
color_prompt="\[\e[0;31m\]"

git_prompt_prefix="${color_accent}git${color_path}"

git_prompt() {
  workdir="$(pwd)"

  # check if in git repo
  if git rev-parse 2>/dev/null; then
    # in git
    gitroot="$(git rev-parse --show-toplevel)"
    gitowner="$(pushd $gitroot/.. > /dev/null && echo `basename $(pwd)` && popd > /dev/null)"
    gitbase="$gitowner/$(basename "$gitroot")"
    # detect if in a symlink
    if [[ $workdir != $gitroot*  ]]; then
      printf "%s %s %s"  "$git_prompt_prefix" "${workdir/$HOME/~}" "$color_dark[-> ${gitroot/$HOME/~}]$color_reset"
    else
      printf "%s %s"  "$git_prompt_prefix" "$gitbase${workdir/$gitroot/}"
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
    extra="$color_accent[ remote ] $color_reset"
  fi
  PS1="$extra$color_main\u$color_symbol@$color_main\h:$color_path$(git_prompt)$color_prompt $new_line\$ $color_reset"
}

NOCOLOR_PROMPT_STRING=COLOR_PROMPT_STRING=

PROMPT_COMMAND='set_bash_prompt'
