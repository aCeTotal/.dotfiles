{ ... }:


{
  programs.nixvim = {
    plugins = {
      transparent = {
        enable = true;
        autoLoad = true;
      };
    };
  };
}


