{ config, pkgs, lib, ... }:

{

  programs.neovim = {
  	enable = true;
	viAlias = true;
	vimAlias = true;
        vimdiffAlias = true;
        extraConfig = builtins.concatStringsSep "\n" [
          ''
          luafile ${builtins.toString ../nvim/settings.lua}
          luafile ${builtins.toString ../nvim/line.lua}
          luafile ${builtins.toString ../nvim/lsp.lua}
          luafile ${builtins.toString ../nvim/ide.lua}
          luafile ${builtins.toString ../nvim/tabs.lua}
          luafile ${builtins.toString ../nvim/tree.lua}
          ''
        ];

      plugins = with pkgs.vimPlugins; [
        # Base
        popup-nvim
        plenary-nvim
        nvim-treesitter
        telescope-nvim
        vim-fugitive
        vim-markdown
        vim-trailing-whitespace
        vim-surround
        vim-which-key
        # Tabs
        barbar-nvim
        # EyeCandy
        wal-vim
        nvim-colorizer-lua
        nvim-cursorline
        nvim-web-devicons
        # Status Line
        lualine-nvim   
        # File tree
        nvim-tree-lua
        # Language
        vim-nix
        # LSP
        cmp-buffer
        cmp-nvim-lsp
        nvim-cmp
        nvim-compe
        nvim-lspconfig
    ];  

  };

    xdg.configFile = {
      nvim = {
        source = ../nvim;
        recursive = true;
      };
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
}
