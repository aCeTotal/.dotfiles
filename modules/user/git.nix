{ pkgs, ... }:

{

    home.packages = with pkgs; [
        libsecret
        git-lfs
    ];

    programs.git = {
        enable = true;
        package = pkgs.gitFull;
        userName  = "aCeTotal";
        userEmail = "lars.oksendal@gmail.com";
    };

    programs.ssh = {
        enable = true;
        compression = true;
        controlMaster = "auto";

        matchBlocks = {
            "github.com" = {
                identityFile = "~/.ssh/github";
            };
        };
    };
}
