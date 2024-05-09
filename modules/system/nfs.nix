{ config, pkgs, pkgs-stable, inputs, ... }:

{

 #NFS
  fileSystems."/mnt/nfs/Bigdisk1" = {
    device = "192.168.0.40:/bigdisk1";
    fsType = "nfs";
    options = [ "rw" "nofail" "x-systemd.automount" "noauto" ];
  };


}
