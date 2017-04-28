#! /bin/bash

setxkbmap -option ctrl:nocaps
xmodmap -e "keycode 66 = F9"
