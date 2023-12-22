{
  description = "NixOS configuration of Dennis";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    c3d2-user-module = {
      url = "git+https://gitea.c3d2.de/C3D2/nix-user-module.git";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, c3d2-user-module, nix-index-database, sops-nix, ... }: {
    nixosConfigurations = {
      DennisLaptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system/laptop/configuration.nix
          nix-index-database.nixosModules.nix-index
          c3d2-user-module.nixosModule
        ];
      };

      DennisMain = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system/main/configuration.nix
          nix-index-database.nixosModules.nix-index
        ];
      };
    };
  };
}
