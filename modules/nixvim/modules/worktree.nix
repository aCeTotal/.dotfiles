{ config, pkgs, inputs, lib, ... }:


{
  programs.nixvim.plugins.git-worktree = {
    enable = true;
    enableTelescope = true;
  };
}
