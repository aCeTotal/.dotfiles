{ pkgs, pkgs-stable, ... }:

{

  services.xserver.displayManager.ly.enable = true;

  environment.systemPackages = 

# Unstable packages
    (with pkgs; [
    ])

    ++

#Stable packages
    (with pkgs-stable; [

    ]);


}
