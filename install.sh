#!/bin/bash
set -e

pushd "$(dirname "${BASH_SOURCE}")"

# choose what to install based on os/dist
case `uname` in 
  "Darwin") # osx
    osx/install.sh
    ;;
  "Linux")
    if [ -f /etc/debian_version ]; then
      echo "installing debian components"
      debian/install.sh
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
shared/install.sh

popd > /dev/null

# setup the session
echo "loading shell profile"
echo "really..."
source ~/.bash_profile
echo "sourced it"
