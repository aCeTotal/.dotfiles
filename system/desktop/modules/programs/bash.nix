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
      };        
    };


}
