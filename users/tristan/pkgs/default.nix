self: super: let
in {
  # TODO mdfmt
  # TODO bloodhound
  # TODO exegol
  windapsearch = super.callPackage ./windapsearch.nix {};
  kerbrute = super.callPackage ./kerbrute.nix {};
  burpsuite = super.callPackage ./burpsuitepro.nix {};
  seclists = super.callPackage ./seclists.nix {};
}
# note : tests packages with
# nix-build -E '(import <nixpkgs> {}).callPackage ./mypackage.nix {}'

