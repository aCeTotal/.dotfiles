{ config, pkgs, pkgs-stable, inputs, ... }:

{

  networking.networkmanager.enable = true;


  systemd.user.services = {
    nm-applet = {
      description = "Network manager applet";

        wantedBy = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];

        serviceConfig.ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
      };
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  networking.enableIPv6 = true;


  environment.systemPackages = 

# Unstable packages
    (with pkgs; [
    ])

    ++

#Stable packages
    (with pkgs-stable; [

    ]);


}
