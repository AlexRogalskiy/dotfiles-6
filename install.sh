#!/bin/bash

cd "$(dirname "${BASH_SOURCE}")"

case `uname` in 
  "Darwin") 
    osx/setup.sh
    ;;
  "Linux")
    if [ -f /etc/debian_version ]; then
      debian/setup.sh
    else
      echo "only debian linux supported"
    fi
    ;;
  *)
    echo "os not supported"
    ;;
esac

shared/setup.sh

source ~/.bash_profile
