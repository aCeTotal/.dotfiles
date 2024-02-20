{
    description = "TotalOS";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
	hyprland.url = "github:hyprwm/Hyprland";
    	hyprland-plugins = {
      		url = "github:hyprwm/hyprland-plugins";
      		inputs.hyprland.follows = "hyprland";
          };

        nixvim = {
          	url = "github:nix-community/nixvim";
          	inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, nixos-hardware, home-manager, ... }:
        let
            lib = nixpkgs.lib;
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in  {
        nixosConfigurations = {
	    # NVIDIA DESKTOP
            desktop = lib.nixosSystem {
              specialArgs = {inherit inputs; inherit system;};
                modules = [ ./system/desktop/configuration.nix 
                home-manager.nixosModules.home-manager {
                    home-manager.extraSpecialArgs = {
                      inherit inputs;
                    };
	    			home-manager.useGlobalPkgs = true;
            			home-manager.useUserPackages = true;
            			home-manager.backupFileExtension = "backup";
	    			home-manager.users.total = import ./system/desktop/home.nix;
	    		}
		];
            };

	    # LENOVO THINKPAD T480
	    t480 = lib.nixosSystem {
              specialArgs = {inherit inputs; inherit system;};
                modules = [ ./system/t480/configuration.nix 
                home-manager.nixosModules.home-manager {
                    home-manager.extraSpecialArgs = {
                      inherit inputs;
                    };
	    			home-manager.useGlobalPkgs = true;
            			home-manager.useUserPackages = true;
            			home-manager.backupFileExtension = "backup";
	    			home-manager.users.christophermp = import ./system/t480/home.nix;
	    		}
		    nixos-hardware.nixosModules.lenovo-thinkpad-t480
		    nixos-hardware.nixosModules.common-cpu-intel-kaby-lake
                    nixos-hardware.nixosModules.common-gpu-intel
		];
            };


   	 };

      };
}

