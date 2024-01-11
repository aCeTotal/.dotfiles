{ config, pkgs, ... }:

{
    # Bash
    programs.bash = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        ".." = "cd ..";
      };        
    };


}