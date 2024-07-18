{ pkgs, ... }:

let
  chitubox-basic = import ../derivations/chitubox/default.nix { inherit pkgs; };
in
{

    home.packages = [
      chitubox-basic
    ];
}
