#!/usr/bin/env bash

function notes() {
    note="$@"
    test -z "${note}" && note="default"

    "$EDITOR" "${NOTES_DIR}/${note}.md"
}

function _notes_completion() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="$(find $HOME/Dropbox/Notes.d/*.md | sed -e "s,$HOME/Dropbox/Notes.d/,,g" -e 's,\.md,,g')"

    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
    return 0
}

complete -F _notes_completion notes
