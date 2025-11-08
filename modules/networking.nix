{
  config,
  lib,
  pkgs,
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
    protonvpn-gui
    wget
    wireguard-tools
  ];
}
