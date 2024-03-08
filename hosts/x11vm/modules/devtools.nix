{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
	  jetbrains
	  jetbrains.rider
	  vscode-with-extensions
	  nodejs_21
	  dotnet-sdk_8
	  mono5
    ];

}
