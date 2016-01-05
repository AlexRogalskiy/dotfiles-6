# nixos configuration
# https://github.com/roboll/dotfiles

{ config, pkgs, ... }:

{
  networking = {
    wireless.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
  };

  fonts = with pkgs; {
    fonts = [ inconsolata ];

    fontconfig.defaultFonts.monospace = ["inconsolata"];
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    encfs stow

    go python ruby nodejs openjdk scala

    cmake gnumake gcc vim_configurable neovim

    git gist

    gradle sbt ant maven

    docker vagrant

    awscli ansible jq closurecompiler tree

    dropbox keybase spotify chromium terminator idea.idea-community

    inconsolata
  ];

  services = {
    xserver = {
      enable = true;
      layout = "us";

      desktopManager.kde5.enable = true;
      displayManager.kdm.enable = true;

      multitouch.invertScroll = false;

      synaptics = {
        enable = true;
        tapButtons = true;
        twoFingerScroll = true;
      };
    };

    #services.xserver.xkbOptions = "eurosign:e";
    #openssh.enable = true;
    #printing.enable = true;
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };
}
