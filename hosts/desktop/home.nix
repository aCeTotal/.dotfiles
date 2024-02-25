{ config, pkgs, inputs, lib, ... }:

{

    imports = 
    [

      #programs
      ./modules/git.nix
      ./modules/bash.nix
      ./modules/nixvim/nixvim.nix
      ./modules/alacritty.nix
      ./modules/rofi.nix

      ./modules/cursor_icons.nix

      ./modules/hyprland.nix
      ./modules/waybar.nix
      

    ];

    home.username = "total";
    home.homeDirectory = "/home/total";
    home.stateVersion = "24.05";

    home.packages = with pkgs; [
      brave
      spotify
      blender
      firefox
      slurp
      grim
      swappy
      pureref
      notepadqq
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
