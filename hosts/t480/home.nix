{ config, pkgs, inputs, lib, ... }:

{

    imports = 
    [
      ./modules/git.nix
      ./modules/bash.nix
      ./modules/nixvim.nix
      ./modules/cursor_icons.nix
      ./modules/hyprland.nix
      ./modules/alacritty.nix
      ./modules/rofi.nix
      ./modules/waybar.nix
      ./modules/devtools.nix
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
      libreoffice-fresh
      teams-for-linux
    ];

    services.ssh-agent.enable = true;

    # Manage dotfiles
    home.file = {
      #".config/hyprland/hyprland.conf".source = ./hyprland.conf;
    };

    # Manage Environment variables
    home.sessionVariables = {
      Editor = "neovim";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

}
