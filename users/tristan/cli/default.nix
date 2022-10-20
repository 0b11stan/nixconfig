{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./secrets
    ./neovim
    ./git.nix
    ./offsec.nix
    ./irssi.nix
  ];

  home.shellAliases = {
    ip = "ip --color --brief";
    watch = "watch --color";
    tree = "tree -C";
    archlinux = "podman run -it --network=host -v $PWD:/srv docker.io/archlinux bash";
    debian = "podman run -it --network=host -v $PWD:/srv docker.io/debian bash";
    search = "grep --exclude-dir=.git -ri";
    virsh = "sudo virsh";
  };

  home.packages = with pkgs; [
    # utilitaires
    file
    htop
    bat
    gource
    bind
    zip
    unzip
    openvpn
    exfatprogs
    pciutils
    tree
    nixpkgs-fmt
    rdfind
    rar
    dos2unix

    # apps
    transmission
    virt-manager

    # formaters / linters
    jq
    htmlq
    alejandra

    # source / build tool
    python39
    gcc
    gnumake
    just
    pandoc
  ];
}
