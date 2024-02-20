{ config, pkgs, inputs, lib, ... }:

{

    imports = 
    [

      #programs
      ./modules/programs/git.nix
      ./modules/programs/bash.nix
     # ./modules/programs/nixvim.nix

      # Theming
      ./modules/theming/cursor_icons.nix

      # Config
      ./modules/config/hyprland/hyprland_config.nix
      ./modules/config/alacritty/alacritty_config.nix
      ./modules/config/waybar/waybar_config.nix
      #./modules/config/citrix/citrix-conf.nix
      

    ];

    home.username = "christophermp";
    home.homeDirectory = "/home/christophermp";
    home.stateVersion = "24.05";

    home.packages = with pkgs; [
      brave
      spotify
      blender
      firefox
      slurp
      grim
      swappy
      pamixer

     #Work (Testing)
     wpsoffice
     libreoffice-fresh
     planner
     todoist
     projectlibre
     teams-for-linux
    ];

    services.ssh-agent.enable = true;

    # Manage dotfiles
    home.file = {
      #".config/hyprland/hyprland.conf".source = ./hyprland.conf;
    };

    # Manage Environment variables
    home.sessionVariables = {
      Editor = "vim";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

}
