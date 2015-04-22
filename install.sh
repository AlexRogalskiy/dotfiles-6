#!/bin/bash
set -e

pushd "$(dirname "${BASH_SOURCE}")" >/dev/null

# choose what to install based on os/dist
case `uname` in 
  "Darwin") # osx
    ./_scripts/osx-install.sh
    ;;
  "Linux")
    if [ -f /etc/debian_version ]; then
      echo "installing debian components"
      ./_scripts/debian-install.sh
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
./_scripts/shared-install.sh

echo ""
cat ./_scripts/postinst.txt
echo ""

popd >/dev/null

# setup the session
source ~/.bash_profile
