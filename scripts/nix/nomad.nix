# nixos configuration
# https://github.com/roboll/dotfiles

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./common.nix
    ];

  boot = with pkgs; {
    cleanTmpDir = true;
    loader = {
      gummiboot = {
        enable = true;
        timeout = 3;
      };

      grub.enable = false;
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [ "zfs" ];
  };

  system.stateVersion = "15.09";
  networking.hostName = "nomad";
  networking.hostId = "4051cd61";
  time.timeZone = "America/New_York";

  users = {
    extraUsers.roboll = {
      group = "wheel";
      extraGroups = [ ];
      isNormalUser = true;

      uid = 1001;
      home = "/home/roboll";
      createHome = true;
    };
  };
}
