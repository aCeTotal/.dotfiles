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
      ../../modules/user/nixvim/nixvim.nix
      ../../modules/user/cursor_icons.nix
      ../../modules/user/hyprland.nix
      ../../modules/user/virtualisation.nix
      ../../modules/user/derivations.nix
    ];

    home = {
    username = "total";
    homeDirectory = "/home/total";
    stateVersion = "24.05";
    };

    
    programs.bash.shellAliases = {
      "update" = "cd $HOME/.dotfiles && sudo nixos-rebuild switch --flake .#gs66";
      "upgrade" = "cd $HOME/.dotfiles && nix flake update && sudo nixos-rebuild switch --flake .#gs66";
      "mesh" = "cd ~/meshtree && nix develop";
      "nvidiablender" = "__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia blender";
    };


    home.packages = with pkgs; [
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
