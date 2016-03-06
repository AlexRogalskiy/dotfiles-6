#! /usr/bin/env bash
set -e

pushd "$(dirname "${BASH_SOURCE}")/../src" >/dev/null

echo ">> Distribution is $DISTRO."

[ -d common ] && {
    pushd common >/dev/null
    stows=($(ls -d */))
    echo ">> Stowing ${stows[@]}."
    for dir in "${stows[@]}"; do stow --adopt -t ~ "$dir"; done;
    popd &>/dev/null
}

[ -d $DISTRO ] && {
    echo ">> Stowing $DISTRO/."
    for dir in "$DISTRO/"; do stow --adopt -t ~ "$dir"; done;
}

popd &>/dev/null

echo ">> Installing from gem."
sudo gem install mdl

echo ">> Installing from npm."
sudo npm install -g js-yaml jsonlint recess

echo ">> Installing from pip."
sudo pip install neovim
sudo pip3 install neovim

command -v gsettings > /dev/null && uname | grep Linux && {
    # pantheon terminal
    gsettings set org.pantheon.terminal.settings tab-bar-behavior 'Hide When Single Tab' || true
    gsettings set org.pantheon.terminal.settings font 'Inconsolata 18' || true
    gsettings set org.pantheon.terminal.settings foreground '#878787' || true
    gsettings set org.pantheon.terminal.settings background '#202020' || true
    gsettings set org.pantheon.terminal.settings palette '#151515:#AC4142:#7E8D50:#E5B567:#6C99BB:#9E4E85:#7DD5CF:#D0D0D0:#505050:#AC4142:#7E8D50:#E5B567:#6C99BB:#9E4E85:#7DD5CF:#F5F5F5' || true

    # elementaryos settings
    gsettings set org.gnome.settings-daemon.peripherals.keyboard repeat-interval 15 || true
    gsettings set org.gnome.settings-daemon.peripherals.touchpad natural-scroll true || true

    # gnome desktop
    gsettings set org.gnome.desktop.wm.preferences visual-bell true || true
    gsettings set org.gnome.desktop.wm.preferences audible-bell true || true
    
    gsettings set org.gnome.desktop.interface clock-format 12h || true

    gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 15 || true
    gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true || true
    gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true || true
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true || true

    # gnome terminal
    gsettings set org.gnome.terminal.legacy confirm-close false || true
    gsettings set org.gnome.terminal.legacy default-show-menubar false || true
}

[ -n "$GOPATH" ] && export GOPATH=$HOME/go
command -v vim > /dev/null && {
    echo ">> Installing vim plugins."
    vim !silent +PlugInstall +qall
}
command -v nvim > /dev/null &&  {
    echo ">> Installing neovim plugins."
    nvim !silent +PlugInstall +qall
}

echo ">> Pulling SSH pubkeys from github."
curl -s https://github.com/roboll.keys > ~/.ssh/authorized_keys
