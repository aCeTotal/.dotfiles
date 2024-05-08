
{ pkgs, ... }:

{
  imports =
    [
        ./hardware_configuration.nix
	../../modules/system/nix.nix
	../../modules/system/boot.nix
	../../modules/system/hardware.nix
	../../modules/system/nvidia.nix
	../../modules/system/hyprland.nix
	../../modules/system/packages.nix
      ];

  # Zram
  zramSwap = {
    enable = true;
    swapDevices = 1;
    algorithm = "zstd";
  };


  environment.sessionVariables = {
	#Steam GE-Proton support
	STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/total/.steam/root/compatibilitytools.d/";
      };

  environment.variables = {
    EDITOR = "nvim";
    OPENAI_API_KEY = "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";
  };

  # Power Management
  powerManagement.cpuFreqGovernor = "performance";

  # Networking
  networking.networkmanager.enable = true;
 # programs.nm-applet.enable = true;
  networking.hostName = "nixos"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Oslo";
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nb_NO.UTF-8";
    LC_IDENTIFICATION = "nb_NO.UTF-8";
    LC_MEASUREMENT = "nb_NO.UTF-8";
    LC_MONETARY = "nb_NO.UTF-8";
    LC_NAME = "nb_NO.UTF-8";
    LC_NUMERIC = "nb_NO.UTF-8";
    LC_PAPER = "nb_NO.UTF-8";
    LC_TELEPHONE = "nb_NO.UTF-8";
    LC_TIME = "nb_NO.UTF-8";
  };

  programs.neovim.defaultEditor = true;

    # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  #services.xserver.displayManager.sddm = {
  #	enable = true;
  #	wayland.enable = true;
  #	autoNumlock = true;
  #	theme = "tokyo-night-sddm";
  #  };

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
#  services.desktopManager.plasma6.enable = true;



  #services.displayManager.defaultSession = "hyprland";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.total = {
    isNormalUser = true;
    initialPassword = "nixos";
    extraGroups = [ "networkmanager" "wheel" "disk" "power" "video" "audio" "disk" "systemd-journal" "dialout" "libvirtd" ];
    openssh.authorizedKeys.keys = [];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.dconf.enable = true;

  # List services that you want to enable:
  services.xserver.libinput.enable = true;
  services.xserver.xkb = {
    layout = "no";
  };


  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  gamescopeSession.enable = true;

  };

  programs.gamemode.enable = true;

  console = {
    packages=[ pkgs.terminus_font ];
    font="${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
    keyMap = "no";
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.pulseaudio.enable = false;
  sound.enable = true;
  security.rtkit.enable = true;
  services.tumbler.enable = true;
  services.gvfs.enable = true;
  services.fstrim.enable = true;

  services.openssh = {
   enable = true;
   # require public key authentication for better security
   settings.PasswordAuthentication = false;
   settings.KbdInteractiveAuthentication = false;
   #settings.PermitRootLogin = "yes";
  };

  #NFS
  fileSystems."/mnt/nfs/Bigdisk1" = {
    device = "192.168.0.40:/bigdisk1";
    fsType = "nfs";
    options = [ "rw" "nofail" "x-systemd.automount" "noauto" ];
  };

  systemd.user.services = {
      nm-applet = {
        description = "Network manager applet";

        wantedBy = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];

        serviceConfig.ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
      };
  };

  # Enable the libvirt daemon
  virtualisation.libvirtd = {
      enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMFFull.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };


  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;


  systemd.services.NetworkManager-wait-online.enable = false;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  networking.enableIPv6 = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

