{ config, pkgs, inputs, ... }:


{
	programs.nixvim.plugins.indent-blankline = {
    		enable = true;
        settings = {
    		  indent.char = "▎";
        };
  	};
}


