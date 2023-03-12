{
  pkgs,
  lib,
  ...
}: let
  isDesktop = builtins.readDir /sys/class/power_supply == {};
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
    tutanota-desktop
    signal-desktop
    discord

    # utils
    pavucontrol
    bemenu
    notify-desktop
    wl-clipboard
    ffmpeg

    # apps
    audacity
    chromium
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
  ];
}
