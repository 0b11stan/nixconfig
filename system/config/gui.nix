{
  config,
  pkgs,
  lib,
  ...
}: let
  mod = config.wayland.windowManager.sway.config.modifier;
  colors = import ./colors.nix;
  isDesktop = builtins.readDir /sys/class/power_supply == {};
in {
  home.packages = with pkgs; [
    swaylock
    xorg.xhost
    grim
    slurp
  ];

  wayland.windowManager.sway = import ./sway.nix {
    inherit colors config isDesktop lib pkgs;
  };

  fonts.fontconfig.enable = true;

  programs = {
    alacritty = import ./alacritty.nix {inherit colors;};
    waybar = {
      enable = true;
      style = ./gui/waybar.css;
    };
  };

  services = {
    mako = {
      enable = true;
      defaultTimeout = 10000;
      backgroundColor = "${colors.greyLighter}";
      borderColor = "${colors.orange}";
    };

    swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 60;
          command = "notify-desktop 'IDLE' 'I am going to sleep in 60s'";
        }
        {
          timeout = 115;
          command = "notify-desktop -t 5000 'IDLE' 'I am going to sleep in 5s'";
        }
        {
          timeout = 120;
          command = "swaylock -fF -c '#000100'";
        }
      ];
    };
  };
}
# TODO : https://www.reddit.com/r/swaywm/comments/gd7976/swayidle_in_lock_script_can_i_temporarily_disable/

