{ config, pkgs, ... }:

{
    # Bash
    programs.bash = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        ".." = "cd ..";
	"v" = "nvim";
	"update" = "cd $HOME/.dotfiles && sudo nixos-rebuild switch --flake .#t480";
	"upgrade" = "cd $HOME/.dotfiles && nix flake update && sudo nixos-rebuild switch --flake .#t480";


	"editconf" = "nvim ~/.dotfiles/hosts/t480/configuration.nix";
	"edithome" = "nvim ~/.dotfiles/hosts/t480/home.nix";
	"modules" = "cd ~/.dotfiles/hosts/t480/modules";
      };        
    };


}
