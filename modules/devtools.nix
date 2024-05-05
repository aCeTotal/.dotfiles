{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
	  direnv
	  #jetbrains.rider
	  #vscode-with-extensions
	  #nodejs_21
	  #dotnet-sdk_8
	  #mono5
    ];

    services.lorri.enable = true;

}
