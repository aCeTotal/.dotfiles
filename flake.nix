{
    description = "TotalOS";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
	hyprland.url = "github:hyprwm/Hyprland";
    	hyprland-plugins = {
      		url = "github:hyprwm/hyprland-plugins";
      		inputs.hyprland.follows = "hyprland";
    	};

	# Neovim Theme	
	plugin-onedark.url = "github:navarasu/onedark.nvim";
	plugin-onedark.flake = false;
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
