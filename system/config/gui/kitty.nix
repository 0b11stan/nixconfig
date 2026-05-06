{
  enable = true;
  themeFile = "Catppuccin-Macchiato";
  # TODO : https://sw.kovidgoyal.net/kitty/overview/#the-scrollback-buffer
  # TODO : add missing https://github.com/mikesmithgh/kitty-scrollback.nvim

  shellIntegration.enableBashIntegration = true;
  # Here to enable kitty-scrollback.
  # see https://github.com/mikesmithgh/kitty-scrollback.nvim
  extraConfig = ''
    font_size   12
    font_family Hack
    allow_remote_control socket-only
    listen_on unix:/tmp/kitty
    kitten_alias scrollback_pager nvim --headless +'KittyScrollbackGenerateKittens'
    action_alias kitty_scrollback_nvim kitten '/home/tristan/.local/share/nvim/site/pack/hm/start/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py'
    map kitty_mod+h kitty_scrollback_nvim
    map kitty_mod+g kitty_scrollback_nvim --config ksb_builtin_last_cmd_output
    mouse_map ctrl+shift+right press ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output
  '';
}
