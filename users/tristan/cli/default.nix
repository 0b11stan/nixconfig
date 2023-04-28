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
    ubuntu = "podman run -it --network=host -v $PWD:/srv docker.io/ubuntu bash";
    search = ''
      grep --color \
        --binary-files=without-match \
        --exclude-dir=.git \
        --exclude-dir=venv \
        --recursive \
        --ignore-case \
    '';
    virsh = "sudo virsh";
    gs = "git status";
    gd = "git diff";
    gac = "git commit -am";
    gp = "git push";
    password = "head -c 15 /dev/urandom | base32";
    dush = "sudo du -sh .[!.]* * 2>/dev/null | sort -h";
    openports = "ss -ltn4 'src = 0.0.0.0'";
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
    detox
    nfs-utils
    man-pages

    # apps
    asciinema
    transmission
    asciinema
    qemu
    dnsmasq

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
