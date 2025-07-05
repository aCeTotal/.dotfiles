{ config, pkgs, pkgs-stable, inputs, ... }:

{

 # Zram
  zramSwap = {
    enable = true;
    size = "10G";
    swapDevices = 1;
    algorithm = "zstd";
  };


}
