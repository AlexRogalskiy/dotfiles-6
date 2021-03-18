#! /usr/bin/env bash
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

# install homebrew if missing
command -v brew >/dev/null 2>&1 || {
    log_info "Installing homebrew."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# configure computer name
export COMPUTER_NAME=${COMPUTER_NAME:=$(hostname -s)}
confirm_var "COMPUTER_NAME"

log_info "Configuring computer with name $COMPUTER_NAME."
sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$COMPUTER_NAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"

# configuring user account
log_info "Configuring user account $USER."
sudo dscl . -create /Users/roboll UserShell /bin/zsh
sudo dscl . -create /Users/roboll RealName "roboll"
sudo dscl . -create /Users/roboll PrimaryGroupID 80
sudo dscl . -create /Users/roboll NFSHomeDirectory /Users/roboll

sudo dscl . -append /Groups/staff GroupMembership roboll
sudo dscl . -append /Groups/admin GroupMembership roboll
sudo dscl . -append /Groups/wheel GroupMembership roboll

log_info "Pulling SSH pubkeys from Github."
mkdir -p ~/.ssh
curl -s https://github.com/roboll.keys > ~/.ssh/authorized_keys

# install apps with homebrew
BREWFILE=$PWD/Brewfile
log_info "Installing apps from $BREWFILE."
brew bundle --file=$BREWFILE
brew cleanup

# link dotfiles to home dir
log_info "Configuring home directory."
stow -t "$HOME" home

# configure iterm2
log_info "Linking iTerm2 setings."
ln -sf "$HOME/.macos/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/"

# configure neovim
log_info "Configuring neovim."
export GOPATH=$HOME/dev
command -v nvim >/dev/null && {
    log_info "Installing neovim plugins."
    nvim !silent +PlugInstall +qall
}

log_info "Install complete!"
