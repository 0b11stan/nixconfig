self: super: let
  nixpkgs = ((import <nixpkgs>) {}).fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "master";
    sha256 = "sha256-MiGg5skTOc0a6Acp5tahoZCR1ymhP4zSLRv/fOxh9hY=";
  };
in {
  discord = super.callPackage "${nixpkgs}/pkgs/applications/networking/instant-messengers/discord/default.nix" {};
  mdfmt = super.callPackage ./mdfmt.nix {}; # TODO : fix this package
  bloodhound = super.callPackage ./bloodhound/default.nix {}; # TODO : fix this package
  windapsearch = super.callPackage ./windapsearch.nix {};
  kerbrute = super.callPackage ./kerbrute.nix {};
}
# note : tests packages with
# nix-build -E '(import <nixpkgs> {}).callPackage ./mypackage.nix {}'

