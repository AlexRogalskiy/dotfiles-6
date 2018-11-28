#! /usr/bin/env bash

color_reset="\[\e[0;0m\]"

color_main="\[\e[0;34m\]"
color_symbol="\[\e[2;32m\]"
color_accent="\[\e[0;33m\]"

color_path="\[\e[0;32m\]"
color_prompt="\[\e[0;31m\]"

function set-prompt() {
    content="${color_path}${PWD/#${HOME}/~}${color_reset}"

    # if git directory
    if git rev-parse 2>/dev/null; then
        # only recalculate path if dir has changed
        if [ "${PROMPT_LAST_DIR:-}" != "${PWD}" ]; then
            gitroot="$(git rev-parse --show-toplevel)"
            gitparent="$(basename $(dirname ${gitroot}))"
            PROMPT_PATH="${gitparent}/$(basename "${gitroot}")${PWD/$gitroot/}"
        fi
        PROMPT_GIT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
        content="${color_symbol}git[${PROMPT_GIT_BRANCH}] ${color_path}${PROMPT_PATH}${color_reset}"
    fi

    PROMPT_LAST_DIR="${PWD}"

    PS1="${color_main}\u${color_symbol}@${color_main}\h:${content} ${color_prompt}\$ ${color_reset}"
    iterm-update-status
}

PROMPT_COMMAND='set-prompt'
