{ pkgs, ... }:

let
    #pureref = import ../derivations/pureref/default.nix { inherit pkgs; };
    uvtools = import ../derivations/uvtools/default.nix { inherit pkgs; };
    #o3de = import ../derivations/o3de/default.nix { inherit pkgs; };
    #speedtree = import ../derivations/speedtree/default.nix { inherit pkgs; };
    nixtile = pkgs.callPackage ../derivations/nixtile/package.nix {};


in
    {

    home.packages = [
        #pureref
        uvtools
        #o3de
        #speedtree
        nixtile
    ];
}
