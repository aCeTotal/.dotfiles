{ config, pkgs, pkgs-stable, inputs, system, ... }:

let
  blenderCustom = pkgs.blender.overrideAttrs (old: {
    makeFlags = [ "-j4" ];
  }) // {
    cudaSupport = true;
  };
in {
  # Tillat ufrie + usikre pakker på tvers av nixpkgs
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "freeimage-unstable-2021-11-01"
      "electron-29.4.6"
      "dotnet-sdk-6.0.428"
      "dotnet-runtime-6.0.36"
      "dotnet-sdk-wrapped-6.0.428"
      "libxml2-2.13.8"
    ];
  };

  # Aktiver appimage og dconf
  programs.appimage.binfmt = true;
  programs.dconf.enable    = true;

  # Fonter (fra den ustabile kanalen)
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    dina-font
    proggyfonts
  ];

  # Systempakker: først nixpkgs-unstable, så nixpkgs-stable, så Argon
  environment.systemPackages =
    (with pkgs; [
      wget
      windsurf
      pavucontrol
      unzip
      unrar
      libnotify
      networkmanagerapplet
      cmatrix
      htop
      btop
      q4wine
      waylandpp
      wayland
      prusa-slicer
      wf-recorder
    ])
    ++
    (with pkgs-stable; [
      usbutils
      screen
      teams-for-linux
      hexchat
      zip
      rar
      nfs-utils
    ]);
    
      _module.args = {
      pkgs-stable = import inputs.nixpkgs-stable {
          inherit (config.nixpkgs) config;
          inherit (pkgs.stdenv.hostPlatform) system;
      };
  };
}

