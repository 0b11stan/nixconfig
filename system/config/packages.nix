{pkgs}: let
  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-tetex framed tcolorbox sectsty;
  };
in
  with pkgs; [
    alejandra
    bat
    bemenu
    bindfs
    (burpsuite.override {proEdition = true;})
    cifs-utils
    detox
    discord
    dnsmasq
    dos2unix
    drawio
    evince
    exegol
    exfat
    exiftool
    ffmpeg
    file
    freerdp
    gcc
    gnumake
    gource
    hack-font
    htmlq
    htop
    jmtpfs
    jq
    keepassxc
    ldns # for dns utils
    libreoffice
    man-pages
    monero-gui
    mpv
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    nfs-utils
    nixpkgs-fmt
    notify-desktop
    noto-fonts
    noto-fonts-emoji
    noto-fonts-extra
    ntfs3g
    obsidian
    openssl
    openvpn
    OVMF
    p7zip
    pandoc
    pavucontrol
    pciutils
    python3
    qemu
    rdfind # duplicate file finder
    signal-desktop
    sshpass
    tex
    tigervnc
    tor-browser-bundle-bin
    transmission
    tree
    unzip
    usbutils
    wl-clipboard
    wl-mirror
    xdg-utils
    xfce.thunar
    zip
  ]
