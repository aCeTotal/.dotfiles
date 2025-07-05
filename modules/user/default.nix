{ pkgs, users,...}:

{
  home.packages = with pkgs; [
    google-chrome netflix
    libreoffice
    pureref
    kitty
    gimp freecad
    #stlink 
    #stm32cubemx
    bashmount udisks udiskie
    mpv 
    spotify
    zoxide
    pamixer
    ripgrep
    slurp grim swappy wl-clipboard
    nix-index

    #Work
    #teams-for-linux

    #(blender.override { cudaSupport = true;})
    

  ];
  
}
