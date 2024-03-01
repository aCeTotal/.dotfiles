
{ pkgs, pkgs-stable, lib, inputs, config, ... }:

{
  imports =
    [
        ./hardware_configuration.nix

    ];

  # Boot Loader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      devices = [ "nodev" ];
      configurationLimit = 4;
    };
  };


  # Kernel setup
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;                             # SysRQ for is rebooting their machine properly if it freezes: SOURCE: https://oglo.dev/tutorials/sysrq/index.html
    "net.core.rmem_default" = 1073741824;           # Default socket receive buffer size, improve network performance & applications that use sockets
    "net.core.rmem_max" = 1073741824;               # Maximum socket receive buffer size, determin the amount of data that can be buffered in memory for network operations
    "net.core.wmem_default" = 1073741824;           # Default socket send buffer size, improve network performance & applications that use sockets
    "net.core.wmem_max" = 1073741824;               # Maximum socket send buffer size, determin the amount of data that can be buffered in memory for network operations
    "net.ipv4.tcp_rmem" = "4096 87380 1073741824";  # 1 GiB max
    "net.ipv4.tcp_wmem" = "4096 87380 1073741824";  # 1 GiB max
    "net.ipv4.tcp_keepalive_intvl" = 30;            # TCP keepalive interval between probes, TCP keepalive probes, which are used to detect if a connection is still alive.
    "net.ipv4.tcp_keepalive_probes" = 5;            # TCP keepalive probes, TCP keepalive probes, which are used to detect if a connection is still alive.
    "net.ipv4.tcp_keepalive_time" = 300;            # TCP keepalive interval (seconds), TCP keepalive probes, which are used to detect if a connection is still alive.
    "vm.dirty_background_bytes" = 268435456;        # 256 MB in bytes, data that has been modified in memory and needs to be written to disk
    "vm.dirty_bytes" = 1073741824;                  # 1 GB in bytes, data that has been modified in memory and needs to be written to disk
    "vm.min_free_kbytes" = 65536;                   # Minimum free memory for safety (in KB), can help prevent memory exhaustion situations
    "vm.swappiness" = 1;                            # how aggressively the kernel swaps data from RAM to disk. Lower values prioritize keeping data in RAM,
    "vm.vfs_cache_pressure" = 50;                   # Adjust vfs_cache_pressure (0-1000), how the kernel reclaims memory used for caching filesystem objects
    "fs.aio-max-nr" = 1048576;                      # defines the maximum number of asynchronous I/O requests that can be in progress at a given time.
    "kernel.pid_max" = 4194304;                     # allows a large number of processes and threads to be managed
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "fq";
  };

  # Extra BOOT settings
  boot.supportedFilesystems = [ "btrfs" "ntfs" ];
  boot.kernelModules = [ "btrfs" "nvidia" "nvidia_uvm" "tcp_bbr" ];
  boot.tmp.cleanOnBoot = true;
  boot.modprobeConfig.enable = true;
  boot.extraModprobeConfig = ''
''; 
  hardware.enableAllFirmware = true;

  # Zram
  zramSwap = {
    enable = true;
    swapDevices = 1;
    algorithm = "zstd";
  };


  # HYPRLAND
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  environment.sessionVariables = {
	# If your cursor becomes invisible
	WLR_NO_HARDWARE_CURSORS = "1";
	# Hint electron apps to use wayland
	NIXOS_OZONE_WL = "1";
  };

  # Power Management
  powerManagement.cpuFreqGovernor = "performance";

  # NVIDIA STUFF
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    modesetting.enable = true;                # Modesetting is required.
    nvidiaPersistenced = true;                # Ensures all GPUs stay awake even during headless mode

    powerManagement.enable = false;           # Nvidia power management. Experimental, and can cause sleep/suspend to fail.

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	  # accessible via `nvidia-settings`.
    nvidiaSettings = false;
  };

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

programs.neovim.defaultEditor = true;

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

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



  services.xserver.displayManager.defaultSession = "hyprland";
  #services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.total = {
    isNormalUser = true;
    initialPassword = "nixos";
    description = "";
    extraGroups = [ "networkmanager" "wheel" "disk" "power" "video" "audio" "disk" "systemd-journal" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
  	"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDbzZLzWSWbwAsBLXBGFj+TJBMn5E1pIBImJTtVfVH4SmA8Ovufm48F0BO/orFXNwjmOo9I1AsmRaZVIz6ehuDiIkhYSRVdKMGI2jyc0SGXmkvKmdPOqZ5a6Diwd793Aal9C8lxOsdoCYIXcpSDEQhmcUl1b/sERtH/YZ+Xg7tZiXMdniqxa+PODYLau+5RqbuS48X5MiWMFFGjZd92gaLh7uRqO6ZyTa47HVPZY8ZhEllEY2eRu9uOnjpr7mQbsX3sCQEIrVcDEBE8IEl1gsjSi3qfSCs2HriQmxqVdDu6h9xPb2BWnvuusS7fX4lXQmCRyKhsEKWg+XcEkesYFqjDv9yqiB35CYRSMYIP+x3+ufk4LmNnp2Ae8dZNinJaEBlJJCY89uljqmB0uoHZVYW7TvjUQzHI/okQ4ecAaapX80DZtC6jCuJ2YsN1W1+DBBhDsX2OfXGaFtgrI8eB4QCheE7kIU0nx55jkfVndkosek3CLmcgvw7xBuTcrjtxUZc= lars.oksendal@gmail.com" # content of authorized_keys file
  	# note: ssh-copy-id will add user@your-machine after the public key
  	# but we can remove the "@your-machine" part
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = 

  # Unstable packages
  (with pkgs; [
    vim
    wget
    freecad
    gamescope
    gnumake
    appimage-run
    pavucontrol
    gh
    neofetch
    discord
    unzip
    unrar
    libnotify
    clinfo
    lm_sensors
    virtualglLib
    vulkan-loader
    vulkan-tools
    nfs-utils
    networkmanagerapplet
    nfstrace
    cmatrix
    htop
    btop
    citrix_workspace
  ])

  ++

  #Stable packages
  (with pkgs-stable; [
    sstp
    networkmanager-sstp
    #citrix_workspace
  ]);

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:
  services.xserver.libinput.enable = true;
  services.xserver.xkb = {
    layout = "no";
  };

  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
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

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;


  #NFS
  fileSystems."/mnt/nfs/Bigdisk1" = {
    device = "192.168.0.40:/bigdisk1";
    fsType = "nfs";
    options = [ "rw" "nofail" "x-systemd.automount" "noauto" ];
  };


  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      randomizedDelaySec = "14m";
      options = "--delete-older-than 10d";
    };
    settings = {
      max-jobs = 40;
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      substituters = [
	"https://nix-gaming.cachix.org"
	"https://hyprland.cachix.org"
	];
      trusted-public-keys = [
	"nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" 
	"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
	];
    };
  };


systemd.user.services = {
    nm-applet = {
      description = "Network manager applet";

      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];

      serviceConfig.ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
    };
};

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

