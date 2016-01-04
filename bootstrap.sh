#! /bin/bash

set -e

command -v git >/dev/null 2>&1 || {
    case $(uname) in
        Darwin ) xcode-select --install ;;
        *      ) echo "!! Install git & try again." && exit 1 ;;
    esac
}

echo ">> Getting dotfiles."
if [ ! -d ~/.dotfiles ]; then
    git clone --recursive --quiet --depth 1 https://github.com/roboll/dotfiles ~/.dotfiles
else
    pushd ~/.dotfiles >/dev/null && git pull && popd >/dev/null
fi

exec ~/.dotfiles/scripts/install.sh
