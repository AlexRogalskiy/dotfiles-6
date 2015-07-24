#!/bin/bash
set -e

pushd "$(dirname "${BASH_SOURCE}")" >/dev/null

# choose what to install based on os/dist
case $(uname) in
    darwin ) ./scripts/osx-install.sh    ;;
    linux  )
        if [ command -v apt-get >/dev/null 2>&1 ]; then
            ./scripts/debian-install.sh
        elif [ command -v yum >/dev/null 2>&1 ]; then
            ./scripts/fedora-install.sh
        else
            echo "couldn't recognize os :("
        fi
    ;;
esac

# setup shared components
echo "installing cross platform components"
./scripts/common-install.sh

echo ""
cat ./scripts/postinst.txt
echo ""

popd >/dev/null

# setup the session
source ~/.bash_profile
