{ pkgs, users, inputs, system, ...}:

{
  home.packages = with pkgs; [
    google-chrome
    mcontrolcenter
    libreoffice
    pureref
    kitty
    codex
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

    #    (blender.override { cudaSupport = true;})
    
  ];
  
}
