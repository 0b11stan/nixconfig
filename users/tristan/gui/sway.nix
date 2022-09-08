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
  ];

  fonts.fontconfig.enable = true;

  programs.mako = {
    enable = true;
    defaultTimeout = 10000;
  };

  services.swayidle = {
    enable = !isDesktop;
    timeouts = [
      {
        timeout = 30;
        command = "notify-desktop 'IDLE' 'I am going to sleep in 30s'";
      }
      {
        timeout = 50;
        command = "notify-desktop 'IDLE' 'I am going to sleep in 10s'";
      }
      {
        timeout = 55;
        command = "notify-desktop -t 5000 'IDLE' 'I am going to sleep in 5s'";
      }
      {
        timeout = 60;
        command = "swaylock -fF -c '#000100'";
      }
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    config = {
      input = {
        "type:keyboard" = {
          xkb_layout = "fr";
        };
        "type:touchpad" = {
          tap = "enabled";
        };
      };

      left = "j";
      down = "k";
      up = "l";
      right = "m";

      terminal = "alacritty";
      menu = "bemenu";

      window.hideEdgeBorders = "both";
      gaps.smartBorders = "on";

      workspaceOutputAssign = [
        {
          output = "DP-1";
          workspace = "1";
        }
        {
          output = "DP-2";
          workspace = "5";
        }
        {
          output = "HDMI-A-1";
          workspace = "10";
        }
      ];

      assigns = {
        "1" = [{window_role = "browser-window";}];
        "10" = [{app_id = "org.qutebrowser.qutebrowser";}];
      };

      startup =
        if isDesktop
        then [
          {command = "tutanota-desktop";}
          {command = "signal-desktop";}
          {command = "qutebrowser";}
        ]
        else [];

      keybindings = lib.mkOptionDefault {
        "${mod}+space" = "floating toggle";

        "${mod}+h" = "splith";
        "${mod}+v" = "splitv";

        "${mod}+d" = ''
          exec bemenu-run -m 1 -p '>' --fn 'monospace 10' -H 21 \
            --tb '${colors.black}' --fb '${colors.black}' \
            --nb '${colors.black}' --hb '${colors.black}' \
            --tf '${colors.magenta}' --hf '${colors.magenta}' \
            --nf '${colors.white}'
        '';

        "${mod}+Shift+x" = "exec swaylock -c '#000100'";

        "${mod}+ampersand" =
          if isDesktop
          then "workspace 1; layout tabbed"
          else "workspace 1";
        "${mod}+eacute" = "workspace 2";
        "${mod}+quotedbl" = "workspace 3";
        "${mod}+apostrophe" = "workspace 4";
        "${mod}+parenleft" = "workspace 5";
        "${mod}+minus" = "workspace 6";
        "${mod}+egrave" = "workspace 7";
        "${mod}+underscore" = "workspace 8";
        "${mod}+ccedilla" = "workspace 9";
        "${mod}+agrave" = "workspace 10";

        "${mod}+1" = "move to workspace 1";
        "${mod}+2" = "move to workspace 2";
        "${mod}+3" = "move to workspace 3";
        "${mod}+4" = "move to workspace 4";
        "${mod}+5" = "move to workspace 5";
        "${mod}+6" = "move to workspace 6";
        "${mod}+7" = "move to workspace 7";
        "${mod}+8" = "move to workspace 8";
        "${mod}+9" = "move to workspace 9";
        "${mod}+0" = "move to workspace 10";
      };

      colors = {
        background = "${colors.greyLight}";

        focused = {
          background = "${colors.magenta}";
          border = "${colors.magenta}";
          childBorder = "${colors.magenta}";
          indicator = "${colors.magenta}";
          text = "${colors.greyDark}";
        };

        focusedInactive = {
          background = "${colors.greyLight}";
          border = "${colors.greyLight}";
          childBorder = "${colors.greyLight}";
          indicator = "${colors.greyLight}";
          text = "${colors.white}";
        };

        unfocused = {
          background = "${colors.greyDark}";
          border = "${colors.greyDark}";
          childBorder = "${colors.greyDark}";
          indicator = "${colors.greyDark}";
          text = "${colors.greyLight}";
        };

        urgent = {
          background = "${colors.red}";
          border = "${colors.red}";
          childBorder = "${colors.red}";
          indicator = "${colors.red}";
          text = "${colors.greyDark}";
        };
      };

      bars = [
        {
          colors = {
            activeWorkspace = {
              background = "${colors.greyLight}";
              border = "${colors.greyLight}";
              text = "${colors.white}";
            };

            inactiveWorkspace = {
              background = "${colors.greyDark}";
              border = "${colors.greyDark}";
              text = "${colors.greyLight}";
            };

            focusedWorkspace = {
              background = "${colors.magenta}";
              border = "${colors.magenta}";
              text = "${colors.greyDark}";
            };

            bindingMode = {
              background = "${colors.red}";
              border = "${colors.grey}";
              text = "${colors.white}";
            };

            urgentWorkspace = {
              background = "${colors.red}";
              border = "${colors.red}";
              text = "${colors.greyDark}";
            };

            background = "${colors.black}";
            focusedBackground = null;
            focusedSeparator = null;
            focusedStatusline = null;
            separator = "${colors.greyLight}";
            statusline = "${colors.white}";
          };

          command = "${pkgs.sway}/bin/swaybar";

          extraConfig = "";
          fonts = {
            names = ["monospace"];
            size = 9.0;
            style = "";
          };

          hiddenState = "hide";
          id = "bar-0";
          mode = "dock";
          position = "top";
          statusCommand = "i3status";
          trayOutput = "primary";
          workspaceButtons = true;
          workspaceNumbers = true;
        }
      ];
    };
  };
}
# TODO : https://www.reddit.com/r/swaywm/comments/gd7976/swayidle_in_lock_script_can_i_temporarily_disable/

