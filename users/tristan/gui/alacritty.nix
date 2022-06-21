{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      live_config_reload = true;
      key_bindings = [
        {
          key = "L";
          mode = "Vi|~Search";
          action = "Up";
        }
        {
          key = "K";
          mode = "Vi|~Search";
          action = "Down";
        }
        {
          key = "J";
          mode = "Vi|~Search";
          action = "Left";
        }
        {
          key = "M";
          mode = "Vi|~Search";
          action = "Right";
        }
      ];
    };
  };
}
