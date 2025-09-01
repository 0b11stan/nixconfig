{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./config/batterie_alert
    ./config/neovim
    ./config/secrets
    ./config/pandoc
    ./config/gui.nix
    ./clients/home.nix
  ];

  nixpkgs = {
    overlays = [(import ./pkgs)];
    config.packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") {
        inherit pkgs;
      };
    };
  };

  programs = {
    home-manager.enable = true;
    nix-index.enable = true;
    bash = import ./config/bash.nix {inherit pkgs;};
    git = import ./config/git.nix;
    irssi = import ./config/irssi.nix;
    firefox = import ./config/firefox.nix;
    qutebrowser = import ./config/qutebrowser.nix;
    fzf = {
      enable = true;
      #      defaultOptions = ["--ignore-case" "--height=10" "--layout=reverse"];
      #      historyWidgetOptions = ["--ignore-case" "--height=10" "--layout=reverse"];
    };
  };

  home = {
    username = "tristan";
    homeDirectory = "/home/tristan";
    keyboard.layout = "fr";
    sessionVariables = {
      # for ghidra (and other java apps to work)
      _JAVA_AWT_WM_NONREPARENTING = 1;
      EDITOR = "nvim";
      WLR_NO_HARDWARE_CURSORS = 1;
      BROWSER = "qutebrowser";
    };
    shellAliases = import ./config/aliases.nix;
    packages = import ./config/packages.nix {inherit pkgs;};
  };

  nixpkgs.config.allowBroken = true;
  nixpkgs.config = {
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "burpsuite"
        "discord"
        "drawio"
        "minecraft-launcher"
        "obsidian"
        "copilot.vim"
      ];

    permittedInsecurePackages = ["nix-2.15.3" "electron-25.9.0"];
  };

  services = {
    mpris-proxy.enable = true; # for bluetooth headset buttons features
    #netbird.enable = true;
  };

  home.stateVersion = "22.05"; # DO NOT MODIFY
}
