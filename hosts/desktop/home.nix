{ config, pkgs, inputs, lib, ... }:

{

    imports = 
    [

      #programs
      ../../modules/user/default.nix
      ../../modules/user/git.nix
      ../../modules/user/bash.nix
      ../../modules/user/alacritty.nix
      ../../modules/user/rofi.nix
      ../../modules/user/nvim/neovim.nix
      ../../modules/user/cursor_icons.nix
      ../../modules/user/hyprland.nix
      ../../modules/user/waybar.nix
      ../../modules/user/virtualisation.nix
    #  ../../modules/user/tmux.nix
    ];

    home = {
    username = "total";
    homeDirectory = "/home/total";
    stateVersion = "24.05";
    };

    programs.bash.shellAliases = {
      "update" = "cd $HOME/.dotfiles && sudo nixos-rebuild switch --flake .#desktop";
      "upgrade" = "cd $HOME/.dotfiles && nix flake update && sudo nixos-rebuild switch --flake .#desktop";
    };


    home.packages = with pkgs; [
    libreoffice
    zellij
    #shell_gpt
    aichat
    tgpt
    heygpt
    yai
    irssi
    stlink
    ryujinx
    # dev
 
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
