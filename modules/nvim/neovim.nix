{ config, pkgs, lib, ... }:

{

  #home.file.".config/nvim/settings.lua".source = nvim/lua/init.lua;


  programs.neovim = {
  	    enable = true;
	      viAlias = true;
	      vimAlias = true;
        vimdiffAlias = true;
        package = pkgs.neovim-unwrapped;
        extraConfig = ''
        '';

                plugins = with pkgs.vimPlugins; [ 
                  vim-nix
                  indentLine
                  nvim-compe
                {
                    plugin = impatient-nvim;
                    config = "lua require('impatient')";
                }
                {
                    plugin = lualine-nvim;
                    config = "lua require('lualine').setup()";
                }
                {
                    plugin = telescope-nvim;
                    config = "lua require('telescope').setup()";
                }

                {
                    plugin = nvim-lspconfig;
                    config = ''
                        lua << EOF
                        require('lspconfig').dockerls.setup{}
                        require('lspconfig').clangd.setup{}
                        require('lspconfig').csharp_ls.setup{}
                        require('lspconfig').cmake.setup{}
                        require('lspconfig').lua_ls.setup{}
                        require('lspconfig').rust_analyzer.setup{}
                        require('lspconfig').pyright.setup{}

                        vim.o.completeopt = "menuone,noselect"

                        require('compe').setup {
                          enabled = true;
                          autocomplete = true;
                          debug = true;
                          min_length = 1;
                          preselect = 'enable';
                          throttle_time = 80;
                          source_timeout = 200;
                          incomplete_delay = 400;
                          max_abbr_width = 100;
                          max_kind_width = 100;
                          max_menu_Width = 100;
                          documentation = true;

                          source = {
                            path = true;
                            buffer = true;
                            vsnip = true;
                            nvim_lsp = true;
                            nvim_lua = true;
                            tags = true;
                            snippets_nvim = true;
                            treesitter = true;
                          };
                        };
 
                        EOF
                    '';
                }
                {
                    plugin = nvim-treesitter.withAllGrammars;
                    config = ''
                    lua << EOF
                      require('nvim-treesitter.configs').setup {
                        highlight = {
                            enable = true,
                            additional_vim_regex_highlighting = true,
                        },
                    }
                    EOF
                    '';
                }
            ];



  };

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    home.packages = with pkgs; [
      ripgrep
      csharp-ls
      clang-tools clang
      stylua
      pyright
      dockerfile-language-server-nodejs
      lua-language-server
      cmake-language-server
    ];
}
