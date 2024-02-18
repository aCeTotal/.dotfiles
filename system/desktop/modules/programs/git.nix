{ config, pkgs, ... }:

{
        programs.git = {
            enable = true;
	    package = pkgs.gitFull;
            userName  = "aCeTotal";
            userEmail = "lars.oksendal@gmail.com";

	    extraConfig = {
	      credential.helper = "${
	      pkgs.git.override { withLibsecret = true; }
	      }/bin/git-credential-libsecret";
	    };
        };
}
