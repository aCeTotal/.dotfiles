{ config, pkgs, inputs, ... }:


{

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
	padding.x = 15;
	padding.y = 15;
	decorations = "none";
	startup_mode = "Windowed";
	dynamic_title = true;
	opacity = 0.6;
      };
      cursor = {
	style = {
	  shape = "Beam";
	  blinking = "On";
	};
      };
      live_config_reload = true;
      font = {
	normal.family = "JetBrainsMono NFM";
	bold.family = "JetBrainsMono NFM";
	italic.family = "JetBrainsMono NFM";
	bold_italic.family = "JetBrainsMono NFM";
	size = 14;
      };
      colors = {
	bright = {
	  black = "#585B70";
	  blue = "#89B4FA";
	  cyan = "#94E2D5";
	  green = "#A6E3A1";
	  magenta = "#F5C2E7";
	  red = "#F38BA8";
	  white = "#A6ADC8";
	  yellow = "#F9E2AF";
	};
	cursor = {
	  cursor = "#F5E0DC";
	  text = "#1E1E2E";
	};
	normal = {
	  black = "#45475A";
	  blue = "#89B4FA";
	  cyan = "#94E2D5";
	  green = "#A6E3A1";
	  magenta = "#F5C2E7";
	  red = "#F38BA8";
	  white = "#BAC2DE";
	  yellow = "#F9E2AF";
	};
	primary = {
	  background = "#1E1E2E";
	  foreground = "#CDD6F4";
	};
	draw_bold_text_with_bright_colors = true;
      };
    };
  };


}

