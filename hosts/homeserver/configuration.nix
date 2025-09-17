
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

  # Extra BOOT settings
  boot.supportedFilesystems = [ "btrfs" "ntfs" ];
  boot.kernelModules = [ "btrfs" "tcp_bbr" ];
  boot.tmp.cleanOnBoot = true;

  # Zram
  zramSwap = {
    enable = true;
    swapDevices = 1;
    memoryPercent = 25;
    algorithm = "zstd";
  };


services.mysql = {
  enable = true;
  package = pkgs.mariadb;
  ensureDatabases = [ "pfo_db" "pfo_testing" ];
  ensureUsers = [
    {
      name = "nixos";
      ensurePermissions = {
        "pfo_db.*" = "ALL PRIVILEGES";
        "pfo_testing.*" = "ALL PRIVILEGES";
      };
    }
  ];
  initialScript = pkgs.writeText "mysql-init" ''
    CREATE USER 'nixos'@'localhost' IDENTIFIED BY 'nixos';
    GRANT ALL PRIVILEGES ON pfo_db.* TO 'nixos'@'localhost';
    GRANT ALL PRIVILEGES ON pfo_testing.* TO 'nixos'@'localhost';
    FLUSH PRIVILEGES;
  '';
};

services.mysqlBackup = {
  enable = true;
  databases = [ "pfo_db" ];
  location = "/var/backup/mysql";
  calendar = "03:00:00";
  user = "nixos";
};


security.acme = {
  acceptTerms = true;
  defaults.email = "lars.oksendal@oneco.no";
};

security.acme.certs."pfoprod.ddns.net" = {
  listenHTTP = "0.0.0.0:80";
};

services.caddy = {
  enable = true;
  virtualHosts."pfoprod.ddns.net" = {
    useACMEHost = "pfoprod.ddns.net";
    extraConfig = ''
	@adrian path /Adrian/*
	file_server browse

      	@pfo path /PFO/* 
	reverse_proxy @pfo localhost:4500

	root * /mnt/bigdisk1/www
	file_server
    '';
  };
};


systemd.services.pfo-server = {
  description = "Node.js server for PFO";
  after = [ "network.target" ];
  wants = [ "network.target" ];
  wantedBy = [ "multi-user.target" ];
  
  serviceConfig = {
    ExecStart = "/run/current-system/sw/bin/node /mnt/bigdisk1/www/PFO/server.js";
    WorkingDirectory = "/mnt/bigdisk1/www/PFO";
    User = "total";
    Group = "users";
    Restart = "always";
    StandardOutput = "journal";
    StandardError = "journal";
  };
};

systemd.services.pfo-testingserver = {
  description = "Node.js server for PFO (TESTING ONLY)";
  after = [ "network.target" ];
  wants = [ "network.target" ];
  wantedBy = [ "multi-user.target" ];
  
  serviceConfig = {
    ExecStart = "/run/current-system/sw/bin/node /mnt/bigdisk1/www/PFO_testing/server.js";
    WorkingDirectory = "/mnt/bigdisk1/www/PFO_testing";
    User = "total";
    Group = "users";
    Restart = "always";
    StandardOutput = "journal";
    StandardError = "journal";
  };
};


  # NFS Server
  services.nfs.server = {
    enable = true;
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
    exports = ''
    /export 192.168.0.30(rw,fsid=0,no_subtree_check) 192.168.0.15(rw,fsid=0,no_subtree_check) 192.168.0.68(rw,fsid=0,no_subtree_check)
    /export/bigdisk1 192.168.0.30(rw,nohide,insecure,no_subtree_check) 192.168.0.15(rw,nohide,insecure,no_subtree_check) 192.168.0.68(rw,nohide,insecure,no_subtree_check)
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

  environment.systemPackages = with pkgs; [
    vim
    nodejs_23
    mariadb
    noip
  ];

  # Some programs need SUID wrappers, can be configured further or are
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:
  services.libinput.enable = true;
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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall = {
    enable = false;
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

