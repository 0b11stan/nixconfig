{...}: {
  programs.i3status = {
    enable = true;
    general = {
      colors = true;
      interval = 1;
    };
    modules = {
      "wireless _first_".enable = false;
      "battery all".enable = false;
      "ipv6".enable = false;
      "ethernet _first_" = {
        position = 0;
        settings = {
          format_up = "ETH: %ip (%speed)";
          format_down = "ETH: dawn";
        };
      };
      "disk /" = {
        position = 1;
        settings = {
          format = "DISK: %avail";
        };
      };
      "memory" = {
        position = 2;
        settings = {
          format = "MEM: %used / %available";
          threshold_degraded = "1G";
          format_degraded = "MEM: MEMORY < %available";
        };
      };
      "load" = {
        position = 3;
        settings = {
          format = "CPU: %1min";
        };
      };
      "tztime local" = {
        position = 4;
        settings = {
          format = "%Y-%m-%d %H:%M:%S";
        };
      };
    };
  };
}
