{ config, pkgs, ... }:

{
    # Bash
    programs.bash = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        ".." = "cd ..";
	"v" = "nvim";
	"update" = "cd $HOME/.dotfiles && sudo nixos-rebuild switch --flake .#x11vm";
	"upgrade" = "cd $HOME/.dotfiles && nix flake update && sudo nixos-rebuild switch --flake .#x11vm";


	"editconf" = "nvim ~/.dotfiles/hosts/x11vm/configuration.nix";
	"edithome" = "nvim ~/.dotfiles/hosts/x11vm/home.nix";
	"modules" = "cd ~/.dotfiles/hosts/x11vm/modules";
      };        
    };


}
