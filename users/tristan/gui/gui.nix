{pkgs, ...}: {
  imports = [
    ./i3status.nix
    ./sway.nix
    ./qutebrowser.nix
    ./alacritty.nix
  ];

  home.packages = with pkgs; [
    hack-font
    bemenu
    tutanota-desktop
    signal-desktop
    pavucontrol
  ];
}
