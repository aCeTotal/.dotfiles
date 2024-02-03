1. If you are not ME and you want to use my lame flake, you SHOULD fork this repo right away and make it your own. You will need to have your own git repo before continuing from step 9.
2. Make sure your BIOS is set to only use UEFI and Secure Boot disabled.
3. Boot up the latest minimal NixOS-image.
4. Change the keyboard layout with: sudo loadkeys no-latin1 (Norwegian layout).
5. bash <(curl -sL bit.ly/totalnix)
6. Install the base-system and log in. (pw=nixos)
7. Open an terminal and run: upgrade (Upgrading to unstable to match the home-manager version).
8. Then run: installhome and logout.
9. Run: installhome again.
10. Change directory into .dotfiles
11. run: "home-manager switch -b backup --flake .#total" (or your own username if you have edited the flake. If the current system does have the same username as in the flake, you only need to run: "home-manager switch -b backup --flake ."
12. then run: sudo nixos-rebuild switch --flake .#systemconf
13. sudo reboot (Will fix this later).
