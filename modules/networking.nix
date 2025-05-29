{ config, pkgs, lib, ... }:

{
  networking = {
    firewall = {
      enable = false;
      checkReversePath = "loose";
    };
    useDHCP = false;
    networkmanager = {
      enable = true;
    };
    resolvconf.enable = true;
  };
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    networkmanagerapplet
    protonvpn-cli
    protonvpn-gui
    wget
    wireguard-tools
  ];

}
