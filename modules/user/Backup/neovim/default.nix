{ pkgs, ... }:
let

  treesitterWithGrammars = (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.comment
    p.css
    p.html
    p.php
    p.rust
    p.xml
    p.cmake
    p.make
    p.dockerfile
    p.gitignore
    p.query
    p.tsx
    p.svelte
    p.graphql
    p.prisma
    p.fish
    p.gitattributes
    p.gitignore
    p.go
    p.gomod
    p.gowork
    p.http
    p.hcl
    p.java
    p.javascript
    p.typescript
    p.jq
    p.json5
    p.json
    p.lua
    p.c
    p.cpp
    p.c_sharp
    p.hyprlang
    p.make
    p.markdown
    p.markdown_inline
    p.nix
    p.vim
    p.vimdoc
    p.python
    p.rust
    p.toml
    p.typescript
    p.vue
    p.yaml
    p.arduino
    p.todotxt
    p.ssh_config
    p.regex
    p.python
    p.perl
    p.gdshader
  ]));

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithGrammars.dependencies;
  };
in
{
  home.packages = with pkgs; [
    ripgrep
    fd
    lua-language-server
    rust-analyzer-unwrapped
    black
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    vimAlias = true;
    coc.enable = false;
    withNodeJs = true;

    plugins = [
      treesitterWithGrammars
    ];
  };

  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };

  home.file."./.config/nvim/lua/acetotal/init.lua".text = ''
    require("acetotal.options")
    require("acetotal.keymaps")
    vim.opt.runtimepath:append("${treesitter-parsers}")
  '';

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
  };

}
