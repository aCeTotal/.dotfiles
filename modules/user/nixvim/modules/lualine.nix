{ ... }:


{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        globalstatus = true;
        disabledFiletypes = {
          statusline = ["dashboard" "alpha"];
        };
      };
    };
  };
}
