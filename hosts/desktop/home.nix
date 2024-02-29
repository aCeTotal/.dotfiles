{ config, pkgs, inputs, lib, ... }:

{

    imports = 
    [

      #programs
      ./modules/git.nix
      ./modules/bash.nix
      ./modules/nixvim.nix
      ./modules/alacritty.nix
      ./modules/rofi.nix
      ./modules/cursor_icons.nix
      ./modules/hyprland.nix
      ./modules/waybar.nix

    ];

    home = {
    username = "total";
    homeDirectory = "/home/total";
    stateVersion = "24.05";
    };

    home.packages = with pkgs; [
      brave
      gimp
      spotify
      blender
      slurp
      grim
      swappy
      pureref
      pamixer

      wl-clipboard
      grimblast

     #Work (Testing)
     libreoffice-fresh
     teams-for-linux
     onedriver
     onedrive
     onedrivegui

     #stm32 dev 
     gcc-arm-embedded
     #stm32cubemx
     stlink-gui
     platformio


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
