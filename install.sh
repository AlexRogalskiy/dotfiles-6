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

echo ""
# print out notes
cat ~/.dotfiles/postinst.txt
echo ""

# setup the session
source ~/.bash_profile
