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
    htmlq
    alejandra
    python39
    gource
    bat
    bind
    evince
    openvpn
    zip
    unzip
  ];

  home.shellAliases = {
    cme = "mkdir -p ~/.cme && podman run -it --rm -v ~/.cme:/root/.cme -v $PWD:/srv -w /srv byt3bl33d3r/crackmapexec";
  };

  programs.bash.enable = true;
}
