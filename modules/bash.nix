{ config, pkgs, ... }:

{
    # Bash
    programs.bash = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        ".." = "cd ..";
	"v" = "nvim";
	"update" = "cd $HOME/.dotfiles && sudo nixos-rebuild switch --flake .#desktop";
	"upgrade" = "cd $HOME/.dotfiles && nix flake update && sudo nixos-rebuild switch --flake .#desktop";

  #Imgui dev
  "guidemo" = "exec ~/arcticmo/src/bin/Linux64/arcticmo";
  "guiedit" = "cd ~/arcticmo/dev-shells/editshell/ && nix-shell";
  "guicompile" = "cd ~/arcticmo/dev-shells/buildshell && nix-shell";

	"editconf" = "nvim ~/.dotfiles/hosts/desktop/configuration.nix";
	"edithome" = "nvim ~/.dotfiles/hosts/desktop/home.nix";
	"modules" = "cd ~/.dotfiles/hosts/desktop/modules";
      };        
    };


}
