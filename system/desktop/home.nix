{ config, pkgs, inputs, lib, ... }:

{

    imports = 
    [

      #programs
      ./users/modules/programs/git.nix
      ./users/modules/programs/bash.nix

      # Theming
      ./users/modules/theming/cursor_icons.nix

      # Config
      ./users/modules/config/hyprland/hyprland_config.nix
      ./users/modules/config/alacritty/alacritty_config.nix
      ./users/modules/config/waybar/waybar_config.nix
    ];


    home.username = "total";
    home.homeDirectory = "/home/total";
    home.stateVersion = "24.05";

    home.packages = with pkgs; [
      brave
      floorp
      blender
      vscodium
      firefox
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
