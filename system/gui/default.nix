{
  pkgs,
  lib,
  ...
}: let
  isDesktop = builtins.readDir /sys/class/power_supply == {};
  pkgsUnstable = import <nixpkgs-unstable> {};
in {
  imports =
    [
      ./obstudio.nix
      ./i3status.nix
      ./sway.nix
      ./qutebrowser.nix
      ./firefox.nix
      ./alacritty.nix
      ./offsec.nix
      ./screenshot.nix
    ]
    ++ (
      if !isDesktop
      then [./batterie_alert]
      else []
    );

  home.packages = with pkgs; [
    # fonts
    hack-font
    noto-fonts
    noto-fonts-emoji
    noto-fonts-extra

    # socials
    pkgsUnstable.tutanota-desktop
    signal-desktop
    tdesktop
    discord

    # utils
    xdg-utils
    pavucontrol
    bemenu
    notify-desktop
    wl-clipboard
    ffmpeg
    cifs-utils

    # apps
    tor-browser-bundle-bin
    audacity
    chromium
    epiphany
    evince
    libreoffice
    drawio
    gimp
    inkscape
    mpv
    tor-browser-bundle-bin
    xfce.thunar
    exiftool
    qimgv
    jmtpfs
    flowblade
    freerdp
    tigervnc
    notion-app-enhanced
    tdesktop
    monero-gui
    obsidian
    keepassxc

    # hashcat
    hashcat
    hashcat-utils
    hcxtools
  ];
}
