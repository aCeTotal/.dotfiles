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

      version = "555.42.02";
      sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
      sha256_aarch64 = "sha256-ekx0s0LRxxTBoqOzpcBhEKIj/JnuRCSSHjtwng9qAc0=";
      openSha256 = "sha256-3/eI1VsBzuZ3Y6RZmt3Q5HrzI2saPTqUNs6zPh5zy6w=";
      settingsSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
      persistencedSha256 = "sha256-3ae31/egyMKpqtGEqgtikWcwMwfcqMv2K4MVFa70Bqs=";
  };
}
