{ pkgs, ... }:

{

     home.packages = with pkgs; [
        hyprpaper
    ];


    home.file.".config/hypr/hyprpaper.conf".text = ''

    preload = ~/.dotfiles/wallpapers/current.jpg
    wallpaper = , ~/.dotfiles/wallpapers/current.jpg

    '';

}
