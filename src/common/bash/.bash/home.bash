#! /bin/bash

###############################################################################
# home.bash - home computer only
###############################################################################
if [ ! "$(cat "$HOME/.boxname" 2>&1)" == "nomad" ]; then
    return
fi

export GOPATH=~/dev/go

for key in $HOME/.ssh/*_rsa*.pub; do
    ssh-add "$HOME/.ssh/$key" &>/dev/null
done;

function vnc() {
    open vnc://\$@
}

function cleandocker() {
    for i in $(docker ps -a -q); do docker rm -f $i; done;
    for i in $(docker images -q); do docker rmi -f $i; done;
}

function http() {
    local port="${1:-8000}"
    sleep 1 && open "http://localhost:${port}/" &
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

function tmx() {
    # Make sure we are not already in a tmux session
    if [[ -z "$TMUX" ]]; then
        base_session="uber"
        tmux has -t "$base_session" || tmux -2 new-session -s "$base_session"
        tmux attach-session -t "$base_session"
        builtin exit
    else
        echo "You're already in a tmux session"
    fi
}

function exit() {
    # if in tmux session, detach, don't exit
    [ -z "$TMUX" ] || {
        tmux detach
    }
}

[ -n "$TMUX" ] || tmx
