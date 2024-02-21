{pkgs}: let
  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-tetex framed tcolorbox sectsty;
  };
in
  with pkgs; [
    alejandra
    asciinema
    audacity
    bat
    bemenu
    bindfs
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
    gimp
    gnumake
    gource
    hack-font
    htmlq
    htop
    inkscape
    jmtpfs
    jq
    just
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
    obsidian
    obs-studio
    obs-studio-plugins.wlrobs
    openssl
    openvpn
    OVMF
    p7zip
    pandoc
    pavucontrol
    pciutils
    python3
    qemu
    qimgv
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
