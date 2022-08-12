{pkgs, ...}: {
  imports = [
    ./i3status.nix
    ./sway.nix
    ./qutebrowser.nix
    ./alacritty.nix
    ./batterie_alert.nix
  ];

  home.packages = with pkgs; [
    hack-font
    bemenu
    tutanota-desktop
    signal-desktop
    pavucontrol
    libreoffice
    drawio
    noto-fonts-emoji
    notify-desktop
  ];
}
