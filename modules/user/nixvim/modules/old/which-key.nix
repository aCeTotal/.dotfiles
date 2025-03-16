{ config, pkgs, inputs, ... }:


{

programs.nixvim = {
	plugins = {
      ## Whichkey
      which-key = {
        enable = true;
        registrations = {
          "<leader>t" = "Toggle";
          "<leader>r" = "Rust Actions";
          "<leader>c" = "Code";
          "<leader>d" = "LSP Diagnostic";
          "<leader>g" = "LSP Goto";
          "<leader>f" = "Telescope Actions";
        };
      };
    };
  };


}


