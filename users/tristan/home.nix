{ config, pkgs, lib, ... }:
{
  imports = [
    ./cli/secrets.nix
    ./cli/neovim.nix
    ./gui/sway.nix
    ./gui/i3status.nix
    ./gui/qutebrowser.nix
  ];

  programs.home-manager.enable = true;

  home.username = "tristan";
  home.homeDirectory = "/home/tristan";
  home.keyboard.layout = "fr";
  home.sessionVariables = {
    EDITOR = "nvim";
    WLR_NO_HARDWARE_CURSORS = 1;
  };

  home.packages = with pkgs; [
    git
    nixpkgs-fmt
    hack-font
    file
    tutanota-desktop
    htop
    bemenu
  ];

  programs.alacritty.enable = true;

  programs.bash.enable = true;

  home.file.".gitconfig".text = ''
    [user]
      email = tristan@tic.sh
      name = Tristan Pinaudeau
    [init]
      defaultBranch = main
    [pull]
      rebase = false
  '';

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
