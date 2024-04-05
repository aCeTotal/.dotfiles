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
  "im-shell" = "cd ~/imgui_vulkan/ && nix-shell";
  "im-demo" = "exec ~/imgui_vulkan/src/bin/Linux64/imgui_testing";
  "im-edit" = "nvim ~/imgui_vulkan/src/main.cpp";
  "im-compile" = "cd ~/imgui_vulkan/src/build && ninja";

	"editconf" = "nvim ~/.dotfiles/hosts/desktop/configuration.nix";
	"edithome" = "nvim ~/.dotfiles/hosts/desktop/home.nix";
	"modules" = "cd ~/.dotfiles/hosts/desktop/modules";
      };        
    };


}
