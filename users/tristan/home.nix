{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./cli
    ./gui
  ];

  programs.home-manager.enable = true;

  nixpkgs.overlays = [(import ./pkgs)];

  home = {
    username = "tristan";
    homeDirectory = "/home/tristan";
    keyboard.layout = "fr";
    sessionVariables = {
      EDITOR = "nvim";
      WLR_NO_HARDWARE_CURSORS = 1;
    };
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "rar"
      "burpsuite"
      "wpscan"
      "volatility3"
      "notion-app-enhanced-v2.0.18"
    ];

  home.stateVersion = "22.05"; # DO NOT MODIFY
}
