#! /bin/bash

export EDITOR=nvim
export PAGER="nvim -MR -c 'nnoremap q :q!<CR>' -"

export GOPATH=~/dev

export PROMPT_HOST_COLOR="\[\e[0;36m\]"

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  tmux -2 new -s $(hostname) -A
fi

function add-keys() {
    for key in $HOME/.ssh/*_rsa*.pub; do
        ssh-add "${key%.pub}"
    done;
}

function man() {
    nvim -c "let g:no_man_maps=1" -c "let g:man=1" -c "nnoremap q :qall!<CR>" -c "Man $@" -c "bdel 1"
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
