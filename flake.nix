{
  description = "NixOS configuration of Dennis";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      DennisLaptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system/configuration_laptop.nix
       ];
      };
      DennisMain = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system/configuration_main.nix
       ];
      };
    };
  };
}

