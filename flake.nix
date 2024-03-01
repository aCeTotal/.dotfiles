{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
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

       nix-gaming.url = "github:fufexan/nix-gaming";
    };

    outputs = inputs@{ self, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, ... }:
        let
            lib = nixpkgs.lib;
            system = "x86_64-linux";
            allowUnfree = { nixpkgs.config.allowUnfree = true; };
            pkgs = nixpkgs.legacyPackages.${system};
            pkgs-stable = nixpkgs-stable.legacyPackages.${system};
        in  {
        nixosConfigurations = {
	    # NVIDIA DESKTOP
            desktop = lib.nixosSystem {
              specialArgs = { inherit inputs; inherit system; inherit pkgs-stable; };
                modules = [ ./hosts/desktop/configuration.nix
                allowUnfree
                home-manager.nixosModules.home-manager {
                    home-manager = {
                      extraSpecialArgs = { inherit inputs; };
	    			          useGlobalPkgs = true;
            			    useUserPackages = true;
            			    backupFileExtension = "backup";
	    			          users.total = import ./hosts/desktop/home.nix;
                    };
	    	      	}
		          ];
            };

	    # LENOVO THINKPAD T480
	    t480 = lib.nixosSystem {
              specialArgs = { inherit inputs; inherit system; inherit pkgs-stable; };
                modules = [ ./hosts/t480/configuration.nix 
                home-manager.nixosModules.home-manager {
                    home-manager = {
                        extraSpecialArgs = { inherit inputs; };
	    			            useGlobalPkgs = true;
            			      useUserPackages = true;
            			      backupFileExtension = "backup";
	    			            users.christophermp = import ./hosts/t480/home.nix;
                    };
	    		      }
		              nixos-hardware.nixosModules.lenovo-thinkpad-t480
		              nixos-hardware.nixosModules.common-cpu-intel-kaby-lake
                  nixos-hardware.nixosModules.common-gpu-intel
		            ];
              };

        # MSI GS66 Stealth 10UE
	      gs66 = lib.nixosSystem {
                specialArgs = { inherit inputs; inherit system; inherit pkgs-stable; };
                  modules = [ ./hosts/gs66/configuration.nix 
                  home-manager.nixosModules.home-manager {
                    home-manager = {
                        extraSpecialArgs = { inherit inputs; };
	    			            useGlobalPkgs = true;
            			      useUserPackages = true;
            			      backupFileExtension = "backup";
	    			            users.total = import ./hosts/gs66/home.nix;
                    };
	    		      }
		              nixos-hardware.nixosModules.common-cpu-intel-cpu-only
                  nixos-hardware.nixosModules.common-gpu-intel
		            ];
              };


   	 };

      };
}

