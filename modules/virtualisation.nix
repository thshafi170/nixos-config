{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Virtualization services
  virtualisation = {
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

    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enable = true;
    };
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    # QEMU and KVM
    qemu
    qemu_kvm
    qemu-user
    qemu-utils
    OVMFFull

    # Guest management
    libguestfs
    libguestfs-appliance
    python312Packages.guestfs

    # Container tools
    boxbuddy
    distrobox_git

    # Android emulation
    waydroid
    waydroid-helper

    # Utilities
    swtpm
  ];
}
