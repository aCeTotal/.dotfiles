{ config, pkgs, inputs, ... }:


{
  programs.nixvim = {

    plugins.telescope = {
      enable = true;
      extensions = {
        fzf-native = {
          enable = true;
        };
      };
      settings.defaults = {
        layout_config = {
          horizontal = {
            prompt_position = "top";
          };
        };
        sorting_strategy = "ascending";
      };
    };
    plugins.web-devicons = {
      enable = true;
    };
    extraConfigLua = ''
      require("telescope").setup{
        pickers = {
          colorscheme = {
            enable_preview = true
          }
        }
      }
    '';
  };
}


