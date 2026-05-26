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
    htmlq
    htop
    iw
    jmtpfs
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
    python3
    qemu
    rdfind # duplicate file finder
    shutter
    signal-desktop
    sshpass
    ssm-session-manager-plugin
    pulseview
    tenv
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
    zoxide
  ]
