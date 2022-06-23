{
  config,
  pkgs,
  lib,
  ...
}: let
  mod = config.wayland.windowManager.sway.config.modifier;
  colors = import ./colors.nix;
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
        background = "${colors.magenta}";
        border = "${colors.magenta}";
        childBorder = "${colors.magenta}";
        indicator = "${colors.magenta}";
        text = "${colors.white}";
      };

      colors.focusedInactive = {
        background = "${colors.greyDark}";
        border = "${colors.greyDark}";
        childBorder = "${colors.greyDark}";
        indicator = "${colors.greyDark}";
        text = "${colors.greyLight}";
      };

      colors.unfocused = {
        background = "${colors.greyDark}";
        border = "${colors.greyDark}";
        childBorder = "${colors.greyDark}";
        indicator = "${colors.greyDark}";
        text = "${colors.greyLight}";
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
              border = "${colors.grey}";
              text = "${colors.white}";
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
