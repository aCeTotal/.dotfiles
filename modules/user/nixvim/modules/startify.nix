{ ... }:


{
  programs.nixvim = {
    plugins = {
      startify = {
        enable = true;
        settings = {
          custom_header = [
            ""
              "     ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
              "     ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
              "     ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
              "     ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
              "     ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
              "     ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
          ];

          change_to_dir = false;

          use_unicode = true;

          lists = [ { type = "dir"; } ];
          files_number = 30;

          skiplist = [
            "flake.lock"
          ];
        };
      };
    };
  };
}


