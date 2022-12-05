self: super: let
  nixpkgs = ((import <nixpkgs>) {}).fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "30b4b73b1c4112ee453083d35f7a53b939ecd481";
    sha256 = "sha256-gSSa+dTirMp89dmhDAEk5ux/MsD/OSYga0V58O1j3cs=";
  };
in {
  discord = super.callPackage "${nixpkgs}/pkgs/applications/networking/instant-messengers/discord/default.nix" {};
  mdfmt = super.callPackage ./mdfmt.nix {}; # TODO : fix this package
  bloodhound = super.callPackage ./bloodhound/default.nix {}; # TODO : fix this package
  windapsearch = super.callPackage ./windapsearch.nix {};
  kerbrute = super.callPackage ./kerbrute.nix {};
  burpsuite = super.callPackage ./burpsuitepro.nix {};
}
# note : tests packages with
# nix-build -E '(import <nixpkgs> {}).callPackage ./mypackage.nix {}'

