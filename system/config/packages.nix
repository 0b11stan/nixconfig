{pkgs}: let
  tex = pkgs.texlive.combine {
    inherit
      (pkgs.texlive)
      adjustbox
      babel-german
      background
      biber
      bidi
      collectbox
      csquotes
      everypage
      filehook
      footmisc
      footnotebackref
      framed
      fvextra
      letltxmacro
      ly1
      mdframed
      mweights
      needspace
      pagecolor
      scheme-tetex
      sectsty
      sourcecodepro
      sourcesanspro
      tcolorbox
      titling
      ucharcat
      ulem
      unicode-math
      upquote
      xecjk
      xurl
      zref
      ;
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
    ghidra
    gimp
    gnumake
    gource
    hack-font
    htmlq
    htop
    iw
    jmtpfs
    jq
    keepassxc
    ldns # for dns utils
    libreoffice
    man-pages
    minecraft
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
    pavucontrol
    pciutils
    python3
    qemu
    rdfind # duplicate file finder
    signal-desktop
    sshpass
    ssm-session-manager-plugin
    tenv
    tex
    tigervnc
    tor-browser-bundle-bin
    tree
    unzip
    usbutils
    uv
    wireguard-tools
    wl-clipboard
    wl-mirror
    xdg-utils
    xfce.thunar
    xxd
    zip
    zoxide
  ]
