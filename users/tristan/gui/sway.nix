{
  config,
  pkgs,
  lib,
  ...
}: let
  mod = config.wayland.windowManager.sway.config.modifier;
  cRed = "#d09a9a";
  cFocused = "#c41658";
  cWhite = "#ffffff";
  cGreyLight = "#777777";
  cGrey = "#555555";
  cGreyDark = "#333333";
  cBlack = "#111111";
in {
  fonts.fontconfig.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config = {
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

      colors.focused = {
        background = "${cFocused}";
        border = "${cFocused}";
        childBorder = "${cFocused}";
        indicator = "${cFocused}";
        text = "${cWhite}";
      };

      colors.focusedInactive = {
        background = "${cGreyDark}";
        border = "${cGreyDark}";
        childBorder = "${cGreyDark}";
        indicator = "${cGreyDark}";
        text = "${cGreyLight}";
      };

      colors.unfocused = {
        background = "${cGreyDark}";
        border = "${cGreyDark}";
        childBorder = "${cGreyDark}";
        indicator = "${cGreyDark}";
        text = "${cGreyLight}";
      };

      bars = [
        {
          colors = {
            activeWorkspace = {
              background = "${cGreyLight}";
              border = "${cGreyLight}";
              text = "${cWhite}";
            };

            inactiveWorkspace = {
              background = "${cGreyDark}";
              border = "${cGreyDark}";
              text = "${cGreyLight}";
            };

            focusedWorkspace = {
              background = "${cFocused}";
              border = "${cFocused}";
              text = "${cWhite}";
            };

            bindingMode = {
              background = "${cRed}";
              border = "${cGrey}";
              text = "${cWhite}";
            };

            urgentWorkspace = {
              background = "${cRed}";
              border = "${cGrey}";
              text = "${cWhite}";
            };

            background = "${cBlack}";
            focusedBackground = null;
            focusedSeparator = null;
            focusedStatusline = null;
            separator = "${cGreyLight}";
            statusline = "${cWhite}";
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
