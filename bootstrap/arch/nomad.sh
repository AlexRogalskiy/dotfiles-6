#! /bin/bash

set -e

source ./parts/vault.sh
source ./parts/arch.sh
source ./parts/user.sh

ARCH_HOST=nomad

EFI_DEVICE=/dev/sda1
VAULT_DEVICE=/dev/sda5

echo "!! Are you connected to the internet?"
echo "!! Did you make sure the arch kernel and initramfs are not in the efi partition?"

echo ">> Using ARCH_HOST $ARCH_HOST."
echo ">> Using EFI_DEVICE $EFI_DEVICE."
echo ">> Using VAULT_DEVICE $VAULT_DEVICE."
read -p "!! Press any key to confirm."

echo ">> Creating luks container 'vault' on $VAULT_DEVICE."
cryptsetup luksFormat $VAULT_DEVICE
cryptsetup open --type luks $VAULT_DEVICE vault
CRYPTUUID=`blkid $VAULT_DEVICE | sed -n 's/.* UUID="\([^"]*\)".*/\1/p'`

echo ">> Creating lvm in luks container 'vault'."
create-lvm

echo ">> Formatting vault/swap as swap."
create-swap 16G

echo ">> Formatting vault/archroot as ext4."
create-archroot 48G

echo ">> Formatting vault/home as ext4."
create-home

echo ">> Mounting vault devices to /mnt/..."
mkdir -p /mnt
mount /dev/vault/archroot /mnt

mkdir /mnt/home
mount /dev/vault/home /mnt/home

mkdir -p /mnt/boot
mount $EFI_DEVICE /mnt/boot
echo ">> Mounted devices."

echo ">> Installing arch to /mnt."
install-arch

echo ">> Configuring arch install."
configure-arch $ARCH_HOST

echo ">> Placing macbook hardware drivers."
cp -r ./macbook /mnt/install

echo ">> Disabling root login shell."
disable-root-login

echo ">> Creating default user."
create-default-user roboll

echo ">> Setting default user password."
passwd -R /mnt roboll

echo ">> Writing bootloader entry."
configure-bootloader $CRYPTUUID

echo "!! Consider updating /mnt/etc/pacman.d/mirrorlist for a local mirror!"
echo ">> Install complete, reboot. After reboot, run /install/complete.sh"
