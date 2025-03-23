{ ... }:

{
    # Bash
    programs = {
        bash = {
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
                "drone" = "cd /mnt/nfs/Bigdisk1/dev/stm32/drone/ && nix-shell";
                "dev" = "cd /mnt/nfs/Bigdisk1/dev/imgui/src && shell";
                "build" = "cd /mnt/nfs/Bigdisk1/dev/imgui/src/build/ && cmake .. -G Ninja && ninja";
                "demo" = "cd /mnt/nfs/Bigdisk1/dev/imgui/src/bin/Linux64/ && ./securitydrone";

                "shell" = "nix-shell";

                "mod" = "cd ~/.dotfiles/modules";
            };
        };
        direnv = {
            enable = true;
            nix-direnv.enable = true;
        };
    };
}
