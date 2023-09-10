self: super: {
  exegol = super.callPackage ./exegol.nix {pkgs = import <nixpkgs-unstable> {};};
}
