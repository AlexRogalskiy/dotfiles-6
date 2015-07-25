#! /usr/bin/env bash


install_git() {
  echo "installing git"
  case $(uname) in
    Darwin ) xcode-select --install    ;;
    Linux  )
        if [ command -v apt-get >/dev/null 2>&1 ]; then
            apt-get install -y git
        elif [ command -v yum >/dev/null 2>&1 ]; then
            yum install git
        else
            echo "couldn't install git :("
            return 1
        fi
    ;;
  esac
}

# ensure git is installed
command -v git >/dev/null 2>&1 || { install_git; }

# clone or pull
echo "getting dotfiles..."
if [ ! -d ~/.dotfiles ]; then
  git clone --recursive --quiet https://github.com/roboll/dotfiles ~/.dotfiles
else
  pushd ~/.dotfiles >/dev/null
  git pull
  popd >/dev/null
fi

exec ~/.dotfiles/install.sh
