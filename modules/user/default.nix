{ pkgs, users,...}:

{
  home.packages = with pkgs; [
    firefox
    google-chrome netflix
    kitty
    gimp prusa-slicer freecad
    #stlink 
    #stm32cubemx
    bashmount udisks udiskie
    mpv 
    spotify
    zoxide
    pamixer
    ripgrep
    slurp grim swappy wl-clipboard

    #Work
    #teams-for-linux

    #(blender.override { cudaSupport = true;})
    

  ];
  
}
