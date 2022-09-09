{pkgs, ...}: {
  imports = [
    ./secrets.nix
    ./neovim.nix
    ./git.nix
    ./offsec.nix
  ];

  home.packages = with pkgs; [
    # utilitaires
    file
    htop
    bat
    gource
    bind
    zip
    unzip
    openvpn
    exfatprogs
    pciutils
    tree
    nixpkgs-fmt

    # apps
    transmission
    qemu

    # formaters / linters
    jq
    htmlq
    alejandra

    # source / build tool
    python39
    gcc
    gnumake
    pandoc
  ];

  home.shellAliases = {
    # TODO : move into offsec.nix
    cme = "mkdir -p ~/.cme && podman run -it --rm -v ~/.cme:/root/.cme -v $PWD:/srv -w /srv byt3bl33d3r/crackmapexec";
    ip = "ip --color";
    watch = "watch --color";
    tree = "tree -C";
    archlinux = "podman run -it --network=host docker.io/archlinux bash";
    debian = "podman run -it --network=host docker.io/debian bash";
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
