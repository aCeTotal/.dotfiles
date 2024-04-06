{ config, pkgs, inputs, ... }:


{

  imports =
    [
      inputs.nixvim.homeManagerModules.nixvim
    ];


  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    colorschemes.dracula.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      Ionide-vim
    ];
    
    plugins = {
      nvim-autopairs.enable = true;
      bufferline.enable = true;
      luasnip.enable = true;
      lightline.enable = true;
      rust-tools.enable = true;

      startup = { 
	      enable = true;
	      theme = "evil";
	      userMappings = {
	      "<leader>ff" = "<cmd>Telescope find_files<CR>";
	      "<leader>s"  = "<cmd>Telescope live_grep<CR>";
	      };
      };

      airline = {
	      enable = true;
      	powerlineFonts = true;
      };

      coq-nvim = {
        enable = true;
        installArtifacts = true;
      };

      comment-nvim = {
        enable = true;
      };

      gitsigns = {
	      enable = true;
	      currentLineBlame = true;
      };

      nvim-tree = {
	      enable = true;
	      openOnSetupFile = true;
      	autoReloadOnWrite = true;
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>fg" = "live_grep";
          "<C-p>" = {
            action = "git_files";
            desc = "Telescope Git Files";
          };
      };
      extensions.fzf-native = { enable = true; };
    };

    toggleterm = {
      enable = true;
      openMapping = "<C-t>";
      direction = "horizontal";
    };

    wilder = {
      enable = true;
      modes = [ ":" "/" "?" ];
    };

    treesitter = {
      enable = true;
      nixGrammars = true;
      indent = true;
    };
    treesitter-context.enable = true;
    rainbow-delimiters.enable = true;

    lsp = {
	    enable = true;
	    servers = {
	      bashls.enable = true;
	      clangd.enable = true;
	      elixirls.enable = true;
	      fsautocomplete.enable = true;
	      gopls.enable = true;
	      kotlin-language-server.enable = true;
	      nixd.enable = true;
        nil_ls.enable = true;
	      ruff-lsp.enable = true;
        tsserver.enable = true;
	      lua-ls.enable = true;
	      rust-analyzer = {
	        enable = true;
	        installRustc = true;
	        installCargo = true;
	      };
	      html.enable = true;
	      ccls.enable = true;
	      cmake.enable = true;
	      csharp-ls.enable = true;
	      cssls.enable = true;
	      jsonls.enable = true;
	      pyright.enable = true;
	      tailwindcss.enable = true;
	  };

	keymaps.lspBuf = {
	  "gd" = "definition";
	  "gD" = "references";
	  "gt" = "type_definition";
	  "gi" = "implementation";
	  "K" = "hover";
	};
      };

  none-ls = {
	  enable = true;
	    sources = {
	      diagnostics = {
	      golangci_lint.enable = true;
	      ktlint.enable = true;
	      shellcheck.enable = true;
	      statix.enable = true;
	      };
	      formatting = {
	        fantomas.enable = true;
	        gofmt.enable = true;
	        goimports.enable = true;
	        ktlint.enable = true;
	        markdownlint.enable = true;
	        rustfmt.enable = true;
	      };
      };
  };



      cmp-buffer.enable = true;
      cmp-emoji.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;

      nvim-cmp = {
      enable = true;
      autoEnableSources = true;
      sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "buffer"; }
        { name = "nvim_lua"; }
        { name = "path"; }
      ];

      formatting = {
        fields = [ "abbr" "kind" "menu" ];
        format =
          # lua
          ''
            function(_, item)
              local icons = {
                Namespace = "󰌗",
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰆧",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈚",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰊄",
                Table = "",
                Object = "󰅩",
                Tag = "",
                Array = "[]",
                Boolean = "",
                Number = "",
                Null = "󰟢",
                String = "󰉿",
                Calendar = "",
                Watch = "󰥔",
                Package = "",
                Copilot = "",
                Codeium = "",
                TabNine = "",
              }

              local icon = icons[item.kind] or ""
              item.kind = string.format("%s %s", icon, item.kind or "")
              return item
            end
          '';
      };

      snippet = { expand = "luasnip"; };

      window = {
        completion = {
          winhighlight =
            "FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel";
          scrollbar = true;
          sidePadding = 0;
          border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
        };

        documentation = {
          border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
          winhighlight =
            "FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel";
        };
      };

      mapping = {
        "<C-n>" = "cmp.mapping.select_next_item()";
        "<C-p>" = "cmp.mapping.select_prev_item()";
        "<C-j>" = "cmp.mapping.select_next_item()";
        "<C-k>" = "cmp.mapping.select_prev_item()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.close()";
        "<CR>" =
          "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
        "<Tab>" = {
          modes = [ "i" "s" ];
          action =
            # lua
            ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif require("luasnip").expand_or_jumpable() then
                  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
                else
                  fallback()
                end
              end
            '';
        };
        "<S-Tab>" = {
          modes = [ "i" "s" ];
          action =
            # lua
            ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif require("luasnip").jumpable(-1) then
                  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
                else
                  fallback()
                end
              end
            '';
        };
      };
    };

    auto-save = {
	    enable = true;
	    enableAutoSave = true;
    };

    };

    globals.mapleader = " "; # Sets the leader key to space

    extraConfigLua = ''
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>s', function()
      vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end)
    '';

    extraConfigVim = ''
      set noshowmode
      set showtabline=2
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>tf";
        options.silent = false;
        action = "<cmd>Ex<CR>";
      }

      {
        mode = "n";
        key = "<leader>f";
        options.silent = false;
        action = "<cmd>NvimTreeToggle<CR>";
      }

      # Default mode is "" which means normal-visual-op
      {
	# Toggle NvimTree
	key = "<C-n>";
	action = "<CMD>NvimTreeToggle<CR>";
      }
      {
	# Format file
	key = "<space>fm";
	action = "<CMD>lua vim.lsp.buf.format()<CR>";
      }

      # Terminal Mappings
      {
	# Escape terminal mode using ESC
	mode = "t";
	key = "<esc>";
	action = "<C-\\><C-n>";
      }

      # Rust
      {
	# Start standalone rust-analyzer (fixes issues when opening files from nvim tree)
	mode = "n";
	key = "<leader>rs";
	action = "<CMD>RustStartStandaloneServerForBuffer<CR>";
      }

    ];

    options = {
      updatetime = 100; # Faster completion

      number = true;
      relativenumber = true;

      autoindent = true;
      clipboard = "unnamedplus";
      expandtab = true;
      shiftwidth = 2;
      smartindent = true;
      tabstop = 2;
      cursorline = true;

      termguicolors = true;
      scrolloff = 4;

      ignorecase = true;
      incsearch = true;
      smartcase = true;
      wildmode = "list:longest";

      swapfile = false;
      undofile = true; # Build-in persistent undo
    };

  };

}

