{ config, pkgs, ... }:

{
    # Bash
    programs.bash = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        ".." = "cd ..";
	"v" = "nvim";
	"update" = "cd $HOME/.dotfiles && sudo nixos-rebuild switch --flake .#homeserver";
	"upgrade" = "cd $HOME/.dotfiles && nix flake update && sudo nixos-rebuild switch --flake .#homeserver";


	"editconf" = "nvim ~/.dotfiles/hosts/desktop/configuration.nix";
	"edithome" = "nvim ~/.dotfiles/hosts/desktop/home.nix";
	"modules" = "cd ~/.dotfiles/hosts/desktop/modules";
      };        
    };


}
