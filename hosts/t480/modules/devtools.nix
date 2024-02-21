{ config, pkgs, ... }:

{

      home.packages = with pkgs; [
	jetbrains.datagrip
	jetbrains.rider
	vscode-with-extensions
	nodejs_21
	dotnet-sdk_8
	mono5
    ];

}
