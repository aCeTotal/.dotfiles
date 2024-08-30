{ config, pkgs, lib, ... }:

{

    imports = [
    ];


    programs.neovim = 
      let
        toLua = str: "lua << EOF\n${str}\nEOF\n";
        toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
      in
    {
              enable = true;
              defaultEditor = true;
	      viAlias = true;
	      vimAlias = true;
              vimdiffAlias = true;
              package = pkgs.neovim-unwrapped;
              extraConfig = ''
        '';

        extraLuaConfig = ''
          ${builtins.readFile ./lua/options.lua}
          ${builtins.readFile ./lua/remap.lua}
          ${builtins.readFile ./lua/colors.lua}
          ${builtins.readFile ./lua/plugins/cmp.lua}

        '';

        plugins = with pkgs.vimPlugins; [

          {
            plugin = telescope-nvim;
            config = toLuaFile ./lua/plugins/telescope.lua;
          }

          #{
          #  plugin = nvim-cmp;
          #  config = toLuaFile ./lua/plugins/cmp.lua;
          #}

          {
            plugin = nvim-lspconfig;
            config = toLuaFile ./lua/plugins/lsp.lua;
          }

          {
            plugin = harpoon;
            config = toLuaFile ./lua/plugins/harpoon.lua;
          }

          {
            plugin = nvim-treesitter.withAllGrammars;
            config = toLuaFile ./lua/plugins/treesitter.lua;
          }

          {
            plugin = vim-fugitive;
            #config = toLuaFile ./lua/plugins/fugitive.lua;
          }

          {
            plugin = lualine-nvim;
            config = toLuaFile ./lua/plugins/lualine.lua;
          }

          {
            plugin = nvim-autopairs;
            config = toLuaFile ./lua/plugins/autopairs.lua;
          }

          {
            plugin = autosave-nvim;
            config = toLuaFile ./lua/plugins/autosave.lua;
          }

          undotree
          telescope-fzf-native-nvim
          lazygit-nvim

          clangd_extensions-nvim

          #CMP
          nvim-cmp
          cmp-nvim-lsp
          cmp-nvim-lua
          cmp-cmdline
          cmp-buffer
          cmp-path
          cmp_luasnip

          luasnip
          lspkind-nvim
          nvim-lint
          vim-surround
          vim-obsession
          kommentary
          neoformat
          gitsigns-nvim
          rainbow
          vim-sleuth
          lualine-nvim
          nvim-web-devicons
          lightspeed-nvim
          leap-nvim
          vim-repeat
          kanagawa-nvim
          no-neck-pain-nvim

          friendly-snippets
          fidget-nvim

          ## Debugging
          nvim-dap
          nvim-dap-ui
          nvim-dap-virtual-text

          #Themes
          gruvbox-nvim
          rose-pine
          onedarkpro-nvim
          
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
      vscode-extensions.ms-vscode.cpptools
      vscode-extensions.sumneko.lua
    ];
}
