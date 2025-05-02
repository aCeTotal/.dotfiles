{ pkgs, ... }:

{
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };
    services.pulseaudio.enable = false;
    services.pipewire.wireplumber.enable = true;

    environment.systemPackages = with pkgs; [
        bluez
        bluez-tools
        blueman
        wireplumber
        pipewire
        pavucontrol  # For å kontrollere lydkanaler
    ];

}
