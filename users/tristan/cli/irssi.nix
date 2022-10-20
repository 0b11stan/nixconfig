{...}: {
  # TODO : add notifications for irssi ? (via perl script ?)
  programs.irssi = {
    enable = true;
    networks = {
      oftc = {
        nick = "Ob11stan";
        server = {
          address = "irc.oftc.net";
          port = 6697;
          autoConnect = true;
        };
        channels = {
          home-manager.autoJoin = true;
        };
      };
    };
  };
}
