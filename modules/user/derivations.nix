{ pkgs, ... }:

let
  pureref = import ../derivations/pureref/default.nix { inherit pkgs; };
  #uvtools = import ../derivations/uvtools/default.nix { inherit pkgs; };
in
{

    home.packages = [
    pureref
    #uvtools
    ];
}
