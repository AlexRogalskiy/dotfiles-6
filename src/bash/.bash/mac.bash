#! /bin/bash

###############################################################################
# mac.bash - exits if not on mac
###############################################################################

if [ ! "$(uname)" == "Darwin" ]; then
    return
fi

# homebrew autocomplete
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
	source "$(brew --prefix)/etc/bash_completion"
fi

# empty trash and clear system logs
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# set iterm profiles
iprof() {
  echo -e "\033]50;SetProfile=$1\a"
  export ITERM_PROFILE=$1
}

alias dark="iprof dark"
alias light="iprof light"
alias blue="iprof blue"

export PATH=$HOME/dev/go/bin:$PATH
