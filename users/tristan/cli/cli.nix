{pkgs, ...}: {
  imports = [
    ./secrets.nix
    ./neovim.nix
    ./git.nix
    ./offsec.nix
  ];

  home.packages = with pkgs; [
    file
    htop
    jq
    alejandra
    python39
    gource
    bat
    bind
    evince
    openvpn
    noto-fonts-emoji
    gnumake
    pandoc
  ];

  programs.bash.enable = true;
}
