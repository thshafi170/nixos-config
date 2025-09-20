{
  pkgs,
  ...
}:

{
  imports = [
    ../services/power-wm.nix
  ];

  services = {
    # COSMIC Desktop Environment
    desktopManager = {
      cosmic.enable = true;
      cosmic-greeter.enable = true;
    };

    # Desktop services
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
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
  ];

  # COSMIC-specific environment variables
  environment.sessionVariables = {
    COSMIC_DATA_CONTROL_ENABLED = "1";
    XDG_CURRENT_DESKTOP = "cosmic";
    XDG_SESSION_DESKTOP = "cosmic";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

}
