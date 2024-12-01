{ pkgs, pkgs-stable, config, inputs, ... }:

{
  environment.systemPackages = 

# Unstable packages
    (with pkgs; [
     wget
     pavucontrol
     unzip
     unrar
     libnotify
     nfs-utils
     networkmanagerapplet
     nfstrace
     cmatrix
     htop
     btop
     q4wine
     waylandpp
     wayland

     ])



  ++

#Stable packages
  (with pkgs-stable; [
   (blender.override { cudaSupport = true;})
   sstp
   waybar
   quickemu
   quickgui
   networkmanager-sstp
   #citrix_workspace
   usbutils
   screen
# STM32 DEV
   stm32cubemx

  ]);


  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "freeimage-unstable-2021-11-01"
    "electron-29.4.6"
  ];

  programs.appimage.binfmt = true;

# Allow Unfree packages on both stable and unstable
  nixpkgs.config.allowUnfree = true;

  _module.args = {
    pkgs-stable = import inputs.nixpkgs-stable {
      inherit (config.nixpkgs) config;
      inherit (pkgs.stdenv.hostPlatform) system;
    };
  };


}
