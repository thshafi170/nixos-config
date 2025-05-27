{ config, pkgs, lib, ... }:

{
  users.users.shafael170 = {
    isNormalUser = true;
    shell = pkgs.fish;
    createHome = true;
    name = "shafael170";
    description = "Shafa'el Zmeyev";
    home = "/home/shafael170";
    extraGroups = [ "adbusers" "adm" "audio" "kmem" "kvm" "libvirtd" "mem" "networkmanager" "podman" "power" "proc" "qemu" "qemu-libvirtd" "sys" "tss" "users" "wheel" ];
  };
}
