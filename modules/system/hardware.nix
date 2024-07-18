{ ... }:

{
  hardware.enableAllFirmware = true;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    anable32Bit = true;
  };

   # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

}
