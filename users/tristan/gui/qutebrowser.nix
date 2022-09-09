{...}: {
  # TODO : add binding for spawn mpv (voir man home-config)
  programs.qutebrowser = {
    enable = true;

    quickmarks = {
      nixpkgs = "https://github.com/NixOS/nixpkgs";
      home-manager = "https://github.com/nix-community/home-manager";
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

    extraConfig = ''
      config.set('content.images', True, 'chrome-devtools://*')
      config.set('content.images', True, 'devtools://*')

      config.set('content.javascript.enabled', True, 'chrome-devtools://*')
      config.set('content.javascript.enabled', True, 'devtools://*')
      config.set('content.javascript.enabled', True, 'chrome://*/*')
      config.set('content.javascript.enabled', True, 'qute://*/*')
      config.set('content.javascript.enabled', True, '*://localhost:*')
      config.set('content.javascript.enabled', True, 'https://*.twitter.com/*')
      config.set('content.javascript.enabled', True, 'https://*.duckduckgo.com/*')
      config.set('content.javascript.enabled', True, 'https://*.youtube.com/*')
      config.set('content.javascript.enabled', True, 'https://*.linkedin.com/*')
      config.set('content.javascript.enabled', True, 'https://*.deezer.com/*')
      config.set('content.javascript.enabled', True, 'https://*.ifixit.com/*')
      config.set('content.javascript.enabled', True, 'https://*.caisse-epargne.fr/*')
      config.set('content.javascript.enabled', True, 'https://*.github.com/*')
      config.set('content.javascript.enabled', True, 'https://*.reddit.com/*')
      config.set('content.javascript.enabled', True, 'https://*.root-me.org/*')
      config.set('content.javascript.enabled', True, 'https://progressbarserver.appspot.com/')
    '';

    settings.content.javascript.enabled = false;
  };
}
