{ ... }:

{
  hardware.enableAllFirmware = true;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

   # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.xone.enable = true;
  services.blueman.enable = true;
}
