{lib, ...}: {
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
    ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
}
