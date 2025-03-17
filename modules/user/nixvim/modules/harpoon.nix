{ ... }:


{
  programs.nixvim = {
    plugins = {
      harpoon = {
        enable = true;
        enableTelescope = true;
        saveOnToggle = true;
      };
    };
  };
}


