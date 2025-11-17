{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot = {
    # CachyOS kernel from Chaotic Nyx
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
    };

    # Resume device for hibernation support
    resumeDevice = "/dev/disk/by-uuid/14b6e8da-d76f-4d6d-af2d-199ef907585c";

    # Kernel boot parameters
    kernelParams = [
      "nowatchdog"
      "quiet"
      "splash"
      "loglevel=3"
      "preempt=full"
      "resume_offset=533760"
      "psi=1"
      "intel_iommu=on"
      "iommu=pt"
    ];

    # KVM configuration
    extraModprobeConfig = ''
      options kvm_intel nested=1
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
    scheduler = "scx_rustland";
  };
}
