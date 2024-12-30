
{ ... }:

{
  imports =
    [
        ./hardware_configuration.nix
	../../modules/system/nix.nix
	../../modules/system/htpc/htpc_boot.nix
	../../modules/system/htpc/hardware.nix
        ../../modules/system/sound.nix
        ../../modules/system/ly.nix #SDDM #GDM
	../../modules/system/hyprland.nix
	../../modules/system/htpc/packages.nix
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

