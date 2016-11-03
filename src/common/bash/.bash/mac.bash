#! /bin/bash

if [ ! "$(uname)" == "Darwin" ]; then return; fi

# title for iterm2 tabs
function title {
    echo -ne "\033]0;"$*"\007"
}

# homebrew autocomplete
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
	source "$(brew --prefix)/etc/bash_completion"
fi

# empty trash and clear system logs
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

export GOROOT=/usr/local/opt/go/libexec/
export PATH=$HOME/dev/go/bin:$PATH
