{
    description = "My Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

    };

    outputs = { self, nixpkgs, home-manager, ... }:
        let
            lib = nixpkgs.lib;
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in  {
        nixosConfigurations = {
            desktop = nixpkgs.lib.nixosSystem {
                inherit system;
		modules = [
			./system/desktop/configuration.nix
		];
            };

        homeConfigurations = {
            total = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
			 ./users/total/home.nix
		 ];
            };
        };
     };

   };

}
