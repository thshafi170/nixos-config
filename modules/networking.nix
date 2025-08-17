{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Network configuration
  networking = {
    firewall = {
      enable = false;
      checkReversePath = "loose";
    };
    useDHCP = false;
    networkmanager.enable = true;
    resolvconf.enable = true;
  };

  # SSH service
  services.openssh.enable = true;

  # Network utilities
  environment.systemPackages = with pkgs; [
    curl
    dhcpcd
    networkmanagerapplet
    protonvpn-cli
    protonvpn-gui
    wget
    wireguard-tools
  ];
}
