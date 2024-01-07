{ config, pkgs, ... }:

{

      home.username = "total";
      home.homeDirectory = "/home/total";
      home.stateVersion = "24.05";

    home.packages = [

    ];

    # Manage dotfiles
    home.file = {};

    # Manage Environment variables
    home.sessionVariables = {
      # Editor = "Emacs";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

}
