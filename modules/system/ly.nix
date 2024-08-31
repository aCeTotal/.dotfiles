{ pkgs, pkgs-stable, ... }:

{

  services.displayManager.ly.enable = true;

  environment.systemPackages = 

# Unstable packages
    (with pkgs; [
    ])

    ++

#Stable packages
    (with pkgs-stable; [

    ]);


}
