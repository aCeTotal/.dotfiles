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
    #  ../../modules/user/tmux.nix
    ];

    home = {
    username = "total";
    homeDirectory = "/home/total";
    stateVersion = "24.05";
    };

    home.packages = with pkgs; [
    libreoffice
    zellij
    shell_gpt
    aichat
    tgpt
    heygpt
    yai
    irssi
    
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
