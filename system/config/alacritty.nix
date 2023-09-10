{colors}: {
  enable = true;
  settings = {
    colors = {
      primary.background = "${colors.black}";
      normal = {
        black = "${colors.black}";
        white = "${colors.white}";
        red = "${colors.red}";
        green = "${colors.green}";
        yellow = "${colors.yellow}";
        blue = "${colors.blue}";
        magenta = "${colors.magenta}";
        cyan = "${colors.cyan}";
      };
    };
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
}
