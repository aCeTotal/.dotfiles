{ pkgs, ... }:

{

    environment.systemPackages = with pkgs; [
        lm_sensors
    ];

    services.thermald.enable = true;
    services.tlp.enable = true;
    services.tlp.settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "powersave";
    };

    }
