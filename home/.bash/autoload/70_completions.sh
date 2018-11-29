#!/usr/bin/env bash

# ssh scp sftp
if [ -e "$HOME/.ssh/config" ]; then
    complete -o "default" -o "nospace" \
        -W "$(grep "^Host" ~/.ssh/config | \
        grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" ssh scp sftp
fi

# notes
complete -o "default" -o "nospace" -W "$(notes complete)" notes
