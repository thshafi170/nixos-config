{ self, config, pkgs, lib, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        runAsRoot = true;
        vhostUserPackages = with pkgs; [
          virtiofsd
        ];
        swtpm = {
          enable = true;
        };
        ovmf = {
          enable = true;
          packages = [(pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd];
        };
      };
    };
    spiceUSBRedirection.enable = true;
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enable = true;
    };
    waydroid.enable = true;
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    boxbuddy
    distrobox_git
    libguestfs
    libguestfs-appliance
    OVMFFull
    python312Packages.guestfs
    qemu
    qemu_kvm
    qemu-user
    qemu-utils
    swtpm
    waydroid-helper
    wl-clipboard
  ];
}
