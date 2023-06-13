{
  description = "NixOS configuration of Dennis";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    c3d2-user-module.url = "git+https://gitea.c3d2.de/C3D2/nix-user-module.git";
  };

  outputs = { nixpkgs, c3d2-user-module, ... }: {
    nixosConfigurations = {
      DennisLaptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system/configuration_laptop.nix
          c3d2-user-module.nixosModule
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

