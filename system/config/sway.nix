{
  colors,
  config,
  isDesktop,
  lib,
  pkgs,
}: let
  mod = config.wayland.windowManager.sway.config.modifier;
in {
  enable = true;

  extraSessionCommands = ''
    export SDL_VIDEODRIVER=wayland

    # Firefox wayland
    export MOZ_ENABLE_WAYLAND=1

    # XDG portal related variables (for screen sharing etc)
    export XDG_SESSION_TYPE=wayland
    export XDG_CURRENT_DESKTOP=sway

    # Run QT programs in wayland
    export QT_QPA_PLATFORM=wayland
  '';

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
      "${mod}+Shift+o" = ''
        exec /bin/sh -c ' \
          SCREENPATH=/tmp/$(date +screenshot-%s.png); \
          grim -g \"$(slurp)\" $SCREENPATH && \
          printf $SCREENPATH | wl-copy; \
        '
      '';

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

      "${mod}+plus" = "move scratchpad";
      "${mod}+equal" = "scratchpad show";

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
      "${mod}+Shift+minus" = "move to workspace 6";
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
        background = "${colors.greyDark}";
        border = "${colors.greyDark}";
        childBorder = "${colors.greyDark}";
        indicator = "${colors.greyDark}";
        text = "${colors.magenta}";
      };

      unfocused = {
        background = "${colors.greyDark}";
        border = "${colors.greyDark}";
        childBorder = "${colors.greyDark}";
        indicator = "${colors.greyDark}";
        text = "${colors.magenta}";
      };

      urgent = {
        background = "${colors.orange}";
        border = "${colors.orange}";
        childBorder = "${colors.orange}";
        indicator = "${colors.orange}";
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
            text = "${colors.magenta}";
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
            background = "${colors.orange}";
            border = "${colors.orange}";
            text = "${colors.greyDark}";
          };

          background = "${colors.greyDark}";
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
}
