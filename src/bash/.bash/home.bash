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
        # ensure there is an uber session
        tmux has -t "$base_session" || tmux new-session -s "$base_session"

        # Kill defunct sessions first
        old_sessions=$(tmux ls 2>/dev/null | egrep "^[0-9]{14}.*[0-9]+\)$" | cut -f 1 -d:)
        for old_session_id in $old_sessions; do
            echo "killing derelict session $old_session_id"
            tmux kill-session -t "$old_session_id"
        done

        # Session is is date and time to prevent conflict
        session_id=$(date +%Y%m%d%H%M%S)

        echo "Launching copy of base session $base_session, named $session_id ..."

        # Create a new session (without attaching it) and link to base session to share windows
        tmux new-session -d -t "$base_session" -s "$session_id"

        # Attach to the new session
        tmux attach-session -t "$session_id"

        # When we detach from it, kill the session
        tmux kill-session -t "$session_id"

        echo "session $session_id killed"
    else
        echo "You're already in a tmux session"
    fi
}

[ -n "$TMUX" ] || tmx
