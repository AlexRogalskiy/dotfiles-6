#! /bin/bash

set -e

function disable-root-login() {
    arch-chroot /mnt /bin/bash <<SCRIPT
        usermod -s /sbin/nologin root
SCRIPT
}

function create-default-user() {
    if [ -z "$1" ]; then
	echo "!! Error: Must specify a username." >&2 
	exit 1
    fi
   
    local username=$1 
    arch-chroot /mnt /bin/bash <<SCRIPT
        useradd -G wheel -u 1000 -m $username
        echo "$username ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/user
        echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers.d/wheel
SCRIPT
}
