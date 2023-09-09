self: super: let
in {
  # TODO mdfmt
  # TODO bloodhound
  windapsearch = super.callPackage ./windapsearch.nix {};
  kerbrute = super.callPackage ./kerbrute.nix {};
  burpsuite = super.callPackage ./burpsuitepro.nix {};
  seclists = super.callPackage ./seclists.nix {};
  exegol = super.callPackage ./exegol.nix {};
  #test = super.callPackage ./test.nix {};
}
# note : tests packages with
# nix-build -E '(import <nixpkgs> {}).callPackage ./mypackage.nix {}'

