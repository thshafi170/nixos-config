{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Enable COSMIC Desktop Environment
  services.desktopManager = {
    cosmic.enable = true;
    cosmic-greeter.enable = true;
  };

  # Essential system services for COSMIC
  services = {
    upower.enable = true;
    geoclue2.enable = true;
    accounts-daemon.enable = true;
  };

  # XDG portals for COSMIC
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.common.default = "cosmic";
  };

  # COSMIC-focused application packages
  environment.systemPackages = with pkgs; [
    # Essential COSMIC utilities
    cosmic-edit
    cosmic-files
    cosmic-settings
    cosmic-term
    cosmic-store

    # Minimal additional apps
    firefox

    # System utilities
    gnome.gnome-system-monitor
  ];

  # COSMIC-specific environment variables
  environment.sessionVariables = {
    COSMIC_DATA_CONTROL_ENABLED = "1";
    XDG_CURRENT_DESKTOP = "cosmic";
    XDG_SESSION_DESKTOP = "cosmic";
    XDG_SESSION_TYPE = "wayland";

    # Wayland optimization
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";

    # UI theming
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

}
