
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


  # Extra BOOT settings
  boot.supportedFilesystems = [ "btrfs" "ntfs" ];
  boot.kernelModules = [ "kvm-intel" ];
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

  # Networking
  networking.networkmanager.enable = true;
 # programs.nm-applet.enable = true;
  networking.hostName = "nixos_vm"; # Define your hostname.

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
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  #services.xserver.displayManager.sddm = {
#	enable = true;
#	wayland.enable = true;
#	autoNumlock = true;
#	theme = "tokyo-night-sddm";
#  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.total = {
    isNormalUser = true;
    initialPassword = "nixos";
    description = "";
    extraGroups = [ "networkmanager" "wheel" "disk" "power" "video" "audio" "disk" "systemd-journal" "dialout" "libvirtd" ];
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
    gnumake
    appimage-run
    pavucontrol
    gh
    neofetch
    discord
    unzip
    unrar
    nfs-utils
    networkmanagerapplet
    nfstrace
    cmatrix
    htop
    btop
  ])

  ++

  #Stable packages
  (with pkgs-stable; [
    sstp
    quickemu
    quickgui
    networkmanager-sstp
    usbutils
    screen
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
  fileSystems."/mnt/bigdisk1" = {
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


# Allow Unfree packages on both stable and unstable
nixpkgs.config.allowUnfree = true;

_module.args = {
  pkgs-stable = import inputs.nixpkgs-stable {
      inherit (config.nixpkgs) config;
      inherit (pkgs.stdenv.hostPlatform) system;
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

