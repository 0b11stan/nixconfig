{pkgs, ...}: {
  imports = [
    ./secrets.nix
    ./neovim.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    file
    htop
    jq
    alejandra
    python39
  ];
}
