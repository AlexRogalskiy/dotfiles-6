#! /bin/bash

for key in $HOME/.ssh/*_rsa*.pub; do
    ssh-add "$HOME/.ssh/$key" &>/dev/null
done;

export EDITOR=nvim
export PAGER="nvim -MR -c 'nnoremap q :q!<CR>' -"

export GOPATH=~/dev

alias notes="vi ~/Dropbox/Notes"

function man() {
    nvim -c "let g:no_man_maps=1" -c "let g:man=1" -c "nnoremap q :qall!<CR>" -c "Man $@" -c "bdel 1"
}

function vnc() {
    open vnc://\$@
}

function docker-clean() {
    for i in $(docker ps -a -q); do docker rm -f $i; done;
    for i in $(docker images -q); do docker rmi -f $i; done;
}

function http() {
    local port="${1:-8000}"
    sleep 1 && open "http://localhost:${port}/" &
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}