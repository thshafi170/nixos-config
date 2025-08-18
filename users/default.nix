{
  pkgs,
  ...
}:

{
  users.users.thshafi170 = {
    isNormalUser = true;
    shell = pkgs.fish;
    createHome = true;
    name = "thshafi170";
    description = "Tawsif Hossain Shafi";
    home = "/home/thshafi170";
    extraGroups = [
      "adbusers"
      "adm"
      "audio"
      "kmem"
      "kvm"
      "libvirtd"
      "mem"
      "networkmanager"
      "podman"
      "power"
      "proc"
      "qemu"
      "qemu-libvirtd"
      "sys"
      "thshafi170"
      "tss"
      "users"
      "wheel"
    ];
  };
}
