#!/usr/bin/env bash

# homebrew
if command -v brew >/dev/null; then
    file="/usr/local/etc/bash_completion"
    test -f "${file}" && test -r "${file}" && source "${file}"
fi

# ssh scp sftp
if [ -e "$HOME/.ssh/config" ]; then
    complete -o "default" -o "nospace" \
        -W "$(grep "^Host" ~/.ssh/config | \
        grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" ssh scp sftp
fi

# notes
complete -o "default" -o "nospace" -W "$(notes complete)" notes
