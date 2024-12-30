{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    ];

    #services.lorri.enable = true;
    programs.direnv.enable = true;

}
