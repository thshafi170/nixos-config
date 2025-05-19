{ config, pkgs, lib, ...}:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelModules = [ "vfio-pci" "ntsync" "zram" ];
    kernel.sysctl."vm.max_map_count" = 2147483642;
    resumeDevice = "/dev/disk/by-uuid/cd757395-1892-47d2-869d-1ffc0c8df123";
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
    extraModprobeConfig = ''
      options kvm_intel nested=1
      options kvm_intel emulate_invalid_guest_state=0
      options kvm ignore_msrs=1 report_ignored_msrs=0
    '';
  }; 
  services.scx = {
    enable = true;
    package = pkgs.scx_git.full;
    scheduler = "scx_rustland";
  };
}
