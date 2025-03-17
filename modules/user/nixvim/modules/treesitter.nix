{ pkgs, ... }:


{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        autoLoad = true;
        settings = {
          ensureInstalled = "all";
          folding = true;
          nixvimInjections = true;
          grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;
        };
      };
    };
  };
}


