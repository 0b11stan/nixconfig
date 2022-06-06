{
  description = "0b11stan's nixos configuration files.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      homeManagerConfigurations = {
        tristan = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          stateVersion = "22.05";
          username = "tristan";
          homeDirectory = "/home/tristan";
          configuration = {
            imports = [
              ./users/tristan/home.nix
            ];
          };
        };
      };

      nixosConfigurations = {
        master = lib.nixosSystem {
          inherit system;
          modules = [
            ./system/configuration.nix
          ];
        };
      };
    };
}
