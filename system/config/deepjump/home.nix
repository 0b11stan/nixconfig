{pkgs, ...}: {
  programs.firefox.profiles.deepjump = import ./firefox-deepjump.nix {inherit pkgs;};
}
