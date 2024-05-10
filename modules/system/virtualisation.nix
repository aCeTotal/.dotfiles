{ config, pkgs, pkgs-stable, inputs, ... }:

{

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

  boot.kernelParams = [ "intel_iommu=on" "iommu=pt"];
  boot.kernelModules = [ "kvm-intel" "vfio-pci" ];


  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  environment.systemPackages = 

# Unstable packages
    (with pkgs; [
      iproute2
    ])

    ++

#Stable packages
    (with pkgs-stable; [

    ]);


}
