{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        hyprland.url = "github:hyprwm/Hyprland";

        hyprland-plugins = {
            url = "github:hyprwm/hyprland-plugins";
            inputs.hyprland.follows = "hyprland";
        };

        hyprland-contrib = {
            url = "github:hyprwm/contrib";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        #Locked nixvim to a specific commit to avoid making changes every time nixvim changes something. 
        nixvim = {
            url = "github:nix-community/nixvim/33097dc";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        argonpkgs = {
            url = "github:aCeTotal/argonpkgs";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };

    outputs = inputs@{ self, nixpkgs, nixpkgs-stable, argonpkgs, nixos-hardware, home-manager, ... }:
        let
            system = "x86_64-linux";
        in {
        nixosConfigurations = {
                # ──── NVIDIA DESKTOP ────────────────────────────────────────────────────────────────────────────────
                desktop = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs system; };
                    modules = [
                        ./hosts/desktop/configuration.nix
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

                # ──── HTPC ────────────────────────────────────────────────────────────────────────────────────────
                htpc = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs system; };
                    modules = [
                        ./hosts/htpc/configuration.nix
                        home-manager.nixosModules.home-manager {
                            home-manager = {
                                extraSpecialArgs = { inherit inputs; };
                                useGlobalPkgs = true;
                                useUserPackages = true;
                                backupFileExtension = "backup";
                                users.total = import ./hosts/htpc/home.nix;
                            };
                        }
                    ];
                };

                # ──── LENOVO THINKPAD T480 ────────────────────────────────────────────────────────────────────────
                t480 = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs system; };
                    modules = [
                        ./hosts/t480/configuration.nix 
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

                # ──── MSI GS66 Stealth 10UE ────────────────────────────────────────────────────────────────────────
                gs66 = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs system; };
                    modules = [
                        ./hosts/gs66/configuration.nix 
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

                # ──── X11 VM ────────────────────────────────────────────────────────────────────────────────────────
                x11vm = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs system; };
                    modules = [
                        ./hosts/x11vm/configuration.nix
                        home-manager.nixosModules.home-manager {
                            home-manager = {
                                extraSpecialArgs = { inherit inputs; };
                                useGlobalPkgs = true;
                                useUserPackages = true;
                                backupFileExtension = "backup";
                                users.total = import ./hosts/x11vm/home.nix;
                            };
                        }
                    ];
                };

                # ──── HomeServer with stable packages ────────────────────────────────────────────────────────────────
                homeserver = nixpkgs-stable.lib.nixosSystem {
                    specialArgs = { inherit inputs system; };
                    modules = [
                        ./hosts/homeserver/configuration.nix
                        { nixpkgs.pkgs = nixpkgs-stable.legacyPackages.${system}; } # 🔹 Bruker nixpkgs-stable riktig
                        home-manager.nixosModules.home-manager {
                            home-manager = {
                                extraSpecialArgs = { inherit inputs; };
                                useGlobalPkgs = true;
                                useUserPackages = true;
                                backupFileExtension = "backup";
                                users.total = import ./hosts/homeserver/home.nix;
                            };
                        }
                    ];
                };
            };

        };        
}

