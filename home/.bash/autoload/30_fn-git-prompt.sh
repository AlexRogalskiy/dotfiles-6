#! /usr/bin/env bash

color_reset="\[\e[0;0m\]"

color_main="\[\e[0;34m\]"
color_symbol="\[\e[2;32m\]"
color_accent="\[\e[0;33m\]"

color_path="\[\e[0;32m\]"
color_prompt="\[\e[0;31m\]"

function git-prompt() {
    content="${color_path}${PWD/#${HOME}/~}${color_reset}"

    if test -d "${PWD}/.git"; then
        gitroot="${PWD}"
    elif [[ ${PWD} == ${PROMPT_GIT_ROOT}* ]]; then
        gitroot="${PROMPT_GIT_ROOT}"
    else
        gitroot=$(git rev-parse --show-toplevel 2>/dev/null || true)
    fi

    if test -n "${gitroot}"; then
        # only recalculate repo if git root has changed
        if [ "${PROMPT_GIT_ROOT:-}" != "${gitroot}" ]; then
            gitparent="$(basename $(dirname ${gitroot}))"
            gitrepo="${gitparent}/$(basename "${gitroot}")"

            PROMPT_GIT_REPO="${gitparent}/$(basename "${gitroot}")"
        fi
        PROMPT_GIT_ROOT="${gitroot}"

        # only recalculate rest of path if dir has changed
        if [ "${PROMPT_GIT_PWD:-}" != "${PWD}" ]; then
            gitparent="$(basename $(dirname ${gitroot}))"
            gitrepo="${gitparent}/$(basename "${gitroot}")"

            PROMPT_GIT_PATH="${PROMPT_GIT_REPO}${PWD/${PROMPT_GIT_ROOT}/}"
        fi
        PROMPT_GIT_PWD="${PWD}"


        # only get branch if it isnt set or if marker is newer than .git/HEAD
        githead="${PROMPT_GIT_ROOT}/.git/HEAD"
        marker="${HOME}/.prompt-git-branch"
        if [ -z "${PROMPT_GIT_BRANCH:-}" ] || [ "${githead}" -nt "${marker}" ]; then
            PROMPT_GIT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
            touch "${marker}"
        fi

        content="${color_symbol}git[${PROMPT_GIT_BRANCH}] ${color_path}${PROMPT_GIT_PATH}${color_reset}"
    fi

    PS1="${color_main}\u${color_symbol}@${color_main}\h:${content} ${color_prompt}\$ ${color_reset}"
    iterm-update-status
}
