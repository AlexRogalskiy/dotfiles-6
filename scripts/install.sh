#!/bin/bash
set -e

pushd "$(dirname "${BASH_SOURCE}")" >/dev/null

# choose what to install based on os/dist
case `uname` in 
  "Darwin") # osx
    ./osx-install.sh
    ;;
  "Linux")
    if [ -f /etc/debian_version ]; then
      echo "installing debian components"
      ./debian-install.sh
    else
      echo "no os-specific components"
    fi
    ;;
  *)
    echo "no os-specific components"
    ;;
esac

# setup shared components
echo "installing cross platform components"
./shared-install.sh

echo ""
cat ./postinst.txt
echo ""

popd >/dev/null

# setup the session
source ~/.bash_profile
