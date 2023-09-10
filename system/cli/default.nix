{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./secrets
    ./neovim
    ./git.nix
    #    ./offsec.nix # TODO : remove offsec definitely
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
    mount = "sudo mount -o uid=$(id -u),gid=$(id -g)";
  };

  home.packages = with pkgs; [
    # utilitaires
    bat
    bind
    cifs-utils
    detox
    dos2unix
    exfatprogs
    file
    gource
    htop
    man-pages
    nfs-utils
    nixpkgs-fmt
    openssl
    openvpn
    pciutils
    rar
    rdfind
    tree
    unzip
    usbutils
    zip

    # apps
    asciinema
    dnsmasq
    transmission
    exegol

    # virt
    qemu
    OVMF

    # formaters / linters
    alejandra
    htmlq
    jq

    # source / build tool
    gcc
    gnumake
    just
    pandoc
    python310
  ];
}
