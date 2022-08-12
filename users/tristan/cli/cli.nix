{pkgs, ...}: {
  imports = [
    ./secrets.nix
    ./neovim.nix
    ./git.nix
    ./offsec.nix
  ];

  home.packages = with pkgs; [
    file
    htop
    jq
    htmlq
    alejandra
    python39
    gource
    bat
    bind
    evince
    openvpn
    zip
    unzip
    gcc
    gnumake
    pandoc
  ];

  home.shellAliases = {
    cme = "mkdir -p ~/.cme && podman run -it --rm -v ~/.cme:/root/.cme -v $PWD:/srv -w /srv byt3bl33d3r/crackmapexec";
    ip = "ip --color";
  };

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

  programs.bash.enable = true;
}
