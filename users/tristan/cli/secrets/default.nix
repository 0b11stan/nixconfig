{pkgs, ...}: {
  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ./pubkey.gpg;
        trust = 5;
      }
    ];
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "curses";
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass-wayland;
    settings = {
      PASSWORD_STORE_KEY = "3CCAC5814F45FAD8";
      PASSWORD_STORE_CLIP_TIME = "60";
    };
  };
}
