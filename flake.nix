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
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};

      # Funksjon for å opprette en NixOS-konfig
      mkNixosConfig = name: extraModules:
        lib.nixosSystem {
          specialArgs = { inherit inputs system; };
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
        desktop = mkNixosConfig "desktop" [];
        htpc = mkNixosConfig "htpc" [];
        t480 = mkNixosConfig "t480" [
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
          nixos-hardware.nixosModules.common-cpu-intel-kaby-lake
          nixos-hardware.nixosModules.common-gpu-intel
        ];
        gs66 = mkNixosConfig "gs66" [
          nixos-hardware.nixosModules.common-cpu-intel-cpu-only
          nixos-hardware.nixosModules.common-gpu-intel
        ];
        x11vm = mkNixosConfig "x11vm" [];

        # HomeServer with Stable-packages
        homeserver = lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            { nixpkgs.config.allowUnfree = true; }  # Sikrer at unfree pakker er tillatt
            ./hosts/homeserver/configuration.nix
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

