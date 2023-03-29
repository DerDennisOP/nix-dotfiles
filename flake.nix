{
  description = "NixOS configuration of Dennis";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=8f40f2f90b9c9032d1b824442cfbbe0dbabd0dbd";
    #home-manager.url = "github:nix-community/home-manager";
    #home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      DennisLaptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system/configuration.nix
          #home-manager.nixosModules.home-manager
          #{
            #home-manager.useGlobalPkgs = true;
            #home-manager.useUserPackages = true;
            #home-manager.users.dennis = import ./users/dennis;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          #}
        ];
      };
    };
  };
}

