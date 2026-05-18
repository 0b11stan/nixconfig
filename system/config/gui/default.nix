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
    xhost
    grim
    slurp
  ];

  wayland.windowManager.sway = import ./sway.nix {
    inherit colors config isDesktop lib pkgs;
  };

  fonts.fontconfig.enable = true;

  programs = {
    alacritty = import ./alacritty.nix {inherit colors pkgs;};
    kitty = import ./kitty.nix;
    waybar = {
      # TODO : https://github.com/catppuccin/waybar
      enable = true;
      style = ./waybar.css;
      settings = {
        mainBar = {
          spacing = 1;
          modules-left = ["sway/workspaces" "sway/mode" "sway/scratchpad"];
          modules-center = ["sway/window"];
          modules-right = [
            "pulseaudio"
            "bluetooth"
            "network"
            "custom/notification"
            "backlight"
            "battery"
            "cpu"
            "memory"
            "sway/language"
            "clock"
            "tray"
          ];

          "keyboard-state" = {
            numlock = false;
            capslock = true;
            format = "{name} {icon}";
            format-icons = {
              locked = "";
              unlocked = "";
            };
          };

          "sway/mode" = {
            format = "<span style=\"italic\">{}</span>";
          };

          "sway/scratchpad" = {
            format = "{icon} {count}";
            show-empty = false;
            format-icons = ["" ""];
            tooltip = true;
            tooltip-format = "{app}: {title}";
          };

          mpd = {
            format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
            format-disconnected = "Disconnected ";
            format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
            unknown-tag = "N/A";
            interval = 5;
            consume-icons = {
              on = " ";
            };
            random-icons = {
              off = "<span color=\"#f53c3c\"></span> ";
              on = " ";
            };
            repeat-icons = {
              on = " ";
            };
            single-icons = {
              on = "1 ";
            };
            state-icons = {
              paused = "";
              playing = "";
            };
            tooltip-format = "MPD (connected)";
            tooltip-format-disconnected = "MPD (disconnected)";
          };

          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };

          tray = {
            icon-size = 15;
            spacing = 10;
            show-passive-items = false;
          };

          clock = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y-%m-%d}";
            calendar = {
              mode = "month";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                months = "<span color='#fab387'><b>{}</b></span>";
                days = "<span color='#89b4fa'><b>{}</b></span>";
                weeks = "<span color='#a6e3a1'><b>W{}</b></span>";
                weekdays = "<span color='#f9e2af'><b>{}</b></span>";
                today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
              };
            };
          };

          cpu = {
            format = "{usage}% ";
            tooltip = true;
            states = {
              idle = 0;
              normal = 10;
              warning = 50;
              critical = 90;
            };
          };

          memory = {
            format = "{}% ";
            states = {
              idle = 0;
              normal = 10;
              warning = 50;
              critical = 90;
            };
          };

          temperature = {
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}";
            format-icons = ["" "" ""];
          };

          backlight = {
            format = "{percent}% {icon}";
            format-icons = ["" "" "" "" "" "" "" "" ""];
          };

          battery = {
            bat = "BAT0";
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-full = "{capacity}% {icon}";
            format-charging = "{capacity}% {icon}";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}%";
            tooltip-format-charging = "{timeTo} - {power:>1.0f}W↑ {capacity}%";
            format-icons = {
              charging = [
                "󰢜"
                "󰂆"
                "󰂇"
                "󰂈"
                "󰢝"
                "󰂉"
                "󰢞"
                "󰂊"
                "󰂋"
                "󰂅"
              ];
              default = [
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
              ];
            };
          };

          "power-profiles-daemon" = {
            format = "{icon}";
            tooltip-format = "Power profile: {profile}\nDriver: {driver}";
            tooltip = true;
            format-icons = {
              default = "";
              performance = "";
              balanced = "";
              power-saver = "";
            };
          };

          network = {
            format-wifi = "{essid} ({signalStrength}%)  ";
            format-ethernet = "{ipaddr}/{cidr} 󰀂 ";
            tooltip-format = "{ifname} via {gwaddr} 󰀂 ";
            tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
            tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
            tooltip-format-disconnected = "Disconnected";
            format-linked = "{ifname} (No IP) 󰀂 ";
            format-disconnected = "Disconnected 󰖪 ";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
            interval = 3;
            nospacing = 1;
          };

          pulseaudio = {
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon}  {format_source}";
            format-bluetooth-muted = " {icon}  {format_source}";
            format-muted = " {format_source}";
            format-source = " {volume}% ";
            format-source-muted = "";
            format-icons = {
              headphone = "󰋍 ";
              hands-free = "󰋍 ";
              headset = "󰋍 ";
              phone = "";
              portable = "";
              car = "";
              default = [" " " " " "];
            };
            on-click = "pavucontrol";
          };

          "custom/media" = {
            format = "{icon} {}";
            return-type = "json";
            max-length = 40;
            format-icons = {
              spotify = "";
              default = "🎜";
            };
            escape = true;
            exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
          };

          bluetooth = {
            format = " {status}";
            format-disabled = "󰂲";
            format-connected = " [{num_connections}] {device_alias} [{device_battery_percentage}%]";
            tooltip-format = "{controller_alias}\t{controller_address}\t{device_battery_percentage}";
            tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}\t{device_address} [{device_battery_percentage}]";
            on-click = "blueman-manager";
          };

          "sway/language" = {
            format = "  {short} {variant}";
            on-click = "swaymsg input type:keyboard xkb_switch_layout next";
            tooltip = true;
            tooltip-format = "  {long} {variant}";
          };

          "custom/notification" = {
            tooltip = false;
            format = "{icon}";
            format-icons = {
              notification = " ";
              none = " ";
              dnd-notification = " ";
              dnd-none = " ";
              inhibited-notification = "<span foreground='red'><sup></sup></span>";
              inhibited-none = " ";
              dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
              dnd-inhibited-none = " ";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "swaync-client -t -sw";
            on-click-right = "swaync-client -d -sw";
            escape = true;
          };
        };
      };
    };
  };

  services = {
    mako = {
      enable = true;
      settings = {
        default-timeout = 10000;
        background-color = "${colors.greyLighter}";
        border-color = "${colors.orange}";
      };
    };

    # TODO
    # swayidle = {
    #   enable = true;
    #   timeouts = [
    #     {
    #       timeout = 60;
    #       command = "notify-desktop 'IDLE' 'I am going to sleep in 60s'";
    #     }
    #     {
    #       timeout = 115;
    #       command = "notify-desktop -t 5000 'IDLE' 'I am going to sleep in 5s'";
    #     }
    #     {
    #       timeout = 120;
    #       command = "swaylock -fF -c '#000100'";
    #     }
    #   ];
    # };
  };
}
# TODO : https://www.reddit.com/r/swaywm/comments/gd7976/swayidle_in_lock_script_can_i_temporarily_disable/

