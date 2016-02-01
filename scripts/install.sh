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
    Darwin ) ./osx/install.sh; sudo -u roboll DISTRO=osx ./init.sh; cat ./osx/postinst.txt; ;;
    Linux  )
        if command -v apt-get > /dev/null; then
            lsb_release -is | grep -q elementary || (echo "Unknown apt-based distro." && exit 1)
            sudo ./elementary/install.sh; sudo -u roboll DISTRO=elementary ./init.sh;
            cat ./elementary/postinst.txt;
        fi ;;
    *      ) echo "!! Couldn't recognize os." && exit 1 ;;
esac

popd >/dev/null

echo ""
echo "!!"
echo "!! Install complete, restart now."
echo "!!"
