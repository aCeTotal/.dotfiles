{ config, pkgs, ... }:

{
    home.file.".config/libvirt/virbr0.xml".text = ''
        <network>
        <name>virbr0</name>
        <forward mode='bridge'/>
        <bridge name='virbr0'/>
        </network>
        '';

    home.packages = with pkgs; [
    ];

}
