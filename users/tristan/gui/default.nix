{
  pkgs,
  lib,
  ...
}: let
  isDesktop = builtins.readDir /sys/class/power_supply == {};
  pkgsUnstable = import <nixpkgs-unstable> {}; # requires nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
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
    discord

    # utils
    pavucontrol
    bemenu
    notify-desktop
    wl-clipboard
    ffmpeg

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
    flowblade
    freerdp
    tigervnc
    notion-app-enhanced
    tdesktop

    # hashcat
    hashcat
    hashcat-utils
    hcxtools
  ];
}
