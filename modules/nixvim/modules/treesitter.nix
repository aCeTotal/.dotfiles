{ config, pkgs, inputs, ... }:


{


    programs.nixvim = {

    plugins = {
      treesitter = {
        enable = true;
        indent = true;
        folding = true;
        nixvimInjections = true;
        grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;
      };
      treesitter-context.enable = true;
      rainbow-delimiters.enable = true;

      treesitter-textobjects = {
        enable = false;
          select = {
          enable = true;
          lookahead = true;
            keymaps = {
              "aa" = "@parameter.outer";
              "ia" = "@parameter.inner";
              "af" = "@function.outer";
              "if" = "@function.inner";
              "ac" = "@class.outer";
              "ic" = "@class.inner";
              "ii" = "@conditional.inner";
              "ai" = "@conditional.outer";
              "il" = "@loop.inner";
              "al" = "@loop.outer";
              "at" = "@comment.outer";
            };
          };
        move = {
          enable = true;
          gotoNextStart = {
            "]m" = "@function.outer";
            "]]" = "@class.outer";
          };
          gotoNextEnd = {
            "]M" = "@function.outer";
            "][" = "@class.outer";
          };
          gotoPreviousStart = {
            "[m" = "@function.outer";
            "[[" = "@class.outer";
          };
          gotoPreviousEnd = {
            "[M" = "@function.outer";
            "[]" = "@class.outer";
          };
        };
        swap = {
          enable = true;
          swapNext = {
            "<leader>a" = "@parameters.inner";
          };
          swapPrevious = {
            "<leader>A" = "@parameter.outer";
          };
        };
     };
    };

      filetype = {
        extension = {
          liq = "liquidsoap";
        };
      };
      extraConfigLua = ''
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

        parser_config.liquidsoap = {
        filetype = "liquidsoap",
        }
      '';
  };
}


