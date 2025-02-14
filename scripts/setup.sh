#! /usr/bin/env bash
set -euo pipefail

log_info() {
    echo ">> $1"
}

log_err() {
    echo "!! $1" >&2
    exit 1
}

# install git if missing
command -v git >/dev/null 2>&1 || xcode-select --install

# install dotfiles repository
DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_REMOTE="https://github.com/roboll/dotfiles"
log_info "Installing $DOTFILES_REMOTE into $DOTFILES_DIR."

if [ ! -d $DOTFILES_DIR ]; then
    git clone --recursive --quiet --depth 1 "$DOTFILES_REMOTE" "$DOTFILES_DIR"
else
    pushd $DOTFILES_DIR >/dev/null
    current=$(git config --get remote.origin.url)
    if [ "$current" != "$DOTFILES_REMOTE" ]; then
        log_err "$DOTFILES_DIR has wrong git DOTFILES_REMOTE: $current (expected $DOTFILES_REMOTE)"
    fi
    git pull
    popd >/dev/null
fi

# exec installer
exec $DOTFILES_DIR/scripts/_install.sh
