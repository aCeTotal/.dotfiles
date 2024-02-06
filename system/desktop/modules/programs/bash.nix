{ config, pkgs, ... }:

{
    # Bash
    programs.bash = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        ".." = "cd ..";
	"update" = "cd $HOME/.dotfiles && sudo nixos-rebuild switch --flake .#desktop";
	"upgrade" = "cd $HOME/.dotfiles && nix flake update && nixos-rebuild switch --flake .#desktop";


	"editconf" = "vim ~/.dotfiles/system/desktop/configuration.nix";
	"edithome" = "vim ~/.dotfiles/system/desktop/home.nix";
      };        
    };


}
