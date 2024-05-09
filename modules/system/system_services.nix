{ config, pkgs, pkgs-stable, inputs, ... }:

{

  programs.neovim.defaultEditor = true;

  # Power Management
  powerManagement.cpuFreqGovernor = "performance";


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.dconf.enable = true;

  security.rtkit.enable = true;
  services.tumbler.enable = true;
  services.gvfs.enable = true;
  services.fstrim.enable = true;




}
