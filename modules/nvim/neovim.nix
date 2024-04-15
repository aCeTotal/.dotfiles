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
        ${builtins.readFile ./lua/icons.lua}
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
            plugin = nvim-treesitter.withAllGrammars;
            config = toLuaFile ./lua/plugins/treesitter.lua;
          }

          #indentLine
          cmp_luasnip
          telescope-fzf-native-nvim
          vim-nix
          cmp-vsnip
          nvim-cmp
          neodev-nvim
          cmp-nvim-lsp

          luasnip
          friendly-snippets
        ];



  };

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    home.packages = with pkgs; [
      ripgrep
      nixd
      csharp-ls
      clang-tools clang
      stylua
      pyright
      dockerfile-language-server-nodejs
      luajitPackages.lua-lsp
      cmake-language-server
    ];
}
