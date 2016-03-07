#! /usr/bin/env bash
set -e

echo ">> Installing with arch pacman."

grep archlinuxfr /etc/pacman.conf > /dev/null || {
    echo [archlinuxfr] >> /etc/pacman.conf
    echo SigLevel = Optional >> /etc/pacman.conf
    echo Server = http://repo.archlinux.fr/\$arch >> /etc/pacman.conf
}

pacman --noconfirm -Syu stow neovim xsel xorg-xmodmap htop hfsprogs jdk8-openjdk git mercurial \
    ruby go cmake python-pip python2 python2-pip npm nodejs scala gradle maven docker markdown \
    vagrant virtualbox shellcheck jq keybase tmux tree \
    keybase dropbox pantheon-terminal yaourt

pacman -Q | grep gnome-terminal && pacman --noconfirm -R gnome-terminal

sudo -u roboll yaourt --noconfirm -S google-chrome touchegg \
    lightdm-webkit2-greeter lightdm-webkit-google-git \
    gtk-theme-arc elementary-icon-theme gnome-shell-extension-dynamic-top-bar \
    ttf-inconsolata-lgc-for-powerline

sed -i /etc/lightdm/lightdm.conf \
    -e 's/#greeter-session=.*/greeter-session=lightdm-webkit2-greeter/g' \
    -e 's/#user-session=.*/user-session=gnome/g'

sed -i /etc/lightdm/lightdm-webkit2-greeter.conf -e 's/antergos/lightdm-webkit-google/g'

cp $(dirname "${BASH_SOURCE}")/roboll.jpg /usr/share/roboll.jpg
echo "Icon=/usr/share/roboll.jpg" >> /var/lib/AccountsService/users/roboll

echo "options hid_magicmouse scroll-speed=50 scroll-acceleration=1" | \
    sudo tee /etc/modprobe.d/magicmouse.conf > /dev/null

cat <<MOUSE > /usr/share/X11/xorg.conf.d/10-magicmouse.conf
Section "InputClass"
        Identifier "Rob's Home Mouse"
        Option "ButtonMapping" "1 0 3 5 4 7 6 0 0 0 0 0"
EndSection
MOUSE
