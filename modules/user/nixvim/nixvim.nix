{ inputs, ... }:


{

  imports =
    [
      inputs.nixvim.homeManagerModules.nixvim
      ./modules/options.nix
      ./modules/cmp.nix
      ./modules/lsp.nix
      ./modules/treesitter.nix
      ./modules/telescope.nix
      ./modules/lualine.nix
      ./modules/colorscheme.nix
      ./modules/lspkind.nix
      ./modules/lspsaga.nix
      ./modules/lazygit.nix
      #./modules/worktree.nix
      ./modules/indent-blankline.nix
      ./modules/autosave.nix
      ./modules/autoclose.nix
      ./modules/comment.nix
      ./modules/gx.nix
      ./modules/harpoon.nix
      ./modules/transparent.nix
    ];



  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

}


