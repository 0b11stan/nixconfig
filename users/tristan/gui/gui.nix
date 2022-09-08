{
  pkgs,
  lib,
  ...
}: let
  isDesktop = builtins.readDir /sys/class/power_supply == {};
in {
  imports =
    [
      ./i3status.nix
      ./sway.nix
      ./qutebrowser.nix
      ./alacritty.nix
      ./offsec.nix
    ]
    ++ (
      if !isDesktop
      then [./batterie_alert.nix]
      else []
    );

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
    ];

  home.packages = with pkgs; [
    # fonts
    hack-font
    noto-fonts-emoji

    # socials
    tutanota-desktop
    signal-desktop
    discord

    # utils
    pavucontrol
    bemenu
    notify-desktop
    wl-clipboard

    # apps
    evince
    libreoffice
    drawio
    gimp
  ];
}
