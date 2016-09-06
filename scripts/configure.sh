#! /usr/bin/env bash
set -e

pushd "$(dirname "${BASH_SOURCE}")/../src" >/dev/null

echo ">> Distribution is $DISTRO."

[ -d common ] && {
    pushd common >/dev/null
    stows=($(ls -d */))
    echo ">> Stowing ${stows[@]}."
    [ -f ~/.bashrc ] && rm -f ~/.bashrc
    [ -f ~/.bash_profile ] && rm -f ~/.bash_profile
    for dir in "${stows[@]}"; do stow -t ~ "$dir"; done;
    popd &>/dev/null
}

[ -d $DISTRO ] && {
    echo ">> Stowing $DISTRO/."
    for dir in "$DISTRO/"; do stow -t ~ "$dir"; done;
}

popd &>/dev/null

echo ">> Installing from gem."
sudo gem install mdl

echo ">> Installing from npm."
sudo npm install -g js-yaml jsonlint recess

echo ">> Installing from pip."
command -v pip > /dev/null && sudo pip install neovim
command -v pip2 > /dev/null && sudo pip2 install neovim
command -v pip3 > /dev/null && sudo pip3 install neovim

command -v gnome-shell-extension-tool > /dev/null && {
    gnome-shell-extension-tool -e dynamicTopBar@gnomeshell.feildel.fr || true
}

command -v gsettings > /dev/null && uname | grep -q Linux && {
    # pantheon terminal
    gsettings set org.pantheon.terminal.settings tab-bar-behavior 'Hide When Single Tab' || true
    gsettings set org.pantheon.terminal.settings natural-copy-paste true || true
    gsettings set org.pantheon.terminal.settings font 'Inconsolata LGC for Powerline Medium' || true
    gsettings set org.pantheon.terminal.settings foreground '#878787' || true
    gsettings set org.pantheon.terminal.settings background '#202020' || true
    gsettings set org.pantheon.terminal.settings palette '#151515:#AC4142:#7E8D50:#E5B567:#6C99BB:#9E4E85:#7DD5CF:#D0D0D0:#505050:#AC4142:#7E8D50:#E5B567:#6C99BB:#9E4E85:#7DD5CF:#F5F5F5' || true

    # elementaryos settings
    gsettings set org.gnome.settings-daemon.peripherals.keyboard repeat-interval 15 || true
    gsettings set org.gnome.settings-daemon.peripherals.touchpad natural-scroll true || true

    # gnome desktop
    gsettings set org.gnome.desktop.wm.preferences visual-bell true || true
    gsettings set org.gnome.desktop.wm.preferences audible-bell true || true

    gsettings set org.gnome.desktop.interface gtk-theme "Arc" || true
    gsettings set org.gnome.desktop.interface icon-theme "Elementary" || true
    gsettings set org.gnome.desktop.interface clock-format 12h || true

    gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 15 || true
    gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true || true
    gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true || true
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true || true

    # gnome terminal
    gsettings set org.gnome.Terminal.Legacy.Settings confirm-close false || true
    gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false || true

    # gnome terminal profile
    uuid=$(gsettings get org.gnome.Terminal.ProfilesList default | sed s/\'//g)
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uuid/ use-system-font false || true
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uuid/ font "Inconsolata LGC for Powerline Medium 12" || true
}

[ -n "$GOPATH" ] && export GOPATH=$HOME/dev
command -v nvim > /dev/null &&  {
    echo ">> Installing neovim plugins."
    nvim !silent +PlugInstall +qall
}

echo ">> Pulling SSH pubkeys from github."
curl -s https://github.com/roboll.keys > ~/.ssh/authorized_keys
