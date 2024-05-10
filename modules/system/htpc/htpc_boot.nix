{ pkgs, ... }:

{
    #home.file.".config/xxx/xxx.conf".text = ''
    #'';

    #home.packages = with pkgs; [
    #];

# Boot Loader
    boot = {
        loader = {
            efi = {
                canTouchEfiVariables = true;
                efiSysMountPoint = "/boot";
            };
            grub = {
                enable = true;
                efiSupport = true;
                devices = [ "nodev" ];
                configurationLimit = 4;
            };
            timeout = 1;
        };


# Kernel Options
    kernel.sysctl = {
        "kernel.sysrq" = 1;                             # SysRQ for is rebooting their machine properly if it freezes: SOURCE: https://oglo.dev/tutorials/sysrq/index.html
            "net.core.rmem_default" = 1073741824;           # Default socket receive buffer size, improve network performance & applications that use sockets
            "net.core.rmem_max" = 1073741824;               # Maximum socket receive buffer size, determin the amount of data that can be buffered in memory for network operations
            "net.core.wmem_default" = 1073741824;           # Default socket send buffer size, improve network performance & applications that use sockets
            "net.core.wmem_max" = 1073741824;               # Maximum socket send buffer size, determin the amount of data that can be buffered in memory for network operations
            "net.ipv4.tcp_rmem" = "4096 87380 1073741824";  # 1 GiB max
            "net.ipv4.tcp_wmem" = "4096 87380 1073741824";  # 1 GiB max
            "net.ipv4.tcp_keepalive_intvl" = 30;            # TCP keepalive interval between probes, TCP keepalive probes, which are used to detect if a connection is still alive.
            "net.ipv4.tcp_keepalive_probes" = 5;            # TCP keepalive probes, TCP keepalive probes, which are used to detect if a connection is still alive.
            "net.ipv4.tcp_keepalive_time" = 300;            # TCP keepalive interval (seconds), TCP keepalive probes, which are used to detect if a connection is still alive.
            "vm.dirty_background_bytes" = 268435456;        # 256 MB in bytes, data that has been modified in memory and needs to be written to disk
            "vm.dirty_bytes" = 1073741824;                  # 1 GB in bytes, data that has been modified in memory and needs to be written to disk
            "vm.min_free_kbytes" = 65536;                   # Minimum free memory for safety (in KB), can help prevent memory exhaustion situations
            "vm.swappiness" = 1;                            # how aggressively the kernel swaps data from RAM to disk. Lower values prioritize keeping data in RAM,
            "vm.vfs_cache_pressure" = 50;                   # Adjust vfs_cache_pressure (0-1000), how the kernel reclaims memory used for caching filesystem objects
            "fs.aio-max-nr" = 1048576;                      # defines the maximum number of asynchronous I/O requests that can be in progress at a given time.
            "kernel.pid_max" = 4194304;                     # allows a large number of processes and threads to be managed
            "net.ipv4.tcp_congestion_control" = "bbr";
            "net.core.default_qdisc" = "fq";
            "vm.max_map_count" = 16777216;                  # Star Citizen Requirements
            "fs.file-max" = 524288;                         # Star CItizen Requirements
    };

# BOOT settings
    supportedFilesystems = [ "btrfs" "ntfs" ];
    kernelModules = [ "btrfs" "tcp_bbr" ];
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_stable.xone;
    tmp.cleanOnBoot = true;
    modprobeConfig.enable = true;
    extraModprobeConfig = ''
        ''; 

  };

#home.file.".config/xxx/xxx.conf".text = ''
#'';

#home.packages = with pkgs; [
#];

}
