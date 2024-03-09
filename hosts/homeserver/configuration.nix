
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
  boot.kernelPackages = pkgs.linuxPackages;

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
  boot.kernelModules = [ "btrfs" "tcp_bbr" ];
  boot.tmp.cleanOnBoot = true;
  boot.modprobeConfig.enable = true;
  boot.extraModprobeConfig = ''
''; 
  hardware.enableAllFirmware = true;

  # Zram
  zramSwap = {
    enable = true;
    swapDevices = 1;
    memoryPercent = 25;
    algorithm = "zstd";
  };

  # NFS Server
  services.nfs.server = {
    enable = true;
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
    exports = ''
    /export 192.168.0.30(rw,fsid=0,no_subtree_check) 192.168.0.15(rw,fsid=0,no_subtree_check) 10.0.2.15(rw,fsid=0,no_subtree_check)
    /export/bigdisk1 192.168.0.30(rw,nohide,insecure,no_subtree_check) 192.168.0.15(rw,nohide,insecure,no_subtree_check) 10.0.2.15(rw,nohide,insecure,no_subtree_check)
    '';
  };

  # NFS
  fileSystems."/export/bigdisk1" = {
    device = "/mnt/bigdisk1";
    options = [ "bind" "rw" "mode=777" ];
  };

  fileSystems."/export/bigdisk2" = {
    device = "/mnt/bigdisk2";
    options = [ "bind" "rw" "mode=777" ];
  };

  #bigdisk 1 mount
  fileSystems."/mnt/bigdisk1" = {
    device = "/dev/disk/by-partlabel/bigdisk1";
    fsType = "ext4";
  };

  # Power Management
  powerManagement.cpuFreqGovernor = "performance";

  # Networking
  networking.networkmanager.enable = true;
 # programs.nm-applet.enable = true;
  networking.hostName = "nixserver"; # Define your hostname.

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


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.total = {
    isNormalUser = true;
    initialPassword = "nixos";
    description = "";
    extraGroups = [ "networkmanager" "wheel" "disk" "power" "video" "audio" "disk" "systemd-journal" "dialout" "deluge" "octoprint" "users"  ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
  	"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDbzZLzWSWbwAsBLXBGFj+TJBMn5E1pIBImJTtVfVH4SmA8Ovufm48F0BO/orFXNwjmOo9I1AsmRaZVIz6ehuDiIkhYSRVdKMGI2jyc0SGXmkvKmdPOqZ5a6Diwd793Aal9C8lxOsdoCYIXcpSDEQhmcUl1b/sERtH/YZ+Xg7tZiXMdniqxa+PODYLau+5RqbuS48X5MiWMFFGjZd92gaLh7uRqO6ZyTa47HVPZY8ZhEllEY2eRu9uOnjpr7mQbsX3sCQEIrVcDEBE8IEl1gsjSi3qfSCs2HriQmxqVdDu6h9xPb2BWnvuusS7fX4lXQmCRyKhsEKWg+XcEkesYFqjDv9yqiB35CYRSMYIP+x3+ufk4LmNnp2Ae8dZNinJaEBlJJCY89uljqmB0uoHZVYW7TvjUQzHI/okQ4ecAaapX80DZtC6jCuJ2YsN1W1+DBBhDsX2OfXGaFtgrI8eB4QCheE7kIU0nx55jkfVndkosek3CLmcgvw7xBuTcrjtxUZc= lars.oksendal@gmail.com" # content of authorized_keys file
  	# note: ssh-copy-id will add user@your-machine after the public key
  	# but we can remove the "@your-machine" part
    ];
  };

  users.users = {
    octoprint = {
    isNormalUser = false;
    initialPassword = "123";
    home = "/home/octoprint";
    extraGroups = [ "networkmanager" "wheel" "octoprint" "users" ];
    };
    deluge = {
    isNormalUser = false;
    initialPassword = "123";
    extraGroups = [ "networkmanager" "deluge" "users" ];
    };
  };

  services = {
    octoprint = {
      enable = true;
      openFirewall = true;
      user = "octoprint";
      group = "octoprint";
    };
    deluge = {
      enable = true;
      web.enable = true;
      web.openFirewall = true;
      openFirewall = true;
      group = "users";
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = 

  # Unstable packages
  (with pkgs; [
    vim
    wget
    fail2ban
    unzip
    unrar
    nfs-utils
    nfstrace
    htop
  ])

  ++

  #Stable packages
  (with pkgs-stable; [
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

  # List services that you want to enable:
  services.xserver.libinput.enable = true;
  services.xserver.xkb = {
    layout = "no";
  };

  security.rtkit.enable = true;
  services.tumbler.enable = true;
  services.gvfs.enable = true;
  services.fstrim.enable = true;

  services.openssh = {
   enable = true;
   settings = {
     PermitRootLogin = "no";
    };
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
      allowed-users = [ "total" ];
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
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 111  2049 4000 4001 4002 20048 ];
    allowedUDPPorts = [ 111 2049 4000 4001  4002 20048 ];
  };

  networking.enableIPv6 = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

