#! /usr/bin/env bash
set -e

[ -z "$BOXNAME" ] && {
  [ -f "$HOME/.boxname" ] || {
    echo ">> Computer name (~/.boxname) not found."
    read -p "Computer name: " name
    echo "$name" > "$HOME/.boxname"
  }

  export BOXNAME=$(cat "$HOME/.boxname")
}

pushd "$(dirname "${BASH_SOURCE}")" >/dev/null

[ "$(id -u)" -ne 0 ] && {
    echo "!! Requires root, elevating with sudo."
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

case $(uname) in
    Darwin ) ./osx/install.sh; sudo -u roboll DISTRO=osx ./configure.sh; cat ./osx/postinst.txt; ;;
    Linux  )
        if command -v pacman > /dev/null; then
            sudo ./arch/install.sh; sudo -u roboll DISTRO=arch ./configure.sh;
        fi ;;
    *      ) echo "!! Couldn't recognize os." && exit 1 ;;
esac

popd >/dev/null

echo ""
echo "!!"
echo "!! Install complete, restart now."
echo "!!"
