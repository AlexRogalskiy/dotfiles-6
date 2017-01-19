#! /usr/bin/env bash

set -eo pipefail

log_info() {
    echo ">> $1"
}

log_err() {
    echo "!! $1" >&2
    exit 1
}

confirm_var() {
    name=${1}
    value=$(printenv "${1}")
    message="Using $name=$value."

    if [ -v SKIP_CONFIRM ]; then
        log_info "$message"
    else
        read -rp "?? $message Continue? "
    fi
}

USER=${USER:=roboll}
confirm_var "USER"

export BOXNAME=${BOXNAME:=$(hostname -s)}
confirm_var "BOXNAME"
echo "$BOXNAME" > ~/.boxname

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
pushd "$SCRIPT_DIR" >/dev/null
trap "popd>/dev/null" EXIT

case $(uname) in
    Darwin ) export DISTRO=mac ;;
    Linux  ) if command -v pacman >/dev/null;    then export DISTRO=arch;
             elif command -v apt-get >/dev/null; then export DISTRO=debian;
             else log_err "Couldn't recognize Linux distro."; fi ;;
    *      ) log_err "Couldn't recognize OS." ;;
esac
confirm_var "DISTRO"

if [ "$(id -u)" -ne 0 ]; then
    echo "!! Requires root, elevating with sudo."
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

source "./src/dist/common.sh"
if [ -f "./src/dist/${DISTRO}.sh" ]; then
    source "./src/dist/$DISTRO.sh"
else
    log_err "No script for DISTRO=${DISTRO}."
fi

pushd "src/dist/$DISTRO" >/dev/null
setup
popd >/dev/null

pushd "src/dist" >/dev/null
install_dotfiles
popd >/dev/null

pushd "src/dist/$DISTRO" >/dev/null
configure
popd >/dev/null

log_info "Pulling SSH pubkeys from Github."
curl -s https://github.com/roboll.keys > ~/.ssh/authorized_keys

log_info "Install complete!"
