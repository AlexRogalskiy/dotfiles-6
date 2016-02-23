#! /usr/bin/env bash
set -e

echo ">> Installing for arch pacman system."

grep archlinuxfr /etc/pacman.conf > /dev/null || {
    echo [archlinuxfr] >> /etc/pacman.conf
    echo SigLevel = Optional >> /etc/pacman.conf
    echo Server = http://repo.archlinux.fr/\$arch >> /etc/pacman.conf
}
pacman -Syu --noconfirm yaourt

pacman --noconfirm -S stow neovim htop hfsprogs jdk8-openjdk mercurial \
    ruby go python-pip npm nodejs scala gradle maven docker markdown \
    vagrant virtualbox shellcheck jq keybase tmux \
    keybase dropbox yaourt 

sudo -u roboll yaourt --noconfirm -S google-chrome touchegg

echo "options hid_magicmouse scroll-speed=50 scroll-acceleration=1" | \
    sudo tee /etc/modprobe.d/magicmouse.conf > /dev/null

cat <<MOUSE > /usr/share/X11/xorg.conf.d/10-magicmouse.conf
Section "InputClass"
        Identifier "Rob's Home Mouse"
        Option "ButtonMapping" "1 0 3 5 4 7 6 0 0 0 0 0"
EndSection
MOUSE
