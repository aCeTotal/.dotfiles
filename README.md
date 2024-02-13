[Work-In-Progress]

1. If you are not ME and you want to use my flake, you SHOULD fork this repo right away and make it your own. You will need to have your own git repo to make your system reproducible.
2. Make sure your BIOS is set to only use UEFI and Secure Boot disabled.
3. Boot up the latest minimal NixOS-image.
4. Change the keyboard layout with: sudo loadkeys no-latin1 (Norwegian layout).
5. bash <(curl -sL bit.ly/totalnix)
6. Install the base-system and log in. (pw=nixos)
7. Change directory into .dotfiles
8. then run: sudo nixos-rebuild switch --flake .#systemconf .Eg. desktop, laptop or htpc. (Pst. Make your own config, you dont want to use the same stuff as me.)
9. Reboot.
