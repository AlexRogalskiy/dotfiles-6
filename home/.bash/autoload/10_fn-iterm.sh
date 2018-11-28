#!/usr/bin/env bash

function iterm-profile() {
    NAME="$1"; if [ -z "$NAME" ]; then NAME="default"; fi
    echo -ne "\033]50;SetProfile=$NAME\a"
}

function iterm-reset() {
    NAME="default"
    echo -ne "\033]50;SetProfile=$NAME\a"
}

function iterm-title {
    echo -ne "\033]0;"$*"\007"
}
