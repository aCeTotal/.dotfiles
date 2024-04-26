{ config, pkgs, ... }:

{
    # Bash
    programs.bash = {
      enable = true;
      shellAliases = {
	"z" = "zoxide";
	"zs" = "zoxide query";
	"add" = "zoxide add";
        "ls" = "ls -l --color=auto";
        ".." = "cd ..";
	"v" = "nvim";
	"update" = "cd $HOME/.dotfiles && sudo nixos-rebuild switch --flake .#desktop";
	"upgrade" = "cd $HOME/.dotfiles && nix flake update && sudo nixos-rebuild switch --flake .#desktop";

  #Imgui dev
  "demo" = "exec ~/arcticmo/src/bin/Linux64/arcticmo";
  "edit" = "cd ~/arcticmo/dev-shells/editshell/ && nix-shell";
  "build" = "cd ~/arcticmo/dev-shells/buildshell && nix-shell";

	"editconf" = "nvim ~/.dotfiles/hosts/desktop/configuration.nix";
	"edithome" = "nvim ~/.dotfiles/hosts/desktop/home.nix";
	"mod" = "cd ~/.dotfiles/modules";
      };        
    };


}
