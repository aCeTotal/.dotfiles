{ ... }:


{
  programs.nixvim = {
    plugins = {
      gx = {
        enable = true;
        autoLoad = true;
      };
    };
  };
}


