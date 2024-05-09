{ config, pkgs, pkgs-stable, inputs, ... }:

{

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  penvironment.systemPackages = 

# Unstable packages
    (with pkgs; [
    ])

    ++

#Stable packages
    (with pkgs-stable; [

    ]);


}
