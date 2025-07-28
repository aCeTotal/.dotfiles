{ pkgs, users, inputs, system, ...}:

{
  home.packages = with pkgs; [
    google-chrome
    libreoffice
    pureref
    kitty
    freecad
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

    (blender.override { cudaSupport = true;})
    
  ];
  
}
