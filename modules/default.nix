{ pkgs, ...}:

{
  home.packages = with pkgs; [
    brave
    gimp blender prusa-slicer
    stlink-gui stm32cubemx
    bashmount udisks udiskie
    mpv spotify
    librepcb
    zoxide
    pamixer
    ripgrep
    chatgpt-cli
    slurp grim swappy wl-clipboard

    #Work
    teams-for-linux
    

  ];
  
}
