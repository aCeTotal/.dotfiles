{ config, pkgs, inputs, ... }:


{

  imports =
    [
      inputs.nixvim.homeManagerModules.nixvim
      ./modules/options.nix
      ./modules/cmp.nix
      ./modules/lsp.nix
      ./modules/treesitter.nix
      #./modules/telescope.nix
      ./modules/luasnip.nix
      ./modules/lualine.nix
      #./modules/none-ls.nix
      ./modules/colorscheme.nix
      ./modules/lspkind.nix
      ./modules/lspsaga.nix
      ./modules/which-key.nix
      #./modules/lazygit.nix
      #./modules/worktree.nix
      #./modules/gitsigns.nix
      #./modules/conform.nix 
      ./modules/fidget.nix
      ./modules/indent-blankline.nix
    ];



  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;



    extraPlugins = with pkgs.vimPlugins; [
    ];

        # Keymaps
    keymaps = [

      ## Neotree Keymaps
      {
        action = "<cmd>Neotree toggle float<CR>";
        key = "<leader>E";
        options.desc = "Open/Close Neotree";
      }
      {
        action = "<cmd>NvimTreeToggle<CR>";
        key = "<leader>e";
        options.desc = "Open/Close Nvim-Tree";
      }
      {
        key = "<leader>cf";
        action = "<CMD>lua vim.lsp.buf.format()<CR>";
        options.desc = "Code Format";
      }
      {
        mode = "n";
        key = "<leader>rs";
        action = "<CMD>RustStartStandaloneServerForBuffer<CR>";
        options.desc = "Rust Start Standalone Server For Buffer";
      }
      {
        mode = "n";
        key = "<a-t>";
        action = "<CMD>ToggleTerm<CR>";
        options.desc = "Open/Close Terminal";
      }
      {
        mode = "n";
        key = "<leader>tg";
        action = "<CMD>LazyGit<CR>";
      }
      # {
      #   mode = "n";
      #   key = "<leader>t";
      #   action = "nil";
      #   options.desc = "Toggle";
      # }
    ];

    # Globals
    globals.mapleader = " ";

    # Plugins
    plugins = {

      ## luaSnips
      luasnip.enable = true;

      auto-save = {
        enable = true;
        enableAutoSave = true;
      };

      nvim-autopairs = {
        enable = true;
        enableMoveright = true;
        enableAfterQuote = true;
        enableBracketInQuote = true;
        enableCheckBracketLine = true;
        enableAbbr = true;
      };

      ## oil
      oil.enable = true;

      ts-autotag.enable = true;

      emmet.enable = true;

      nvim-colorizer.enable = true;

      vim-matchup = {
        enable = true;

        #delete (ds%)
        #change (cs%)
        enableSurround = true;
      };

      project-nvim.enable = true;

      rainbow-delimiters.enable = true;

      fugitive.enable = true;

      # obsidian = {
      #   enable = true;
      #   ui.enable = true;
      #   ui.updateDebounce = 500;
      # };

      lspsaga = {
        enable = true;
        lightbulb = {
          enable = false;
          # sign = true;
          # signPriority = 60;
          # debounce = 50;
        };
      };

    };
    
  };

  home.packages = with pkgs; [
    vscode-extensions.astro-build.astro-vscode
    vscode-langservers-extracted
    emmet-language-server

    # Developement
    # zig # For C compiler
    clang_17
    nodejs_21
    nodePackages_latest.nodejs
    nodePackages_latest.eslint_d
    nodePackages_latest.jsonlint
    selene
    checkstyle
    tree-sitter
    nil
    lua
    lua-language-server
    lua52Packages.luarocks-nix
    # To get Drizzle ORM studio to work in Brave Browser
    nss
    mkcert

    flyctl

    # Rust
    rustup
  ];


}


