#! /usr/bin/env bash
set -e

echo ">> Installing for NixOS."
sudo cp "$(realpath "$(dirname "${BASH_SOURCE}")")/Caps2Ctrl.map" /etc/nixos/Caps2Ctrl.map
sudo cp "$(realpath "$(dirname "${BASH_SOURCE}")")/$BOXNAME.nix" /etc/nixos/configuration.nix
sudo cp "$(realpath "$(dirname "${BASH_SOURCE}")")/common.nix" /etc/nixos/common.nix

sudo nixos-rebuild switch
