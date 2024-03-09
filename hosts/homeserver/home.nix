{ config, pkgs, inputs, lib, ... }:

{

    imports = 
    [

      #programs
      ./modules/git.nix
      ./modules/bash.nix
      ./modules/nixvim.nix
    ];

    home = {
    username = "total";
    homeDirectory = "/home/total";
    stateVersion = "24.05";
    };

    home.packages = with pkgs; [

    ];

    services.ssh-agent.enable = true;

    # Manage Environment variables
    home.sessionVariables = {
      Editor = "vim";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

}
