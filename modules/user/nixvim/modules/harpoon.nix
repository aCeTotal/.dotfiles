{ ... }:


{
  programs.nixvim = {
    plugins = {
      harpoon = {
        enable = true;
        enableTelescope = true;
        saveOnToggle = true;

        keymaps = {
          addFile = "<leader>a";
          toggleQuickMenu = "<C-e>";
          navFile = {
            "1" = "<C-j>";
            "2" = "<C-k>";
            "3" = "<C-l>";
            "4" = "<C-m>";
          };
        };
      };
    };
  };
}


