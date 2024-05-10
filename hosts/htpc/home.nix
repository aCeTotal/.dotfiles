{ config, pkgs, inputs, lib, ... }:

{

    imports = 
    [

      #programs
      ../../modules/user/git.nix
      ../../modules/user/bash.nix
      ../../modules/user/alacritty.nix
      ../../modules/user/rofi.nix
      ../../modules/user/nvim/neovim.nix
      ../../modules/user/cursor_icons.nix
      ../../modules/user/htpc_hyprland.nix
    ];

    home = {
    username = "total";
    homeDirectory = "/home/total";
    stateVersion = "24.05";
    };

    shellAliases = {
      "update" = "cd $HOME/.dotfiles && sudo nixos-rebuild switch --flake .#htpc";
      "upgrade" = "cd $HOME/.dotfiles && nix flake update && sudo nixos-rebuild switch --flake .#htpc";
    };

    home.packages = with pkgs; [

    ];

    # Manage Environment variables
    home.sessionVariables = {
      Editor = "vim";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    

}
