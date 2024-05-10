
{ ... }:

{
  imports =
    [
        ./hardware_configuration.nix
	../../modules/system/nix.nix
	../../modules/system/htpc_boot.nix
	../../modules/system/hardware.nix
        ../../modules/system/sound.nix
        ../../modules/system/GDM.nix #SDDM
	../../modules/system/hyprland.nix
	../../modules/system/packages.nix
        ../../modules/system/gaming.nix
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


  system.stateVersion = "23.11"; 
}

