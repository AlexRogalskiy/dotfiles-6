#! /bin/bash

###############################################################################
# linux.bash - exits if not on linux
###############################################################################

if [ ! "$(uname)" == "Linux" ]; then
    return
fi

setxkbmap -option ctrl:nocaps
xmodmap -e "keycode 66 = F9"
