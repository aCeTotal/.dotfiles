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
  services.blueman.enable = true;

  #opentabletdriver for drawing/graphics tablets
  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
    blacklistedKernelModules = [  "hid-uclogic" "wacom"];
  };

}
