{ config, pkgs, inputs, ... }:


{
  programs.nixvim = {
    # To find and replace, use grep find, look up whatever the item you want to look up, than ctrl-q for quick fix

    keymaps = [ ];
    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>ff" = {
          action = "find_files";
          desc = "Telescope Fild Files";
        };
        "<leader>fg" = {
          action = "live_grep";
          desc = "Telescope Live Grep";
        };
        "<leader>fb" = {
          action = "buffers";
          desc = "Telescope Open Buffers";
        };
        "<leader>fh" = {
          action = "help_tags";
          desc = "Telescope Help Tags";
        };
        #"<C-p>" = {
        #  action = "git_files";
        #  desc = "Telescope Git Files";
        #};
      };
      extensions.fzf-native = { enable = true; };
    };
  };
}


