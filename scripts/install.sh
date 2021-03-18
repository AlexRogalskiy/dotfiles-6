#!/usr/bin/env bash
set -euo pipefail

log_info() {
    echo ">> $1"
}

log_err() {
    echo "!! $1" >&2
    exit 1
}

confirm_var() {
    name=${1}
    value=$(printenv "${1}")
    message="Using $name=$value."

    read -rp "?? $message Continue? "
}

setup() {
    command -v brew >/dev/null 2>&1 || {
        log_info "Installing homebrew."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    }

    brew bundle --file=Brewfile
    brew cleanup
}

install() {
    command -v gem >/dev/null && {
        log_info "Installing from gem."
        sudo gem install mdl
    }

    command -v npm >/dev/null && {
        log_info "Installing from npm."
        sudo npm install -g js-yaml jsonlint recess
    }

    command -v pip >/dev/null && {
        log_info "Installing from pip."
        sudo pip install neovim
    }
    command -v pip3 >/dev/null && {
        log_info "Installing from pip3."
        sudo pip3 install neovim
    }

    export GOPATH=$HOME/dev
    command -v nvim >/dev/null && {
        log_info "Installing neovim plugins."
        nvim !silent +PlugInstall +qall
    }
}

configure() {
    log_info "Linking iTerm2 setings."
    ln -sf "$HOME/.macos/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/"

    log_info "Linking neovim to 'vim'."
    ln -sf "/usr/local/bin/nvim" "/usr/local/bin/vim"

    log_info "Updating user $USER."
    sudo dscl . -create /Users/roboll UserShell /bin/zsh
    sudo dscl . -create /Users/roboll RealName "roboll"
    sudo dscl . -create /Users/roboll PrimaryGroupID 80
    sudo dscl . -create /Users/roboll NFSHomeDirectory /Users/roboll

    sudo dscl . -append /Groups/staff GroupMembership roboll
    sudo dscl . -append /Groups/admin GroupMembership roboll
    sudo dscl . -append /Groups/wheel GroupMembership roboll

    log_info "Updating for computer name $COMPUTER_NAME."
    sudo scutil --set ComputerName "$COMPUTER_NAME"
    sudo scutil --set HostName "$COMPUTER_NAME"
    sudo scutil --set LocalHostName "$COMPUTER_NAME"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"

    # log_info "Setting macOS defaults."
    # scripts/mac-defaults.sh

    cat <<EOF
=================================================

1. usability tweaks
  a. accessibility: three finger trackpad drag
2. install/run applications
  a. 1Password
  b. Caffeine
  c. Little Snitch

=================================================
EOF
}

USER=${USER:=roboll}
confirm_var "USER"

export COMPUTER_NAME=${COMPUTER_NAME:=$(hostname -s)}
confirm_var "COMPUTER_NAME"
echo "$COMPUTER_NAME" > ~/.computername

# keep sudo until exit
if [ "$(id -u)" -ne 0 ]; then
    echo "!! Requires root, elevating with sudo."
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

# install homebrew if missing
command -v brew >/dev/null 2>&1 || {
    log_info "Installing homebrew."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# install with homebrew
log_info "Installing from Brewfile."
brew bundle --file=Brewfile
brew cleanup

log_info "Configuring ~/."
stow -t "$HOME" home

#install
configure

log_info "Pulling SSH pubkeys from Github."
curl -s https://github.com/roboll.keys > ~/.ssh/authorized_keys

log_info "Install complete!"
