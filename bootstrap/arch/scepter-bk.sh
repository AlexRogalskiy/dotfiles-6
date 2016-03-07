#! /bin/bash

set -e

source ./vault.sh
source ./arch.sh

ARCH_HOST=scepter

EFI_DEVICE=/dev/sda1
VAULT_DEVICE=/dev/sda2

echo ">> Using ARCH_HOST $ARCH_HOST."
echo ">> Using EFI_DEVICE $EFI_DEVICE."
echo ">> Using VAULT_DEVICE $VAULT_DEVICE."
read -p "!! Press any key to confirm."

echo ">> Creating luks container 'vault' on $VAULT_DEVICE."
CRYPTUUID=`create-vault $VAULT_DEVICE`

echo ">> Creating lvm in luks container 'vault'."
create-lvm

echo ">> Formatting vault/swap as swap."
create-swap 16G

# TODO CHANGE TO BTRFS
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

echo ">> Writing bootloader entry."
configure-bootloader $CRYPTUUID

echo ">> Install complete, reboot."
