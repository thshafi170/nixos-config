{ config, pkgs, lib, ... }:

let
  # QEMU and KVM related packages
  qemuPackages = with pkgs; [
    qemu qemu_kvm qemu-user qemu-utils
  ];

  # OVMF firmware packages
  ovmfPackages = with pkgs; [
    OVMFFull
  ];

  # Guest management tools
  guestTools = with pkgs; [
    libguestfs libguestfs-appliance python312Packages.guestfs
  ];

  # Container tools
  containerTools = with pkgs; [
    boxbuddy distrobox_git
  ];

  # Android emulation
  androidTools = with pkgs; [
    waydroid-helper
  ];

  # Additional utilities
  utilityTools = with pkgs; [
    swtpm wl-clipboard
  ];

  # All virtualization packages
  virtualizationPackages = qemuPackages ++ ovmfPackages ++ guestTools
                         ++ containerTools ++ androidTools ++ utilityTools;

in {
  virtualisation = {
    # KVM/QEMU virtualization
    libvirtd = {
      enable = true;
      qemu = {
        runAsRoot = true;
        vhostUserPackages = with pkgs; [ virtiofsd ];
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [(pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd];
        };
      };
    };

    # USB redirection for VMs
    spiceUSBRedirection.enable = true;

    # Container support
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enable = true;
    };

    # Android emulation
    waydroid.enable = true;
  };

  # Virtual machine manager
  programs.virt-manager.enable = true;

  # Install virtualization packages
  environment.systemPackages = virtualizationPackages;
}
