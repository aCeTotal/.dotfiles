{ ... }:

{

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        theme.enable = true;
        theme.name = "tokyonight";
        theme.style = "night";

        withNodeJs = true;
        presence.neocord.enable = true;
        notes.todo-comments.enable = true;
        git.gitsigns.enable = true;
        autopairs.nvim-autopairs.enable = true;
        statusline.lualine.enable = true;
        comments.comment-nvim.enable = true;
        debugger.nvim-dap.enable = true;
        debugger.nvim-dap.ui.enable = true;
        debugger.nvim-dap.ui.autoStart = true;
        git.vim-fugitive.enable = true;
        treesitter.indent.enable = true;
        telescope.enable = true;

        terminal.toggleterm = {
          enable = true;
          lazygit.enable = true;
        };

        autocomplete.nvim-cmp = {
          enable = true;
          sources = {
            "nvim_lsp" = "[LSP]";
            "path" = "[Path]";
            "buffer" = "[Buffer]";
          };
        };

        languages = {
          enableLSP = true;
          enableFormat = true;
          enableDAP = true;
          enableTreesitter = true;

          nix = {
            enable = true;
            format.type = "alejandra";
          };
          ts.enable = true;
          rust.enable = true;
          python.enable = true;
          markdown.enable = true;
          lua.enable = true;
          html.enable = true;
          bash.enable = true;
          clang.enable = true;
          csharp.enable = true;
          css.enable = true;
          php.enable = true;
          go.enable = true;
          sql.enable = true;
          assembly.enable = true;
          java.enable = true;
        };
        options = {
          updatetime = 100;
          autoindent = true;
          shiftwidth = 2;
          termguicolors = true;
        };
        globals.mapleader = " ";
        maps = {
          normal = {
            "<leader>pv".action = "<cmd>Ex<CR>";
            "<leader>ff".action = "<cmd>Telescope find_files<CR>";
            "<leader>fp".action = "<cmd>Telescope git_files<CR>";
            "<leader>ps".action = "<cmd>Telescope live_grep<CR>";
            "<leader>gs".action = "<cmd>Git<CR>";
          };
        };
        lsp.mappings = {
          goToDefinition = "<leader>d";
          listImplementations = "<leader>i";
          listReferences = "<leader>r";
          nextDiagnostic = "<leader>nd";
          previousDiagnostic = "<leader>pd";
          renameSymbol = "<leader>ln";
        };
        debugger.nvim-dap.mappings = {
          continue = "<leader>dc";
          goDown = "<leader>dd";
          goUp = "<leader>du";
          hover = "<leader>dh";
          restart = "<leader>dR";
          runLast = "<leader>d.";
          runToCursor = "<leader>dg";
          stepBack = "<leader>dgk";
          stepInto = "<leader>dgi";
          stepOut = "<leader>dgo";
          stepOver = "<leader>dgj";
          terminate = "<leader>dq";
          toggleBreakpoint = "<leader>b";
          toggleDapUI = "<leader>du";
          toggleRepl = "<leader>dr";
        };
      };
    };
  };
}

