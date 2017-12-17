#! /usr/bin/env bash
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

case $(uname) in
    Darwin ) export DISTRO=mac ;;
    Linux  ) if command -v pacman >/dev/null;    then export DISTRO=arch;
             elif command -v apt-get >/dev/null; then export DISTRO=debian;
             else log_err "Couldn't recognize Linux distro."; fi ;;
    *      ) log_err "Couldn't recognize OS." ;;
esac
confirm_var "DISTRO"

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
if [ -f "./scripts/${DISTRO}.sh" ]; then
    source "./scripts/$DISTRO.sh"
else
    log_err "No script for DISTRO=${DISTRO}."
fi

setup
install
configure

log_info "Pulling SSH pubkeys from Github."
curl -s https://github.com/roboll.keys > ~/.ssh/authorized_keys

log_info "Install complete!"
