{
  pkgs,
  ...
}:

{
  # Polkit authentication agent
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "GNOME Polkit Authentication Agent";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };

  # # Quickshell (Superceded by DMS module)
  # systemd.user.services.quickshell = {
  #   description = "Flexible toolkit for making desktop shells with QtQuick, for Wayland and X11";
  #   wantedBy = [ "graphical-session.target" ];
  #   wants = [ "graphical-session.target" ];
  #   after = [ "graphical-session.target" ];
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = "${pkgs.quickshell}/bin/qs -c DankMaterialShell";
  #     Restart = "on-failure";
  #     RestartSec = 1;
  #   };
  # };
}
