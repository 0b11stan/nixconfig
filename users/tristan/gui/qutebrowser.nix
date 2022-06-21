{ config, pkgs, lib, ... }:
{
  # TODO : add binding for spawn mpv (voir man home-config)
  programs.qutebrowser = {
    enable = true;
    keyBindings = {
      normal = {
        "J" = "back";
        "K" = "tab-prev";
        "L" = "tab-next";
        "M" = "forward";
        "j" = "scroll left";
        "k" = "scroll down";
        "l" = "scroll up";
        "m" = "scroll right";
      };
    };
  };
}
