# TODO : add binding for spawn mpv (voir man home-config)
{
  enable = true;

  # TODO : autogrenerate quickmarks and extraConfig
  quickmarks = {
    search = https://search.nixos.org/packages;
    nixpkgs = https://github.com/NixOS/nixpkgs;
    home-manager = https://github.com/nix-community/home-manager;
    twitter = https://twitter.com;
    duckduckgo = https://duckduckgo.com;
    youtube = https://youtube.com;
    linkedin = https://linkedin.com;
    deezer = https://deezer.com;
    ifixit = https://ifixit.com;
    caisse-epargne = https://www.caisse-epargne.fr;
    github = https://github.com;
    reddit = https://reddit.com;
    root-me = https://root-me.org;
    gitlab = https://gitlab.com;
    git = https://git.tic.sh;
    leboncoin = https://www.leboncoin.fr;
    teams = https://teams.microsoft.com/;
    outlook = https://outlook.office365.com/mail/;
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
    config.set('content.javascript.enabled', True, 'https://*.nixos.org/*')
    config.set('content.javascript.enabled', True, 'https://*.gitlab.com/*')
    config.set('content.javascript.enabled', True, 'https://*.tic.sh/*')
    config.set('content.javascript.enabled', True, 'https://*.leboncoin.fr/*')
    config.set('content.javascript.enabled', True, 'https://*.offsec.com/*')
    config.set('content.javascript.enabled', True, 'https://teams.microsoft.com/*')
    config.set('content.javascript.enabled', True, 'https://outlook.office365.com/*')
    config.set('content.javascript.enabled', True, 'https://tasks.office.com/*')
    config.set('content.javascript.enabled', True, 'https://progressbarserver.appspot.com/')
  '';

  settings.content.javascript.enabled = false;
}
