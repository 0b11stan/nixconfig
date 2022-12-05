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
    firefox
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
  ];

  # temporary fix for https://github.com/qutebrowser/qutebrowser/issues/7208
  home.shellAliases.gitlab = ''
    qutebrowser --temp-basedir ":set content.headers.user_agent 'cloudflare 503 workaround'" https://gitlab.com/users/sign-in
  '';
}
