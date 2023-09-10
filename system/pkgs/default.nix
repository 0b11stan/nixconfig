self: super: let
  pkgsUnstable = import <nixpkgs-unstable> {};
in {
  windapsearch = super.callPackage ./windapsearch.nix {};
  kerbrute = super.callPackage ./kerbrute.nix {};
  burpsuite = super.callPackage ./burpsuitepro.nix {};
  seclists = super.callPackage ./seclists.nix {};
  exegol = super.callPackage ./exegol.nix {
    pkgs = pkgsUnstable;
  };
}
