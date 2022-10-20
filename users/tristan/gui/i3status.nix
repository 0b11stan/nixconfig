{...}: let
  colors = import ./colors.nix;
  isDesktop = builtins.readDir /sys/class/power_supply == {};
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
      "battery all".enable = !isDesktop;
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
      "wireless _first_" = {
        position = 2;
        settings = {
          format_up = "WLAN: %essid - %ip (%quality, %bitrate)";
          format_down = "WLAN: dawn";
        };
      };
      "disk /" = {
        position = 3;
        settings = {
          format = "DISK: %avail";
        };
      };
      "memory" = {
        position = 4;
        settings = {
          format = "MEM: %used / %available";
          threshold_degraded = "1G";
          format_degraded = "MEM: MEMORY < %available";
        };
      };
      "load" = {
        position = 5;
        settings = {
          format = "CPU: %1min";
        };
      };
      "tztime local" = {
        position = 6;
        settings = {
          format = "%Y-%m-%d %H:%M:%S";
        };
      };
    };
  };
}
