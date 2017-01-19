#! /usr/bin/env bash

set -eo pipefail

setup() {
echo ">> Installing with arch pacman."

grep archlinuxfr /etc/pacman.conf > /dev/null || {
    printf "%s" "[archlinuxfr]\nSigLevel = Optional\nServer = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf
}

pacman --noconfirm -Syu stow neovim xsel xorg-xmodmap htop hfsprogs jdk8-openjdk git mercurial \
    ruby go cmake python-pip python2 python2-pip npm nodejs scala gradle maven docker markdown \
    vagrant virtualbox shellcheck jq keybase tmux tree \
    keybase dropbox pantheon-terminal light-locker yaourt

pacman -Q | grep gnome-terminal && pacman --noconfirm -R gnome-terminal

sudo -u roboll yaourt --noconfirm -S lightdm-webkit2-greeter
sudo -u roboll yaourt --noconfirm -S lightdm-webkit-google-git

sudo -u roboll yaourt --noconfirm -S google-chrome touchegg \
    gtk-theme-arc elementary-icon-theme gnome-shell-extension-dynamic-top-bar \
    ttf-inconsolata-lgc-for-powerline

cp "$(dirname "${BASH_SOURCE[0]}")/roboll.jpg" /usr/share/roboll.jpg
echo "Icon=/usr/share/roboll.jpg" >> /var/lib/AccountsService/users/roboll

echo "options hid_magicmouse scroll-speed=50 scroll-acceleration=1 emulate_3button=0" | \
    sudo tee /etc/modprobe.d/magicmouse.conf > /dev/null

cat <<MOUSE > /usr/share/X11/xorg.conf.d/10-magicmouse.conf
Section "InputClass"
        Identifier "roboll mouse"
        Option "ButtonMapping" "1 0 3 5 4 7 6 0 0 0 0 0"
EndSection
MOUSE

}

configure() {
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
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$uuid"/ use-system-font false || true
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$uuid"/ font "Inconsolata LGC for Powerline Medium 12" || true

    gnome-shell-extension-tool -e dynamicTopBar@gnomeshell.feildel.fr || true
}
