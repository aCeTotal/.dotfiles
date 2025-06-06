{ pkgs, ... }:

let
    #pureref = import ../derivations/pureref/default.nix { inherit pkgs; };
    uvtools = import ../derivations/uvtools/default.nix { inherit pkgs; };
    #o3de = import ../derivations/o3de/default.nix { inherit pkgs; };
    #speedtree = import ../derivations/speedtree/default.nix { inherit pkgs; };
    argon = pkgs.callPackage ../derivations/argon/default.nix {};


in
    {

    home.packages = [
        #pureref
        uvtools
        #o3de
        #speedtree
        argon
    ];
}
