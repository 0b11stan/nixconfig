{pkgs}: let
  stablePkgs =
    import (fetchTarball {
      url = "https://channels.nixos.org/nixos-25.05/nixexprs.tar.xz";
    }) {
      system = builtins.currentSystem;
    };
in
  with pkgs; [
    alejandra
    android-tools
    appimage-run
    (azure-cli.withExtensions [azure-cli-extensions.ssh])
    bat
    bemenu
    bindfs
    cifs-utils
    detox
    discord
    discordo
    dnsmasq
    dos2unix
    drawio
    envsubst
    evince
    # exegol4
    exfat
    exiftool
    ffmpeg
    file
    freerdp
    frida-tools
    gcc
    gimp
    gnumake
    gource
    go-task
    htmlq
    htop
    iw
    # TODO : have been removed from nixpkgs, need to find a replacement
    # jmtpfs
    jq
    keepassxc
    ksnip
    kubectl
    ldns # for dns utils
    libreoffice
    libsigrok
    man-pages
    mpv
    nfs-utils
    nixpkgs-fmt
    nmap
    notify-desktop
    ntfs3g
    obsidian
    openssl
    openvpn
    opkssh
    OVMF
    p7zip
    pavucontrol
    pciutils
    prismlauncher # minecraft
    pulseview
    python3
    qemu
    rdfind # duplicate file finder
    shutter
    signal-desktop
    sshpass
    ssm-session-manager-plugin
    steampipe
    steampipePackages.steampipe-plugin-aws
    # steampipePackages.steampipe-plugin-azure
    tigervnc
    tree
    universal-ctags
    unzip
    usbutils
    uv
    viu
    wl-clipboard
    wl-mirror
    xdg-utils
    xxd
    zip
    zotero
    zoxide
  ]
