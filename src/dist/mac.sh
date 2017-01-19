#! /usr/bin/env bash

set -eo pipefail

setup() {
    command -v brew >/dev/null 2>&1 || {
        log_info "Installing homebrew."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    }

    brew tap homebrew/bundle
    brew bundle --file=./Brewfile
    brew cleanup

    for i in /Library/Java/JavaVirtualMachines/*; do
        sudo mkdir -p "$i/Contents/Home/jdk_source"
        sudo chmod g+w "$i/Contents/Home/jdk_source"
        sudo unzip -quo "$i/Contents/Home/src.zip" -d "$i/Contents/Home/jdk_source"
    done
}

configure() {
    log_info "Linking iTerm2 setings."
    ln -sf ~/.iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/

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
    ./defaults.sh

    cat <<EOF
=================================================

1. sync
  a. sign in to dropbox
  b. sync 1password
2. remap keys in sys prefs -> keyboard
  a. caps lock to option
3. keys - ssh, pgp

=================================================
EOF
}
