#! /bin/bash

set -e

function create-vault() {
    if [ -z "$1" ]; then
	echo "!! Error: Must specify a vault device." >&2 
	exit 1
    fi

    local device=$1
    cryptsetup luksFormat $device
    cryptsetup open --type luks $device vault
    local crypt=`blkid $device | sed -n 's/.* UUID="\([^"]*\)".*/\1/p'`
    printf $crypt
}

function create-lvm() {
    pvcreate /dev/mapper/vault
    vgcreate vault /dev/mapper/vault
} 

function create-swap() {
    if [ -z "$1" ]; then
        echo "!! Error: Must specify swap lv size." >&2
        exit 1
    fi

    lvcreate -L $1 -n swap vault
    mkswap /dev/vault/swap
}

function create-archroot() {
    if [ -z "$1" ]; then
        echo "!! Error: Must specify archroot lv size." >&2
        exit 1
    fi

    lvcreate -L $1 -n archroot vault
    mkfs.ext4 /dev/vault/archroot
}

function create-home() {
    lvcreate -l 100%FREE -n home vault
    mkfs.ext4 /dev/vault/home
}
