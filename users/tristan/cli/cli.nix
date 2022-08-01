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
    unzip
  ];

  home.shellAliases = {
    cme = "mkdir -p ~/.cme && podman run -it --rm -v ~/.cme:/root/.cme --entrypoint=cme byt3bl33d3r/crackmapexec";
  };

  programs.bash.enable = true;
}
