self: super: {
  mdfmt = super.callPackage ./mdfmt.nix {}; # TODO : fix this package
  bloodhound = super.callPackage ./bloodhound/default.nix {}; # TODO : fix this package
  windapsearch = super.callPackage ./windapsearch.nix {};
  kerbrute = super.callPackage ./kerbrute.nix {};
}
# note : tests packages with
# nix-build -E '(import <nixpkgs> {}).callPackage ./mypackage.nix {}'

