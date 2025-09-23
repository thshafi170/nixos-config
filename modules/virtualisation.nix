{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Virtualization services configuration
  virtualisation = {
    # KVM/QEMU virtualization with libvirt
    libvirtd = {
      enable = true;
      qemu = {
        runAsRoot = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
      };
    };

    spiceUSBRedirection.enable = true;
    containers.enable = true;
    waydroid.enable = true;

    # Podman container runtime
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enable = true;
    };
  };

  # Enable virt-manager GUI for VM management
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    # QEMU virtualization tools
    qemu
    qemu_kvm
    qemu-user
    qemu-utils
    OVMFFull

    # VM guest management tools
    libguestfs
    libguestfs-appliance
    python312Packages.guestfs

    # Container management tools
    boxbuddy
    distrobox_git

    # Android emulation tools
    waydroid
    waydroid-helper

    # Virtualization utilities
    swtpm
  ];
}
