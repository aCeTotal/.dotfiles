{ config, pkgs, inputs, lib, ... }:

{

    imports = 
    [

      #programs
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
      brave
      gimp
      librepcb
      spotify
      blender
      slurp
      grim
      swappy
      pureref
      pamixer
      ripgrep

      wl-clipboard
      grimblast

     #Work (Testing)
     libreoffice-fresh
     teams-for-linux
     onedriver
     onedrive
     onedrivegui

     # Dev 
     gcc-arm-embedded
     stm32cubemx
     stlink-gui
     platformio
     clang-tools
     haskellPackages.vulkan
     vulkan-headers
     vulkan-helper
     imgui
     cmake
     boost
     catch2
     cmake
     gnumake
     ccache
     pkg-config
     meson
     ninja
     perl
     bison
     flex
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
