{ config, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix> ];

  networking.hostName = "totalos-livecd";
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";
  users.extraUsers.root.password = "root"; # Insecure, change later

  # Nix configuration
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Python and required packages
  environment.systemPackages = with pkgs; [
    git
    parted
    util-linux
    btrfs-progs
    python3
    python3Packages.requests
  ];

  # Auto start script
  systemd.services.autostart-script = {
    description = "Autostart script";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.python3}/bin/python3 /root/installscript.py";
      RemainAfterExit = true;
    };
      wantedBy = [ "multi-user.target" ];
  };

  # Include your startup script in the system configuration
  environment.etc."installscript.py".text = ''
    import os
    import subprocess

    def run_command(cmd):
        result = subprocess.run(cmd, shell=True, check=True, capture_output=True, text=True)
        return result.stdout.strip()

    def get_disks():
        output = run_command("lsblk -dpnoNAME,SIZE | grep -P '/dev/sd|nvme|vd'")
        disks = output.splitlines()
        return disks

    def select_disk(disks):
        print("Available disks for installation:")
        for i, disk in enumerate(disks):
            print(f"{i + 1}: {disk}")
        
        while True:
            try:
                choice = int(input("Please select the number of the corresponding disk (e.g. 1): "))
                if 1 <= choice <= len(disks):
                    return disks[choice - 1].split()[0]  # Return only the disk name, not the size
                else:
                    print("Invalid choice, please select a valid number.")
            except ValueError:
                print("Invalid input, please enter a number.")

    def select_hostname():
        hostnames = ["desktop", "gs66", "htpc", "homeserver"]
        print("Available hostnames:")
        for i, hostname in enumerate(hostnames):
            print(f"{i + 1}: {hostname}")

        while True:
            try:
                choice = int(input("Please select the number of the corresponding host (e.g. 1): "))
                if 1 <= choice <= len(hostnames):
                    return hostnames[choice - 1]
                else:
                    print("Invalid choice, please select a valid number.")
            except ValueError:
                print("Invalid input, please enter a number.")

    def get_user_confirmation(disk):
        confirmation = input(f"WARNING! This WILL wipe the current partition table on {disk}. Do you agree [y/N]?: ").strip().lower()
        return confirmation in ("y", "yes")

    def main():
        # Get list of disks and let user select one
        disks = get_disks()
        if not disks:
            print("No disks found. Exiting.")
            return
        
        selected_disk = select_disk(disks)
        print(f"NixOS will be installed on the following disk: {selected_disk}")

        # Confirm with user before wiping the disk
        if not get_user_confirmation(selected_disk):
            print("Quitting.")
            return

        # Get hostname selection from user
        selected_hostname = select_hostname()
        print(f"Selected hostname: {selected_hostname}")

        # Wipe the current partition table
        print(f"Wiping {selected_disk}.")
        run_command(f"wipefs -af {selected_disk}")
        run_command(f"sgdisk -Zo {selected_disk}")

        # Creating a new partition scheme
        print(f"Creating the partitions on {selected_disk}.")
        run_command(f"parted -s {selected_disk} mklabel gpt")
        run_command(f"parted -s {selected_disk} mkpart NIXBOOT fat32 1MiB 513MiB")
        run_command(f"parted -s {selected_disk} set 1 esp on")
        run_command(f"parted -s {selected_disk} mkpart NIXROOT 513MiB 100%")

        NIXBOOT = "/dev/disk/by-partlabel/NIXBOOT"
        NIXROOT = "/dev/disk/by-partlabel/NIXROOT"

        # Formatting the partitions
        print(f"Formatting the EFI Partition as FAT32.")
        run_command(f"mkfs.fat -F 32 {NIXBOOT}")
        print(f"Mounting the root partition.")
        run_command(f"mkfs.btrfs -f {NIXROOT}")
        run_command(f"mkdir -p /mnt")
        run_command(f"mount {NIXROOT} /mnt")

        # Creating BTRFS subvolumes
        print(f"Creating BTRFS subvolumes.")
        subvols = ["root", "home", "nix", "log"]
        for subvol in subvols:
            run_command(f"btrfs su cr /mnt/@{subvol}")

        def mount_subvolumes():
            print("Creating mountpoints and mounting the newly created subvolumes.")
            run_command("umount -l /mnt")
            run_command(f"mount -t btrfs -o subvol=@root,defaults,noatime,compress=zstd,discard=async,ssd {NIXROOT} /mnt")
            run_command("mkdir -p /mnt/{home,nix,var/log,boot}")
            run_command(f"mount -t btrfs -o subvol=@home,defaults,noatime,compress=zstd,discard=async,ssd {NIXROOT} /mnt/home")
            run_command(f"mount -t btrfs -o subvol=@nix,defaults,noatime,compress=zstd,discard=async,ssd {NIXROOT} /mnt/nix")
            run_command(f"mount -t btrfs -o subvol=@log,defaults,noatime,compress=zstd,discard=async,ssd {NIXROOT} /mnt/var/log")
            run_command(f"mount -t vfat -o defaults,noatime,rw,fmask=0137,dmask=0027 {NIXBOOT} /mnt/boot")

        mount_subvolumes()

        # Clone the private repo
        repo_url = f"https://{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}@github.com/aCeTotal/.dotfiles.git"
        print(f"Cloning the private repo from {repo_url}")
        run_command(f"git clone {repo_url} /mnt/root/.dotfiles")
        os.chdir("/mnt/root/.dotfiles")

        # Copy the hardware-specific configuration to /mnt/etc/nixos
        run_command("cp -r hardware-config /mnt/etc/nixos/hardware-configuration.nix")

        # Generate the hardware-config
        print("Generating the hardware-config")
        run_command("nixos-generate-config --root /mnt")

        # Run nixos-install with the flake
        print("Running nixos-install with the flake")
        run_command(f"nixos-install --flake .#{selected_hostname}")

    if __name__ == "__main__":
        main()
  '';
}

