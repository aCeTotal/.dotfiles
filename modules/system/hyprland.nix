{ pkgs, ... }:

{
# HYPRLAND
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  environment.sessionVariables = {
# If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
# Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  services.displayManager.defaultSession = "hyprland";

  services.xserver.enable = true;

}
