{
  config,
  lib,
  pkgs,
  ...
}: let
  hostname = builtins.getEnv "HOSTNAME";
  isDesktop = builtins.readDir /sys/class/power_supply == {};
in {
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = ["tristan"];

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    settings.auto-optimise-store = true;
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    nameservers = ["1.1.1.1" "1.0.0.1"];
    resolvconf = {
      enable = false;
      useLocalResolver = true;
    };
    firewall = {
      enable = false;
      allowedTCPPorts = [4444];
    };
  };

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";

  console = {
    font =
      if builtins.hasAttr "hid_apple" (builtins.readDir /sys/module)
      then "Lat2-Terminus16"
      else "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
    keyMap = "fr";
  };
  programs = {
    wireshark.enable = true;
    adb.enable = true;
    fuse.userAllowOther = true;
  };

  hardware = {
    pulseaudio.enable = true;
    opengl.enable = true;
  };

  security.pam.services.swaylock = {};

  virtualisation = {
    podman.enable = true;
    docker.enable = true;
  };

  # TODO : limit to gui
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-wlr];
  };

  services = {
    pipewire.enable = true;
    sshd.enable = isDesktop;
  };

  users = {
    users.tristan = {
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "wireshark" "adbusers" "docker"];
    };
  };

  home-manager.users.tristan = ./home.nix;
  fonts.enableDefaultFonts = true;

  system.stateVersion = "22.05"; # DO NOT MODIFY
}
