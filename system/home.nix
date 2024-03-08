{
  lib,
  pkgs,
  ...
}: let
  #unstablePackages = [];
  unstablePackages = [(import <nixpkgs-unstable> {}).tutanota-desktop];
  stablePackages = import ./config/packages.nix {inherit pkgs;};
in {
  imports = [
    ./config/batterie_alert
    ./config/neovim
    ./config/secrets
    ./config/gui.nix
  ];

  nixpkgs.overlays = [(import ./pkgs)];

  programs = {
    home-manager.enable = true;
    nix-index.enable = true;
    bash = import ./config/bash.nix;
    git = import ./config/git.nix;
    irssi = import ./config/irssi.nix;
    firefox = import ./config/firefox.nix;
    qutebrowser = import ./config/qutebrowser.nix;
  };

  home = {
    username = "tristan";
    homeDirectory = "/home/tristan";
    keyboard.layout = "fr";
    sessionVariables = {
      EDITOR = "nvim";
      WLR_NO_HARDWARE_CURSORS = 1;
      BROWSER = "qutebrowser";
    };
    shellAliases = import ./config/aliases.nix;
    packages = stablePackages ++ unstablePackages;
  };

  nixpkgs.config = {
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "obsidian"
        "discord"
        "burpsuite"
      ];
    permittedInsecurePackages = ["electron-25.9.0"];
  };

  services.mpris-proxy.enable = true; # for bluetooth headset buttons features

  home.stateVersion = "22.05"; # DO NOT MODIFY
}
