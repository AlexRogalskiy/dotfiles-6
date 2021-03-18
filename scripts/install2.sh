#! /usr/bin/env bash
set -euo pipefail

log_info() {
    echo ">> $1"
}

log_err() {
    echo "!! $1" >&2
    exit 1
}

# install homebrew if missing
command -v brew >/dev/null 2>&1 || {
    log_info "Installing homebrew."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# install dotfiles repository
export DOTFILES_DIR="$HOME/.dotfiles"
export DOTFILES_REMOTE="https://github.com/roboll/dotfiles"
log_info "Installing $DOTFILES_REMOTE into $DOTFILES_DIR."

if [ ! -d $DOTFILES_DIR ]; then
    git clone --recursive --quiet --depth 1 "$DOTFILES_REMOTE" "$DOTFILES_DIR"
else
    pushd $DOTFILES_DIR >/dev/null
    current=$(git remote show origin)
    if [ "$current" != "$DOTFILES_REMOTE" ]; then
        log_err "$DOTFILES_DIR has wrong git DOTFILES_REMOTE: $current (expected $remote)"
    fi
    git pull
    popd >/dev/null
fi

#exec ~/.dotfiles/scripts/install.sh
