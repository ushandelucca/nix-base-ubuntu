{
  description = "Ubuntu Cloud Server Blueprint";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager }:
  let
    system = "x86_64-linux";
  in {
    homeConfigurations.server = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { inherit system; };

      modules = [
        ./home.nix
      ];
    };
  };
}