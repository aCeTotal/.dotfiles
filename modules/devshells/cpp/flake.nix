{
  description = "C++ development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };
    in pkgs.mkShell {
      # create an environment with nodejs_18, pnpm, and yarn
      packages = with pkgs; [
          SDL2
          SDL2_image
          SDL2_ttf
          SDL2_net
          SDL2_gfx
          SDL2_Pango
          SDL2_sound
          SDL2_mixer
          nushell
      ];

      shellHook = ''
      '';
    };
  };
}
