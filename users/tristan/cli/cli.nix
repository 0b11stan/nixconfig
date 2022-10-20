{pkgs, ...}: let
  offsecToolboxes = builtins.fetchGit {
    url = "https://github.com/0b11stan/offsec-toolboxes.git";
    ref = "main";
  };
in {
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
    rdfind
    rar

    # apps
    transmission
    virt-manager

    # formaters / linters
    jq
    htmlq
    alejandra

    # source / build tool
    python39
    gcc
    gnumake
    just
    pandoc
  ];

  home.shellAliases = {
    # TODO : move into offsec.nix
    ip = "ip --color --brief";
    watch = "watch --color";
    tree = "tree -C";
    archlinux = "podman run -it --network=host -v $PWD:/srv docker.io/archlinux bash";
    debian = "podman run -it --network=host -v $PWD:/srv docker.io/debian bash";
    search = "grep --exclude-dir=.git -ri";
    virsh = "sudo virsh";
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

  programs.bash = {
    enable = true;
    bashrcExtra = builtins.readFile "${offsecToolboxes}/offsec-toolboxes.sh";
  };
}
