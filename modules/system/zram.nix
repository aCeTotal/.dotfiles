{ config, pkgs, pkgs-stable, inputs, ... }:

{

 # Zram
  zramSwap = {
    enable = true;
    swapDevices = 1;
    algorithm = "zstd";
  };


}
