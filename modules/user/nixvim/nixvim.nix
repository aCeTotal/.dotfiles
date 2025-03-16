{ inputs, ... }:


{

  imports =
    [
      inputs.nixvim.homeManagerModules.nixvim
      #./modules/options.nix
      #./modules/cmp.nix
      #./modules/lsp.nix
      #./modules/treesitter.nix
      #./modules/telescope.nix
      #./modules/lualine.nix
      #./modules/colorscheme.nix
      #./modules/lspkind.nix
      #./modules/lspsaga.nix
      #./modules/which-key.nix
      #./modules/lazygit.nix
      #./modules/worktree.nix
      #./modules/indent-blankline.nix

      ./modules/barbar.nix
      ./modules/comment.nix
      ./modules/completion.nix
      ./modules/dap.nix
      ./modules/extraConfig.zsh
      ./modules/gitblame.nix
      ./modules/harpoon.nix
      ./modules/image.nix
      ./modules/indent-o-matic.nix
      ./modules/keymappings.nix
      ./modules/lazygit.nix
      ./modules/lint.nix
      ./modules/lsp.nix
      ./modules/lualine.nix
      ./modules/markdown-preview.nix
      ./modules/neoscroll.nix
      ./modules/nix.nix
      ./modules/noice.nix
      ./modules/oil.nix
      ./modules/options.nix
      ./modules/packer.nix
      ./modules/tagbar.nix
      ./modules/telescope.nix
      ./modules/tree-sitter.nix
      ./modules/trouble.nix
      ./modules/web-devicons.nix
      ./modules/which-key.nix
    ];



  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}


