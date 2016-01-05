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
    Darwin ) ./mac/install.sh; sudo -u roboll ./init.sh; cat ./mac/postinst.txt; ;;
    Linux  ) [ -z "$(uname -a | grep nixos)" ] || exit 1; ./nix/install.sh; sudo -u roboll ./init.sh; ;;
    *      ) echo "!! Couldn't recognize os." && exit 1 ;;
esac

popd >/dev/null

echo ""
echo "!!"
echo "!! Install complete, restart now."
echo "!!"
