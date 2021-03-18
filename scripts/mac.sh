#!/usr/bin/env bash
set -euo pipefail

setup() {
    command -v brew >/dev/null 2>&1 || {
        log_info "Installing homebrew."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    }

    brew tap homebrew/bundle
    brew bundle --file=Brewfile
    brew cleanup
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

    log_info "Setting macOS defaults."
    # scripts/mac-defaults.sh

    cat <<EOF
=================================================

1. usability tweaks
  a. remap keys in sys prefs -> keyboard: caps lock to option
  b. accessibility: three finger trackpad drag
2. install/run applications
  a. 1Password
  b. Caffine
  c. Little Snitch

=================================================
EOF
}
