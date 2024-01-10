{ config, pkgs, ... }:

{

      home.username = "total";
      home.homeDirectory = "/home/total";
      home.stateVersion = "24.05";

      imports = [



    ];

    home.packages = with pkgs; [
      brave
      alacritty
      blender
      freecad
      rofi-wayland
    ];

    # Manage dotfiles
    home.file = {
      #".config/hyprland/hyprland.conf".source = ./hyprland.conf;
    };

    # Manage Environment variables
    home.sessionVariables = {
      Editor = "vim";
    };

    # Bash
    programs.bash = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        ".." = "cd ..";
      };        
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Theming for Hyprland

    home.pointerCursor = {
      gtk.enable = true;
      # x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    gtk = {
      enable = true;
      theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
};


}
