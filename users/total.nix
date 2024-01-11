{ config, pkgs, ... }:

{

    imports = 
    [
      #programs
      ./modules/programs/git.nix
      ./modules/programs/bash.nix

      # Theming
      ./modules/theming/cursor_icons.nix

      # Config
    ];


    home.username = "total";
    home.homeDirectory = "/home/total";
    home.stateVersion = "24.05";

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

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

}
