{
  config,
  lib,
  pkgs,
  pkgsMaster,
  ...
}:

{
  # Network configuration
  networking = {
    wireless.iwd.enable = true;
    firewall = {
      enable = true;
      allowedUDPPorts = [
        53
        67
      ];
      checkReversePath = "loose";
    };
    useDHCP = false;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };
    resolvconf.enable = true;
  };

  # SSH service
  services.openssh.enable = true;

  # Network utilities
  environment.systemPackages = with pkgs; [
    curl
    dhcpcd
    networkmanagerapplet
    openvpn
    openvpn3
    protonvpn-gui
    wget
    wireguard-tools
  ];
}
