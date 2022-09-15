{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.cleanTmpDir = true;

  nixpkgs.config.allowUnfree = true;

  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  networking = {
    useDHCP = lib.mkDefault true;
    hostName = "master";
    networkmanager.enable = true;
    nameservers = ["1.1.1.1" "1.0.0.1"];
    resolvconf.enable = false;
    resolvconf.useLocalResolver = true;
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

  hardware.pulseaudio.enable = true;
  hardware.opengl.enable = true;

  programs.wireshark.enable = true;

  users = {
    groups.netdev.members = ["tristan"]; # for qemu
    users.tristan = {
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "wireshark" "netdev"];
    };
  };

  security.pam.services.swaylock = {};

  virtualisation.podman.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [4444];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
