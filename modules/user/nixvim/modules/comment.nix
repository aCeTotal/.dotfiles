{ ... }:


{
  programs.nixvim = {
    plugins = {
      comment = {
        enable = true;
        autoLoad = true;
        settings = {
          opleader.line = "<C-b>";
          toggler.line = "<C-b>";
        };
      };
    };
  };
}


