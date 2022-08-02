{...}: let
  colors = import ./colors.nix;
in {
  programs.i3status = {
    enable = true;
    general = {
      colors = true;
      interval = 1;
      color_good = "${colors.green}";
      color_degraded = "${colors.yellow}";
      color_bad = "${colors.red}";
    };
    modules = {
      "wireless _first_".enable = false;
      "battery all".enable = true;
      "ipv6".enable = false;
      "volume master" = {
        position = 0;
        settings = {
          format = "♪ %volume";
          format_muted = "♪ muted (%volume)";
          device = "pulse:1";
        };
      };
      "ethernet _first_" = {
        position = 1;
        settings = {
          format_up = "ETH: %ip (%speed)";
          format_down = "ETH: dawn";
        };
      };
      "disk /" = {
        position = 2;
        settings = {
          format = "DISK: %avail";
        };
      };
      "memory" = {
        position = 3;
        settings = {
          format = "MEM: %used / %available";
          threshold_degraded = "1G";
          format_degraded = "MEM: MEMORY < %available";
        };
      };
      "load" = {
        position = 4;
        settings = {
          format = "CPU: %1min";
        };
      };
      "tztime local" = {
        position = 5;
        settings = {
          format = "%Y-%m-%d %H:%M:%S";
        };
      };
    };
  };
}
