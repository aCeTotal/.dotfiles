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
        vim.navigation.harpoon.enable = true;
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
          css.enable = true;
          go.enable = true;
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
          };
        };
      };
    };
  };
}

