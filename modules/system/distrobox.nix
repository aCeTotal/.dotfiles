{ config, pkgs, pkgs-stable, inputs, ... }:

{
    virtualisation.podman = {
        enable = true;
        dockerCompat = true;
    };

  environment.systemPackages = 

# Unstable packages
    (with pkgs; [
        distrobox
    ])

    ++

#Stable packages
    (with pkgs-stable; [

    ]);


}
