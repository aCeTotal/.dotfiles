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


  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  penvironment.systemPackages = 

# Unstable packages
    (with pkgs; [
    ])

    ++

#Stable packages
    (with pkgs-stable; [

    ]);


}
