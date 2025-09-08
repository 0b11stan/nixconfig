{
  config,
  lib,
  pkgs,
  ...
}: {
  # TODO : https://nixos.wiki/wiki/Nvidia
  # TODO : https://exegol.readthedocs.io/en/latest/getting-started/faq.html#how-to-install-exegol-on-an-external-drive
  imports = [
    ./hardware-configuration.nix
    ./clients/system.nix
    <home-manager/nixos>
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    settings.auto-optimise-store = true;
  };

  networking = {
    hostName = "trinity";
    hosts = {
      "192.168.1.242" = ["zion.tic.sh" "shynet.zion.tic.sh"];
    };
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    extraHosts = ""; # instead use : sudo dnsmasq --server 1.1.1.1 -A /...domain.../...ip...
    firewall = {
      enable = false;
      allowedTCPPorts = [
        5182 # for wireguard
        4444
      ];
    };
  };

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  console.keyMap = "fr";

  programs = {
    wireshark.enable = true;
    adb.enable = true;
    fuse.userAllowOther = true;
    noisetorch.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics.enable = true;
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
    #vmware.host.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-wlr];
    config.common.default = "*";
  };

  services = {
    xserver.videoDrivers = ["nvidia"];
    pulseaudio.enable = true;
    dnsmasq = {
      enable = true;
      settings.server = ["1.1.1.1" "8.8.8.8"];
    };
    blueman.enable = true;
    pipewire.enable = true;
    sshd.enable = true;
    mullvad-vpn.enable = true;
    printing = {
      # TODO : https://nixos.wiki/wiki/Printing
      enable = true;
      drivers = [pkgs.epsonscan2];
    };
    davfs2 = {
      enable = true;
      davUser = "tristan";
      davGroup = "users";
    };
    netbird.enable = true;
    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };
  };

  users = {
    users.tristan = {
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "wireshark" "adbusers" "docker" "scanner" "vboxusers"];
    };
  };

  environment = {
    etc."qemu/bridge.conf".text = "allow all";
    systemPackages = with pkgs; [wireshark];
  };

  home-manager.users.tristan = ./home.nix;

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      hack-font
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-emoji
      noto-fonts-extra
    ];
  };

  system.stateVersion = "24.11"; # DO NOT MODIFY !
}
