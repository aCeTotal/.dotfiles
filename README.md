1. Make sure your BIOS is set to only use UEFI and Secure Boot disabled.
2. Boot up the latest minimal NixOS-image.
3. Change the keyboard layout with: sudo loadkeys no-latin1 (Norwegian layout).
4. bash <(curl -sL bit.ly/totalnix)
5. Install the base-system and log in. (pw=nixos)
6. Change directory into .dotfiles
7. then run: sudo nixos-rebuild switch --flake .#systemconf .Eg. desktop, laptop or htpc. (Pst. Make your own config, you dont want to use the same stuff as me.)
8. Reboot.
