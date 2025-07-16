{ config, pkgs, lib, ... }:

{
  # Niri Wayland compositor
  programs.niri.enable = true;

  # Display manager configuration
  services.displayManager.gdm = {
    autoSuspend = true;
    enable = true;
    wayland = true;
  };

  # GNOME services for Wayland environment
  services.gnome = {
    gnome-keyring.enable = true;
    gnome-settings-daemon.enable = true;
  };

  # Essential Niri and Wayland packages
  environment.systemPackages = with pkgs; [
    # Core Niri tools
    niri quickshell

    # GNOME utilities
    nautilus gnome-control-center
    gnome-tweaks gnome-system-monitor

    # Wayland utilities
    wl-clipboard wlr-randr grim slurp

    # Launcher and notifications
    rofi-wayland mako
  ];

  # XDG portal configuration for Wayland
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.common.default = "gnome";
  };

  # Additional services
  services = {
    geoclue2.enable = true;
    gvfs.enable = true;
    printing.enable = true;
  };

  # Wayland environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
    ELECTRON_ENABLE_HARDWARE_ACCELERATION = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
