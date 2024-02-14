{ config, pkgs, inputs, ... }:


{

  imports =
    [
      inputs.nixvim.homeManagerModules.nixvim
    ];

  programs.nixvim = {
    colorschemes.gruvbox.enable = true;
  };

}

