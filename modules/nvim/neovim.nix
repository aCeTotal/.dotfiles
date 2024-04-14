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
            config = toLuaFile ./lua/lsp.lua;
          }

          {
            plugin = comment-nvim;
            config = toLua "require(\"Comment\").setup()";
          }

          {   
            plugin = gruvbox-nvim;
            config = "colorscheme gruvbox";
          }
          nvim-lsputils

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
