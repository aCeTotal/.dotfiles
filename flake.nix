{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";  # Brukes for andre hosts
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11"; # 🔹 Må være riktig versjon
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/master";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      pkgs = nixpkgs.legacyPackages.${system}; # Standard nixpkgs
      pkgs-stable = nixpkgs-stable.legacyPackages.${system}; # 🔹 Bruk stable-versjonen

    in {
      nixosConfigurations = {
        homeserver = lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./hosts/homeserver/configuration.nix
            { nixpkgs.pkgs = pkgs-stable; }  # 🔹 Sikrer at nixpkgs-stable brukes
          ];
        };
      };
    };
}

