{ config, pkgs, lib, ... }:

{
    programs.neovim = 
      let
        toLua = str: "lua << EOF\n${str}\nEOF\n";
        toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
      in
    {
  	  enable = true;
	  viAlias = true;
	  vimAlias = true;
          vimdiffAlias = true;
          package = pkgs.neovim-unwrapped;
          extraConfig = ''
        '';

        extraLuaConfig = ''
          ${builtins.readFile ./lua/options.lua}
        '';

        plugins = with pkgs.vimPlugins; [
          {
            plugin = nvim-lspconfig;
            config = toLuaFile ./lua/plugins/lsp.lua;
          }

          {
            plugin = comment-nvim;
            config = toLua "require(\"Comment\").setup()";
          }

          {   
            plugin = gruvbox-nvim;
            config = "colorscheme gruvbox";
          }

          {
            plugin = nvim-cmp;
            config = toLuaFile ./lua/plugins/cmp.lua;
          }

          {
            plugin = telescope-nvim;
            config = toLuaFile ./lua/plugins/telescope.lua;
          }

          {
            plugin = (nvim-treesitter.withPlugins (p: [
              p.tree-sitter-nix
              p.tree-sitter-vim
              p.tree-sitter-bash
              p.tree-sitter-lua
              p.tree-sitter-python
              p.tree-sitter-json
            ]));
            config = toLuaFile ./lua/plugins/treesitter.lua;
          }

          cmp_luasnip
          vim-nix
          nvim-cmp
          neodev-nvim
          cmp-nvim-lsp

          luasnip
          friendly-snippets
          lualine-nvim
          nvim-web-devicons

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
