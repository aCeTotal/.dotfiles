{ config, pkgs, ... }:

{

      home.username = "total";
      home.homeDirectory = "/home/total";
      home.stateVersion = "24.05";

    # Hyprland - Tiling Window Manager Installation
    wayland.windowManager.hyprland = {
      # Whether to enable Hyprland wayland compositor
      enable = true;
  
      # The hyprland package to use
      package = pkgs.hyprland;

      # Whether to enable XWayland
      xwayland.enable = true;

      # Whether to enable hyprland-session.target on hyprland startup
      systemd.enable = true;

      # Whether to enable patching wlroots for better Nvidia support
      enableNvidiaPatches = true;
    };

    home.packages = [

    ];

    home.sessionVariables = {
      # Editor = "Emacs";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

}
