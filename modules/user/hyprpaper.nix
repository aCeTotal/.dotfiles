{ pkgs, ... }:

{

     home.packages = with pkgs; [
        hyprpaper
    ];


    home.file.".config/hypr/hyprpaper.conf".text = ''

    preload = "$HOME/.dotfiles/wallpapers/current.jpg"
    wallpaper = "$HOME/.dotfiles/wallpapers/current.jpg"

    '';

}
