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
    extraHosts = ''
      57.128.18.85 ragnarhack.fr manager.ragnarhack.fr rp.ragnarhack.fr ctfd.ragnarhack.fr
    '';
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
  programs.adb.enable = true;

  users = {
    users.tristan = {
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "wireshark" "libvirtd" "adbusers"];
    };
  };

  security.pam.services.swaylock = {};

  virtualisation = {
    libvirtd.enable = true;
    podman.enable = true;
  };

  # TODO : limit to gui
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-wlr];
  services.pipewire.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [4444];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
