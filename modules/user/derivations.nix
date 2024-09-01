{ pkgs, ... }:

let
  pureref = import ../derivations/pureref/default.nix { inherit pkgs; };

in
{

    home.packages = [
    pureref
    ];
}
