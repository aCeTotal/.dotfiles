{ pkgs, pkgs-stable, config, inputs, ... }:

{
  environment.systemPackages = 

# Unstable packages
    (with pkgs; [
     wget
     freecad
     gnumake
     appimage-run
     pavucontrol
     gh
     neofetch
     unzip
     unrar
     libnotify
     clinfo
     lm_sensors
     virtualglLib
     nfs-utils
     networkmanagerapplet
     nfstrace
     cmatrix
     htop
     btop
     q4wine
     waylandpp
     wayland
     clang
     gcc
    gtk4-layer-shell
    gtk4

     ])



  ++

#Stable packages
  (with pkgs-stable; [
   sstp
   waybar
   quickemu
   quickgui
   networkmanager-sstp
   citrix_workspace
   usbutils
   screen
# STM32 DEV
   stm32cubemx

  ]);


  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    nerdfonts
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "freeimage-unstable-2021-11-01"
  ];

# Allow Unfree packages on both stable and unstable
  nixpkgs.config.allowUnfree = true;

  _module.args = {
    pkgs-stable = import inputs.nixpkgs-stable {
      inherit (config.nixpkgs) config;
      inherit (pkgs.stdenv.hostPlatform) system;
    };
  };


}
