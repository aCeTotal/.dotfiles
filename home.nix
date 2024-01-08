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

    home.language = {
    base = "nb_NO.utf8";
    ctype = "nb_NO.utf8";
    numeric = "nb_NO.utf8";
    time = "nb_NO.utf8";
    collate = "nb_NO.utf8";
    monetary = "nb_NO.utf8";
    messages = "nb_NO.utf8";
    paper = "nb_NO.utf8";
    name = "nb_NO.utf8";
    address = "nb_NO.utf8";
    telephone = "nb_NO.utf8";
    measurement = "nb_NO.utf8";
};

}
