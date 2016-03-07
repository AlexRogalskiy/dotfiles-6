#! /bin/bash

set -e

function install-arch() {
    pacstrap -i /mnt base base-devel dkms lvm2 linux-headers \
        gnome lightdm lightdm-gtk-greeter

    genfstab -U /mnt >> /mnt/etc/fstab
}

function configure-arch() {
    if [ -z "$1" ]; then
        echo "!! Error: Must specify arch hostname." >&2
        exit 1
    fi

    local kernelv=$(arch-chroot /mnt /bin/bash -c "pacman -Qi linux | grep Version | sed -n 's/.*: \(.*\)/\1/p'")
    local arch_host=$1

    arch-chroot /mnt /bin/bash <<SCRIPT
        # hostname
        echo "$arch_host" > /etc/hostname

        # timezone
        ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

        # locale
        sed -i "s:#en_US.UTF-8:en_US.UTF-8:g" /etc/locale.gen
        echo "LANG=en_US.UTF-8" >/etc/locale.conf
        locale-gen

        # initrd support encrypted root w/ lvm
        sed -i "s:block filesystems:block encrypt lvm2 filesystems:g" /etc/mkinitcpio.conf
        mkinitcpio -g /boot/initramfs-linux.img -k $kernelv-ARCH

        # bootloader
        bootctl install

        # enable services
        systemctl enable dhcpcd bluetooth lightdm NetworkManager
SCRIPT
}

function configure-bootloader() {
    if [ -z "$1" ]; then
        echo "!! Error: Must specify device uuid." >&2
        exit 1
    fi

    echo -n > /mnt/boot/loader/entries/arch.conf
    echo title ArchLinux >> /mnt/boot/loader/entries/arch.conf
    echo linux /vmlinuz-linux >> /mnt/boot/loader/entries/arch.conf
    echo initrd /initramfs-linux.img >> /mnt/boot/loader/entries/arch.conf
    echo options cryptdevice=UUID=$1:vault root=/dev/mapper/vault-archroot rw >> /mnt/boot/loader/entries/arch.conf

}
