# System services configuration
{
  pkgs,
  ...
}:

{
  services = {
    # Hardware and system optimization
    fstrim.enable = true;
    btrfs.autoScrub.enable = true;
    fwupd.enable = true;
    irqbalance.enable = true;
    thermald.enable = true;
    dbus.implementation = "broker";

    # Power and device management
    upower.enable = true;
    udisks2.enable = true;
    geoclue2.enable = true;
    accounts-daemon.enable = true;
    envfs.enable = true;

    # Security and authentication
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };

    # Printing services
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # seatd configuration
    seatd = {
      enable = true;
      user = "thshafi170";
    };

    # Desktop services
    tumbler.enable = true;
    timesyncd.enable = true;

    # X11 Display Server (Disabled, using Wayland)
    xserver = {
      enable = false;
      wacom.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      excludePackages = with pkgs; [
        xterm
      ];
    };
  };
}
