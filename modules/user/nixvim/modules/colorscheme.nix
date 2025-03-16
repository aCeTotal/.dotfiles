{
  programs.nixvim = {
    colorschemes = {
      rose-pine = {
        enable = true;
        settings = {
          style = "moon"; #  "main", "moon", "dawn" or raw lua code
          disableItalics = false;
          transparentFloat = true;
          transparentBackground = true;
        };
      };
    };
  };
}
