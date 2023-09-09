{
  fetchFromGitHub,
  lib,
  pkgs,
}: let
  version = "4.2.0";
  nodePackages = import ./composition.nix {inherit pkgs;};
in
  nodePackages.package.override {
    src = fetchFromGitHub {
      owner = "BloodHoundAD";
      repo = "BloodHound";
      rev = "${version}";
      sha256 = "sha256-f617KdxmdlLc00+5zhiGvL9jPnquudRClhSbGNgKTL8=";
    };
    #src = fetchFromGitHub (lib.importJSON ./netlify-cli.json);
    bypassCache = true;
    reconstructLock = true;
    # TODO : change maintainer
    #meta.maintainers = with lib.maintainers; [roberth];
  }
# using node2nix to generate packages
# test with :
# nix-build -E '(import <nixpkgs> {}).callPackage bloodhound/default.nix {}'
#{fetchFromGitHub}: let
#  version = "4.2.0";
#  platform = "linux";
#  arch = "x64";
#  filename = "BloodHound-${platform}-${arch}";
#in
#  with (import <nixpkgs> {});
#    derivation {
#      name = "bloodhound-${version}";
#      builder = "${bash}/bin/bash";
#
#      release = fetchFromGitHub {
#        owner = "BloodHoundAD";
#        repo = "BloodHound";
#        rev = "${version}";
#      };
#      args = [./builder.sh];
#      inherit npm;
#
#      system = builtins.currentSystem;
#    }

