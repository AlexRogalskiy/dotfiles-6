#! /usr/bin/env bash

set -eo pipefail

confirm_var() {
    name=${1}
    value=$(printenv ${1})
    read -p "?? Using $name=$value. Continue? "
}

log_info() {
    echo ">> $1"
}

log_err() {
    echo "!! $1" >&2
    exit 1
}

require_git() {
    command -v git >/dev/null 2>&1 || {
        case $(uname) in
            Darwin ) xcode-select --install ;;
            Linux  )
                if command -v apt-get > /dev/null; then
                    sudo apt-get install -y git
                fi
                ;;
            *      ) echo "!! git is required" && exit 1 ;;
        esac
    }
}

install_dotfiles() {
    target=${1}
    remote=${2}
    if [ ! -d $target ]; then
        git clone --recursive --quiet --depth 1 $remote $target
    else
        pushd $target >/dev/null
        current=$(git remote show origin)
        if [ ! $current ~== $remote ]; then
            log_err "$target has wrong git remote: $current (expected $remote)"
        fi
        git pull
        popd >/dev/null
    fi
}

export INSTALL_DIR=${INSTALL_DIR:=~/.dotfiles}
confirm_var "INSTALL_DIR"

export DOTFILES=${DOTFILES:=https://github.com/roboll/dotfiles}
confirm_var "DOTFILES"

require_git

log_info "Getting dotfiles from $DOTFILES."
install_dotfiles $INSTALL_DIR $DOTFILES

exec $INSTALL_DIR/install.sh
