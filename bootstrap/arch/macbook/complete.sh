#! /bin/bash

set -e

pacman --noconfirm -U /install/drivers/*.xz
rmmod b43 b43legacy ssb bcm43xx brcm80211 brcmfmac brcmsmac bcma wl || true
modprobe wl || true

rm -r /install
