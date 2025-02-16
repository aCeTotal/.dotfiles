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
     makemkv
     mkvtoolnix
     ])



  ++

#Stable packages
  (with pkgs-stable; [
   (blender.override { cudaSupport = true;})
   sstp
   networkmanager-sstp
   citrix_workspace
   usbutils
   screen
   teams-for-linux
   hexchat
   zip
   rar
   
  ]);


  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    dina-font
    proggyfonts
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "freeimage-unstable-2021-11-01"
    "electron-29.4.6"
    "dotnet-sdk-6.0.428"
    "dotnet-runtime-6.0.36"
    "dotnet-sdk-wrapped-6.0.428"
  ];

  programs.appimage.binfmt = true;
  programs.dconf.enable = true;

# Allow Unfree packages on both stable and unstable
  nixpkgs.config.allowUnfree = true;

  _module.args = {
    pkgs-stable = import inputs.nixpkgs-stable {
      inherit (config.nixpkgs) config;
      inherit (pkgs.stdenv.hostPlatform) system;
    };
  };


}
