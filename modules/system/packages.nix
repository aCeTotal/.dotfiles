{ config, pkgs, pkgs-stable, inputs, system, ... }:

let
  # 1) Importer argonpkgs-flaken som et eget pakkesett
argonpkgs = inputs.argonpkgs.packages.${system};
  # 2) Egendefinert Blender fra Argon-settet
  blenderCustom = pkgs.blender.overrideAttrs (old: {
    makeFlags = [ "-j2" ];
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
      makemkv
      mkvtoolnix
      prusa-slicer
    ])
    ++
    (with pkgs-stable; [
      usbutils
      screen
      teams-for-linux
      hexchat
      zip
      rar
      nfstrace
      nfs-utils
      opentabletdriver
    ])
    ++
     [
      argonpkgs.louvre
      argonpkgs.argon
     ];

      _module.args = {
      pkgs-stable = import inputs.nixpkgs-stable {
          inherit (config.nixpkgs) config;
          inherit (pkgs.stdenv.hostPlatform) system;
      };
  };
}

