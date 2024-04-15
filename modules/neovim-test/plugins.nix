{ pkgs, ... }: {
  imports = [
    ./plugins/alpha.nix
    ./plugins/molten.nix
    ./plugins/hlslens.nix
    ./plugins/ranger.nix
    ./plugins/completion.nix
    ./plugins/treesitter.nix
    ./plugins/lsp.nix
    ./plugins/lspsaga.nix
    ./plugins/ui/default.nix
    ./plugins/nvim-tree.nix
    ./plugins/autosave.nix
    ./plugins/autopairs.nix
    ./plugins/telescope.nix
    ./plugins/cmp.nix
    ./plugins/knap.nix
    # ./plugins/fold-preview.nix
    ./plugins/distant.nix
    ./plugins/search-and-replace.nix
    ./plugins/code-window.nix
    ./plugins/conjure.nix
    ./plugins/scrollbars.nix
    ./plugins/navic.nix
  ];

  extraPlugins = with pkgs.vimPlugins; [
    # Treesitter
    nvim-treesitter-textobjects

    # Markdown
    vim-pandoc-syntax

    # Calendar
    calendar-vim

    # UI
    hologram-nvim

    # Code Interaction
    codi-vim
    vim-dispatch-neovim
    vim-jack-in
    vim-dispatch
    vim-sexp
    vim-sexp-mappings-for-regular-people
    tabular
    suda-vim
    plantuml-syntax
    lsp-colors-nvim
    vim-table-mode
    csv-vim
    nvim-notify
    rnvimr
    vim-snippets
    SchemaStore-nvim
    git-blame-nvim
    ansible-vim
    popup-nvim
    plenary-nvim
    nvim-ts-autotag

    # Language and Completion
    impatient-nvim
    flit-nvim
    nvim-FeMaco-lua
    vim-smoothie
    aniseed

    # vim-pluto
    nvim-treesitter-textsubjects
    plantuml-previewer-vim
    open-browser-vim
    nvim-unception
    mind-nvim
    nabla-nvim
    image-nvim
    neorepl-nvim
    nvim-julia-autotest
  ];

  # "frabjous/knap" --
  # "David-Kunz/markid"
  # "anuvyklack/fold-preview.nvim"
  # "chipsenkbeil/distant.nvim"
  # "RRethy/nvim-treesitter-textsubjects"
  # "weirongxu/plantuml-previewer.vim"
  # "anuvyklack/pretty-fold.nvim"
  # "samjwill/nvim-unception"
  # "phaazon/mind.nvim"
  # "s1n7ax/nvim-search-and-replace"
  # "jbyuki/nabla.nvim" # Need to add
  # "samodostal/image.nvim"
  # "gorbit99/codewindow.nvim"
  # "ii14/neorepl.nvim"
  # "https://gitlab.com/usmcamp0811/nvim-julia-autotest"
  # TODO:
  # "bytesnake/vim-graphical-preview"
  plugins = {
    # Git Integration
    gitsigns.enable = true;

    # Markdown and Preview
    markdown-preview.enable = true;
    surround.enable = true;

    # Other Utilities
    auto-save.enable = true;
    diffview.enable = true;
    mini.enable = true;
    wilder = { enable = true; };

    # Neorg Configuration
    neorg = {
      enable = true;
      modules = {
        "core.defaults" = { __empty = null; };
        "core.summary" = { __empty = null; };
        "core.concealer" = { __empty = null; };
        # "core.completion".config.engine = "nvim-cmp";
        "core.dirman" = {
          config = {
            workspaces = {
              home = "~/notes/home";
              work = "~/notes/work";
            };
          };
        };
      };
    };
  };
}

