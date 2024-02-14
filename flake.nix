{
    description = "aCeTotal's FLAKE";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        hyprland.url = "github:hyprwm/Hyprland";

        nixvim = {
          url = "github:nix-community/nixvim";
          inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, home-manager, ... }:
        let
            lib = nixpkgs.lib;
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in  {
        nixosConfigurations = {
            desktop = lib.nixosSystem {
              inherit system;
              specialArgs = {inherit inputs;}
                modules = [ ./system/desktop/configuration.nix 
			        home-manager.nixosModules.home-manager {
	    	            home-manager.useGlobalPkgs = true;
            	        home-manager.useUserPackages = true;
            	        home-manager.backupFileExtension = "backup";
	    		        home-manager.users.total = import ./system/desktop/home.nix;
	    	        }
		        ];
            };
   	    };
      };
}
