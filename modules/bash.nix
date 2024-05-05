{ config, pkgs, ... }:

{
    # Bash
    programs.bash = {
      enable = true;
      enableCompletion = true;

      shellAliases = {
	"z" = "zoxide";
	"zs" = "zoxide query";
	"add" = "zoxide add";
	"chat" = "chatgpt"; 
        "ls" = "ls -l --color=auto";
        ".." = "cd ..";
	"v" = "nvim";
	"drone" = "cd /mnt/nfs/Bigdisk1/dev/stm32/drone/";
	"dev" = "cd /mnt/nfs/Bigdisk1/dev/imgui/src && shell";
	"build" = "cd /mnt/nfs/Bigdisk1/dev/imgui/src/build/ && cmake .. -G Ninja && ninja";
	"demo" = "cd /mnt/nfs/Bigdisk1/dev/imgui/src/bin/Linux64/ && ./securitydrone";
	
	"shell" = "nix-shell";
	"update" = "cd $HOME/.dotfiles && sudo nixos-rebuild switch --flake .#desktop";
	"upgrade" = "cd $HOME/.dotfiles && nix flake update && sudo nixos-rebuild switch --flake .#desktop";

	"editconf" = "nvim ~/.dotfiles/hosts/desktop/configuration.nix";
	"edithome" = "nvim ~/.dotfiles/hosts/desktop/home.nix";
	"mod" = "cd ~/.dotfiles/modules";
      };        
    };


}
