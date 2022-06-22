{
  config,
  pkgs,
  lib,
  ...
}: let
  mod = config.wayland.windowManager.sway.config.modifier;
in {
  fonts.fontconfig.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config = {
      # pour voir la config exacte appliquée
      # $ home-manager option wayland.windowManager.sway.config | less

      input = {
        "type:keyboard" = {
          xkb_layout = "fr";
        };
      };

      left = "j";
      down = "k";
      up = "l";
      right = "m";

      terminal = "alacritty";
      menu = "bemenu";

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

      startup = [
        {command = "tutanota-desktop";}
        {command = "signal-desktop";}
        {command = "qutebrowser";}
      ];

      keybindings = lib.mkOptionDefault {
        "${mod}+space" = "floating toggle";

        "${mod}+h" = "splith";
        "${mod}+v" = "splitv";

        "${mod}+d" = "exec bemenu-run -m 1 -p '>' --fn 'monospace 10' -H 18";

        "${mod}+ampersand" = "workspace 1; layout stacking";
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

      bars = [
        {
          colors = {
            activeWorkspace = {
              background = "#5f676a";
              border = "#333333";
              text = "#ffffff";
            };
            background = "#000000";
            bindingMode = {
              background = "#900000";
              border = "#2f343a";
              text = "#ffffff";
            };
            focusedBackground = null;
            focusedSeparator = null;
            focusedStatusline = null;
            focusedWorkspace = {
              background = "#285577";
              border = "#4c7899";
              text = "#ffffff";
            };
            inactiveWorkspace = {
              background = "#222222";
              border = "#333333";
              text = "#888888";
            };
            separator = "#666666";
            statusline = "#ffffff";
            urgentWorkspace = {
              background = "#900000";
              border = "#2f343a";
              text = "#ffffff";
            };
          };
          command = "${pkgs.sway}/bin/swaybar";
          extraConfig = "";
          fonts = {
            names = ["monospace"];
            size = 8.0;
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
