{ pkgs, users,...}:

{
  home.packages = with pkgs; [
    firefox
    gimp prusa-slicer freecad
    stlink 
    #stm32cubemx
    bashmount udisks udiskie
    mpv spotify
    librepcb
    zoxide
    pamixer
    ripgrep
    chatgpt-cli
    slurp grim swappy wl-clipboard

    #Work
    #teams-for-linux

    #(blender.override { cudaSupport = true;})
    

  ];
  
}
