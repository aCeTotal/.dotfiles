{ pkgs, ... }:

let
  chitubox = import ../derivations/chitubox/default.nix { inherit pkgs; };
  pureref = import ../derivations/pureref/default.nix { inherit pkgs; };

in
{

    home.packages = [
    chitubox
    pureref
    ];
}
