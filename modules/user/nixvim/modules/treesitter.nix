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
          indent.enable = true;
          highlight.enable = true;
          nixvimInjections = true;
          grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;
        };
      };
      treesitter-refactor = {
        enable = true;
        highlightDefinitions = {
          enable = true;
          # Set to false if you have an `updatetime` of ~100.
          clearOnCursorMove = false;
        };
      };
    };
  };
}


