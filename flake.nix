
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-homeserver.url = "github:nixos/nixpkgs/ca026bb2c252f09d13774a9efba30648f71ad0fa";  #Nixpkgs 2024
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, nixpkgs-homeserver, nixos-hardware, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};
      pkgs-homeserver = nixpkgs-homeserver.legacyPackages.${system};  # 🔹 Bruker gammel nixpkgs for homeserver

      mkNixosConfig = name: pkgsOverride: extraModules:
        lib.nixosSystem {
          specialArgs = { inherit inputs system; pkgs = pkgsOverride; };
          modules = [
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
          ] ++ extraModules;
        };

    in {
      nixosConfigurations = {
        desktop = mkNixosConfig "desktop" pkgs [];
        htpc = mkNixosConfig "htpc" pkgs [];
        t480 = mkNixosConfig "t480" pkgs [
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
          nixos-hardware.nixosModules.common-cpu-intel-kaby-lake
          nixos-hardware.nixosModules.common-gpu-intel
        ];
        gs66 = mkNixosConfig "gs66" pkgs [
          nixos-hardware.nixosModules.common-cpu-intel-cpu-only
          nixos-hardware.nixosModules.common-gpu-intel
        ];
        x11vm = mkNixosConfig "x11vm" pkgs [];

        homeserver = mkNixosConfig "homeserver" pkgs-homeserver [];
      };
    };
}
