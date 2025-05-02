{ config, pkgs, inputs, lib, ... }:

{

    imports = 
    [
      #modules
      ../../modules/user/default.nix
      ../../modules/user/git.nix
      ../../modules/user/bash.nix
      ../../modules/user/alacritty.nix
      ../../modules/user/rofi.nix
      ../../modules/user/nixvim/nixvim.nix
      #../../modules/user/neovim.nix
      ../../modules/user/cursor_icons.nix
      ../../modules/user/hyprland.nix
      #      ../../imodules/user/waybar.nix
      ../../modules/user/virtualisation.nix
      ../../modules/user/derivations.nix
      #../../modules/user/tmux.nix
    ];

    home = {
    username = "total";
    homeDirectory = "/home/total";
    stateVersion = "24.05";
    };

    programs.bash.shellAliases = {
      "update" = "cd $HOME/.dotfiles && sudo nixos-rebuild switch --flake .#desktop";
      "upgrade" = "cd $HOME/.dotfiles && nix flake update && sudo nixos-rebuild switch --flake .#desktop";
      "mesh" = "cd ~/meshtree && nix develop";
      "todo" = "cd ~/todo && vim";
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
