{
	programs.nixvim = {
     colorschemes = {
        rose-pine = {
          enable = true;
          style = "moon"; #  "main", "moon", "dawn" or raw lua code
          disableItalics = false;
          transparentFloat = true;
          transparentBackground = true;
        };
        catppuccin = {
          enable = false;
          background = {
          light = "macchiato";
          dark = "mocha";
          };
        };
    };
 };
}
