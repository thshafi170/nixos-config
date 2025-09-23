{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot = {
    # CachyOS kernel from Chaotic Nyx - now properly accessed through pkgs
    kernelPackages = pkgs.linuxPackages_cachyos;

    # Load essential kernel modules at boot time
    kernelModules = [
      "vfio-pci"
      "ntsync"
      "zram"
    ];

    # Kernel runtime parameters (sysctl)
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
      # Additional optimizations for CachyOS kernel
      "kernel.sched_autogroup_enabled" = 0;
      "kernel.sched_cfs_bandwidth_slice_us" = 3000;
    };

    # Resume device for hibernation support
    resumeDevice = "/dev/disk/by-uuid/0ca281f0-ea77-4833-9552-8df1f81e387c";

    # Kernel boot parameters optimized for CachyOS kernel
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "preempt=full"
      "resume_offset=533760"
      "psi=1"
      "intel_iommu=on"
      "iommu=pt"
      # CachyOS specific optimizations
      "transparent_hugepage=madvise"
      "nowatchdog"
      "processor.max_cstate=1"
      "intel_idle.max_cstate=1"
    ];

    # KVM configuration
    extraModprobeConfig = ''
      options kvm_intel nested=1
      options kvm_intel emulate_invalid_guest_state=0
      options kvm ignore_msrs=1 report_ignored_msrs=0
    '';
  };

  # Configure sleep and hibernation behavior
  systemd.sleep.extraConfig = ''
    [Sleep]
    AllowSuspendThenHibernate=yes
    HibernateMode=shutdown
    HibernateDelaySec=3600
  '';

  # sched_ext configuration using scx_git from Chaotic Nyx
  services.scx = {
    enable = true;
    # Use the git version from Chaotic Nyx for latest features
    package = pkgs.scx_git.full;
    scheduler = "scx_rustland";
  };

  # Additional CachyOS optimizations
  environment.systemPackages = with pkgs; [
    # CachyOS specific tools if needed
    linuxPackages_cachyos.cpupower
    linuxPackages_cachyos.turbostat
  ];
}
