
{ inputs, config, pkgs, pkgs-stable,... }:

{
  imports =
    [
        ./hardware_configuration.nix
	../../modules/system/nix.nix
	../../modules/system/boot.nix
	../../modules/system/hardware.nix
        ../../modules/system/sound.nix
        ../../modules/system/GDM.nix #SDDM
	../../modules/system/nvidia.nix #amd #intel
	../../modules/system/hyprland.nix
        ../../modules/system/gaming.nix
        ../../modules/system/virtualisation.nix
        ../../modules/system/networking.nix
        ../../modules/system/timezone_locale.nix
        ../../modules/system/ssh.nix
        ../../modules/system/nfs.nix
        ../../modules/system/system_services.nix
      ];


  # Networking Hostname
  networking.hostName = "nixos"; 


  # Users and groups
  users.users.total = {
    isNormalUser = true;
    initialPassword = "nixos";
    extraGroups = [ "networkmanager" "wheel" "disk" "power" "video" "audio" "disk" "systemd-journal" "dialout" "libvirtd" ];
    openssh.authorizedKeys.keys = [];
  };

  environment.systemPackages =

# Unstable
  (with pkgs; [
    wget
    freecad
    appimage-run
    neofetch
    unzip
    unrar
  ])

++

# Stable
  (with pkgs-stable; [

  ]);

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    nerdfonts
    fira-code
    fira-code-symbols
    dina-font
    proggyfonts
  ];

  nixpkgs.config = { allowBroken = true; allowUnfree = true; };

  _module.args = {
    pkgs-stable = import inputs.nixpkgs-stable {
      inherit (config.nixpkgs) config;
      inherit (pkgs.stdenv.hostPlatform) system;
    };
  };



  system.stateVersion = "23.11"; 
}

