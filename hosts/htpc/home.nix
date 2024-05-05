{ config, pkgs, inputs, lib, ... }:

{

    imports = 
    [

      #programs
      ../../modules/default.nix
      ../../modules/git.nix
      ../../modules/bash.nix
      ../../modules/alacritty.nix
      ../../modules/rofi.nix
      ../../modules/nvim/neovim.nix
      ../../modules/cursor_icons.nix
      ../../modules/hyprland.nix
      ../../modules/waybar.nix
    #  ../../modules/tmux.nix
    ];

    home = {
    username = "total";
    homeDirectory = "/home/total";
    stateVersion = "24.05";
    };

    home.packages = with pkgs; [
    libreoffice
    zellij
    
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

    ];

    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
     };
    };

    # Manage Environment variables
    home.sessionVariables = {
      Editor = "vim";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    

}