{...}: {
  # TODO : add binding for spawn mpv (voir man home-config)
  programs.qutebrowser = {
    enable = true;

    quickmarks = {
      nixpkgs = "https://github.com/NixOS/nixpkgs";
      home-manager = "https://github.com/nix-community/home-manager";
    };

    searchEngines = {
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://nixos.wiki/index.php?search={}";
    };

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

    settings.content.javascript.enabled = false;
  };
}
