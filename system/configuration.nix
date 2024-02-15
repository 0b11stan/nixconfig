{
  config,
  lib,
  pkgs,
  ...
}: let
  hostname = builtins.getEnv "HOSTNAME";
  isDesktop = builtins.readDir /sys/class/power_supply == {};
  isLaptop = !isDesktop;
in {
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    settings.auto-optimise-store = true;
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    nameservers = ["1.1.1.1" "8.8.8.8"];
    extraHosts = ""; # instead use : sudo dnsmasq --server 1.1.1.1 -A /...domain.../...ip...
    resolvconf = {
      enable = false;
      useLocalResolver = true;
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [4444 4443];
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
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    pulseaudio.enable = true;
    opengl.enable = true;
    sane = {
      enable = true;
      extraBackends = [pkgs.sane-airscan];
    };
  };

  security.pam.services.swaylock = {};

  virtualisation = {
    podman.enable = true;
    docker.enable = true;
    virtualbox.host.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-wlr];
    config.common.default = "*";
  };

  services = {
    blueman.enable = true;
    pipewire.enable = true;
    sshd.enable = isDesktop;
    printing = {
      # TODO : https://nixos.wiki/wiki/Printing
      enable = true;
      drivers = [pkgs.epsonscan2];
    };
  };

  users = {
    users.tristan = {
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "wireshark" "adbusers" "docker" "lp" "scanner" "vboxusers"];
    };
  };

  environment.etc."qemu/bridge.conf".text = "allow all";

  home-manager.users.tristan = ./home.nix;
  fonts.enableDefaultPackages = true;

  system.stateVersion = "22.05"; # DO NOT MODIFY
}
