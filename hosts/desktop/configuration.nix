
{ pkgs, pkgs-stable, inputs, config, ... }:

{
  imports =
    [
        ./hardware_configuration.nix
	../../modules/system/boot.nix
      ];

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
	#Steam GE-Proton support
	STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/total/.steam/root/compatibilitytools.d/";
      };

  environment.variables = {
    EDITOR = "nvim";
    OPENAI_API_KEY = "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";
  };

  # Power Management
  powerManagement.cpuFreqGovernor = "performance";

  # NVIDIA STUFF
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    modesetting.enable = true;                # Modesetting is required.
    nvidiaPersistenced = false;                # Ensures all GPUs stay awake even during headless mode

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
#  services.desktopManager.plasma6.enable = true;



  #services.displayManager.defaultSession = "hyprland";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.total = {
    isNormalUser = true;
    initialPassword = "nixos";
    description = "";
    extraGroups = [ "networkmanager" "wheel" "disk" "power" "video" "audio" "disk" "systemd-journal" "dialout" "libvirtd" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = 

  # Unstable packages
  (with pkgs; [
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
    vulkan-tools
    nfs-utils
    networkmanagerapplet
    nfstrace
    cmatrix
    htop
    btop
    protontricks
    q4wine
    wine-wayland
    waylandpp
    wayland
    clang
    gcc
    protonup
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
    openocd
    stlink
    stm32cubemx

  ]);

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

