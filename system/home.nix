{
  lib,
  pkgs,
  ...
}: let
  stablePackages = import ./config/packages.nix {inherit pkgs;};
  unstablePackages = [(import <nixpkgs-unstable> {}).tutanota-desktop];
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
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["obsidian" "discord"];
    permittedInsecurePackages = ["electron-24.8.6"];
  };

  home.stateVersion = "22.05"; # DO NOT MODIFY
}
