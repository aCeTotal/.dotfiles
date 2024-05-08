{ ... }:

{

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
      modesetting.enable = true;                # Modesetting is required.
      nvidiaPersistenced = true;               # Ensures all GPUs stay awake even during headless mode
      powerManagement.enable = false;           # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = false;
  };
}
