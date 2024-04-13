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
      ../../modules/nixvim/nixvim.nix
      ../../modules/cursor_icons.nix
      ../../modules/hyprland.nix
      ../../modules/waybar.nix
    ];

    home = {
    username = "total";
    homeDirectory = "/home/total";
    stateVersion = "24.05";
    };

    home.packages = with pkgs; [
    ];

    services.ssh-agent.enable = true;

    # Manage dotfiles
    home.file = {
      #".config/hyprland/hyprland.conf".source = ./hyprland.conf;
    };

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
