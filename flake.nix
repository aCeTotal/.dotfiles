{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11"; # Stabil versjon for homeserver
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/master";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      
      # Standard nixpkgs for alle unntatt homeserver
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};

      baseModules = name: [
        ./hosts/${name}/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager = {
            extraSpecialArgs = { inherit inputs; };
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.total = import ./hosts/${name}/home.nix;
          };
        }
      ];
      
    in {
      nixosConfigurations = {
        desktop = lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = baseModules "desktop";
        };

        htpc = lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = baseModules "htpc";
        };

        t480 = lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = baseModules "t480" ++ [
            nixos-hardware.nixosModules.lenovo-thinkpad-t480
            nixos-hardware.nixosModules.common-cpu-intel-kaby-lake
            nixos-hardware.nixosModules.common-gpu-intel
          ];
        };

        gs66 = lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = baseModules "gs66" ++ [
            nixos-hardware.nixosModules.common-cpu-intel-cpu-only
            nixos-hardware.nixosModules.common-gpu-intel
          ];
        };

        x11vm = lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = baseModules "x11vm";
        };

        homeserver = lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./hosts/homeserver/configuration.nix
            { nixpkgs.pkgs = pkgs-stable; }  # 🔹 Bruk kun nixpkgs-stable
            { nixpkgs.overlays = []; }
          ];
        };


      };
    };
}

