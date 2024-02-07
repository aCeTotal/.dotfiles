{ config, pkgs, inputs, lib, ... }:

{

    imports = 
    [

      #programs
      ./modules/programs/git.nix
      ./modules/programs/bash.nix

      # Theming
      ./modules/theming/cursor_icons.nix

      # Config
      ./modules/config/hyprland/hyprland_config.nix
      ./modules/config/alacritty/alacritty_config.nix
      ./modules/config/waybar/waybar_config.nix

      #Flake modules
      nixvim.homeManagerModules.nixvim
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
      slurp
      grim
      swappy
    ];

    programs.nixvim = {
    	plugins.lightline.enable = true;
	colorschemes.gruvbox.enable = true;
    };


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
