{ pkgs, ... }:

let
    #pureref = import ../derivations/pureref/default.nix { inherit pkgs; };
    uvtools = import ../derivations/uvtools/default.nix { inherit pkgs; };
    o3de = import ../derivations/o3de/default.nix { inherit pkgs; };

in
    {

    home.packages = [
        #pureref
        uvtools
        o3de
    ];
}
