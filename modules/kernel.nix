{
  pkgs,
  ...
}:

{
  boot = {
    # Use CachyOS kernel as the default kernel
    kernelPackages = pkgs.linuxPackages_cachyos;

    # Load essential kernel modules at boot time
    kernelModules = [
      "vfio-pci"
      "ntsync"
      "zram"
    ];

    # Kernel runtime parameters (sysctl)
    kernel.sysctl."vm.max_map_count" = 2147483642;

    # Resume device for hibernation support
    resumeDevice = "Ignored for now";

    # Kernel boot parameters for optimization and hardware support
    kernelParams = [
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
      options kvm_intel emulate_invalid_guest_state=0
      options kvm ignore_msrs=1 report_ignored_msrs=0
    '';
  };

  # sched_ext configuration
  services.scx = {
    enable = true;
    package = pkgs.scx_git.full;
    scheduler = "scx_rusty";
  };
}
