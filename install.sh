#!/usr/bin/env bash
set -euo pipefail

log_info() {
    echo ">> $1"
}

log_err() {
    echo "!! $1" >&2
    exit 1
}

confirm_var() {
    name=${1}
    value=$(printenv "${1}" || true)
    message="Using $name=$value."

    read -rp "?? $message Continue? "
}

USER=${USER:=roboll}
confirm_var "USER"

export BOXNAME=${BOXNAME:=$(hostname -s)}
confirm_var "BOXNAME"
echo "$BOXNAME" > ~/.boxname

# keep sudo until exit
if [ "$(id -u)" -ne 0 ]; then
    echo "!! Requires root, elevating with sudo."
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

# pushd into repo directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
pushd "$SCRIPT_DIR" >/dev/null
trap "popd>/dev/null" EXIT

source "./scripts/common.sh"
source "./scripts/mac.sh"

setup
install
configure

log_info "Pulling SSH pubkeys from Github."
curl -s https://github.com/roboll.keys > ~/.ssh/authorized_keys

log_info "Install complete!"
