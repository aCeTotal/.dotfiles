{
    description = "My flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs, ... }:
        let
            lib = nixpkgs.lib;
        in  {
        nixosConfigurations = {
            desktop-office = lib.nixosSystem {
                system = "x86_64-linux";
                modules = [ ./configuration.nix ];
            };
        };
    };

}