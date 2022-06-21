{ config, pkgs, lib, ... }:
let
  mod = config.wayland.windowManager.sway.config.modifier;
in
{
  home.username = "tristan";
  home.homeDirectory = "/home/tristan";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    nixpkgs-fmt
    hack-font
    file
    tutanota-desktop
    pass
    htop
  ];

  home.keyboard.layout = "fr";

  home.sessionVariables = {
    EDITOR = "nvim";
    WLR_NO_HARDWARE_CURSORS = 1;
  };

  fonts.fontconfig.enable = true;

  programs.alacritty.enable = true;

  # add binding for spawn mpv (voir man home-config)
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

      keybindings = lib.mkOptionDefault {
        "${mod}+x" = "exec swaylock -c '#000100'";

        "${mod}+ampersand" = "workspace 1";
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
            names = [ "monospace" ];
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


  programs.bash.enable = true;

  home.file.".gitconfig".text = ''
    [user]
      email = tristan@tic.sh
      name = Tristan Pinaudeau
    [init]
      defaultBranch = main
    [pull]
      rebase = false
  '';

  programs.neovim = {
    enable = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [ vim-nix nerdtree ];
    extraConfig = ''
      set number
      set expandtab
      set tabstop=2
      set shiftwidth=2
      set colorcolumn=81
      set cursorline

      set nocompatible

      syntax enable
      filetype plugin on

      " Terminal mode configuration
      au TermOpen * set nonumber

      " Autocomment 
      " TODO : make it dependant to language
      vmap " :s/^/#<CR>

      " Use M key to set marks
      noremap M m

      " Remap keys for usage with azerty
      noremap j h
      noremap k j
      noremap l k
      noremap m l

      " Leave terminal mode on escape
      tnoremap <Esc> <C-\><C-n>

      " Move in panels using CTRL
      " (following line is a fix : https://github.com/neovim/neovim/issues/18245)
      noremap <CR> <C-w>l
      noremap <C-l> <C-w>k
      noremap <C-k> <C-w>j
      noremap <C-j> <C-w>h

      " Remove search
      noremap h :nohlsearch<CR>

      " So we can use `:find ...` for fuzzyfind
      set path+=**

      " TODO : link it to the write command!
      command! MakeTags !ctags -R .

      " Highlight cursor line
      hi CursorLine   cterm=NONE ctermbg=238
      hi CursorColumn cterm=NONE ctermbg=238

      " Nixos syntax highlight
      au BufRead,BufNewFile *.nix set filetype=nix
    '';
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
}
