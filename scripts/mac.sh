#! /usr/bin/env bash
set -euo pipefail

setup() {
    command -v brew >/dev/null 2>&1 || {
        log_info "Installing homebrew."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
    sudo dscl . -create /Users/roboll UserShell /bin/bash
    sudo dscl . -create /Users/roboll RealName "rob boll"
    sudo dscl . -create /Users/roboll PrimaryGroupID 80
    sudo dscl . -create /Users/roboll NFSHomeDirectory /Users/roboll

    sudo dscl . -append /Groups/staff GroupMembership roboll
    sudo dscl . -append /Groups/admin GroupMembership roboll
    sudo dscl . -append /Groups/wheel GroupMembership roboll

    log_info "Updating for boxname $BOXNAME."
    sudo scutil --set ComputerName "$BOXNAME"
    sudo scutil --set HostName "$BOXNAME"
    sudo scutil --set LocalHostName "$BOXNAME"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$BOXNAME"

    log_info "Setting macOS defaults."
    scripts/mac-defaults.sh

    cat <<EOF
=================================================

1. sync
  a. sign in to dropbox
  b. sync 1password
2. usability tweaks
  a. remap keys in sys prefs -> keyboard: caps lock to option
  b. accessibility: three finger trackpad drag
3. aws-vault configuration from notes
4. install/run applications
  a. little snitch
  b. micro snitch
  c. caffine
5. keys - ssh, pgp

=================================================
EOF
}
