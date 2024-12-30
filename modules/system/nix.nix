{ ... }:

{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      randomizedDelaySec = "14m";
      options = "--delete-older-than 10d";
    };
    settings = {
      max-jobs = 40;
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      substituters = [
          "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

}
