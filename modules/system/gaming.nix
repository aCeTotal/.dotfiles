{ config, pkgs, pkgs-stable, inputs, ... }:

{

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  environment.sessionVariables = {
    #Steam GE-Proton support
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/total/.steam/root/compatibilitytools.d/";
  };

    environment.systemPackages = 

# Unstable packages
    (with pkgs; [
     protontricks
     protonup
     discord
     ])

  ++

#Stable packages
  (with pkgs-stable; [

  ]);



# Allow Unfree packages on both stable and unstable
  nixpkgs.config.allowUnfree = true;

  _module.args = {
    pkgs-stable = import inputs.nixpkgs-stable {
      inherit (config.nixpkgs) config;
      inherit (pkgs.stdenv.hostPlatform) system;
    };
  };

}
