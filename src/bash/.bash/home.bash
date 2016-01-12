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

alias vi=nvim
alias vim=nvim
