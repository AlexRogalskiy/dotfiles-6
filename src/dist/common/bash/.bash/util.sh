#! /usr/bin/env bash

# enable sudo'ing aliases
alias sudo='sudo '
alias reload="exec \$SHELL -l"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias l="ls -lF ${colorflag}"
alias la="ls -laF ${colorflag}"
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

alias ls="command ls ${colorflag}"

alias localip="ipconfig getifaddr en0"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias myips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

function extract() {
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz) tar xzf "$1" ;;
      *.bz2) bunzip2 "$1" ;;
      *.rar) rar x "$1" ;;
      *.gz) gunzip "$1" ;;
      *.tar) tar xf "$1" ;;
      *.tbz2) tar xjf "$1" ;;
      *.tgz) tar xzf "$1" ;;
      *.zip) unzip "$1" ;;
      *.Z) uncompress "$1" ;;
      *.7z) 7z x "$1" ;;
      *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# rm docker images and containers
function docker-clean() {
    for ctr in $(docker ps -a -q); do docker rm -f $ctr; done;
    for img in $(docker images -q); do docker rmi -f $img; done;
}

# title for terminal tabs
function title {
    echo -ne "\033]0;"$*"\007"
}

# http server for pwd
function http() {
    local port="${1:-8000}"
    sleep 1 && open "http://localhost:${port}/" &
    python <<EOF
import SimpleHTTPServer
map = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map
map[""] = "text/plain"
for key, value in map.items():
    map[key] = value + ";charset=UTF-8";
SimpleHTTPServer.test();
EOF
}
