{ config, lib, pkgs, ... }:

{
  # Enable COSMIC Desktop Environment
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  # Enable Wayland support
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
  };

  # Essential services for COSMIC
  # COSMIC-specific services
  services.geoclue2.enable = true;
  services.printing.enable = true;
  hardware.sane.enable = true;

  # GNOME applications and utilities
  environment.systemPackages = with pkgs; [
    # Core GNOME applications
    gnome.nautilus
    gnome.gnome-calendar
    gnome.gnome-calculator
    gnome.gnome-clocks
    gnome.gnome-weather
    gnome.gnome-maps
    gnome.gnome-photos
    gnome.gnome-music
    gnome.gnome-contacts
    gnome.evince
    gnome.gedit
    gnome.gnome-terminal
    gnome.gnome-system-monitor
    gnome.gnome-disk-utility
    gnome.gnome-tweaks
    gnome.dconf-editor
    
    # GNOME utilities
    gnome.file-roller
    gnome.gnome-screenshot
    gnome.gnome-font-viewer
    gnome.gnome-logs
    gnome.gnome-characters
    gnome.gnome-connections
    
    # Additional useful applications
    firefox
    thunderbird
    libreoffice-fresh
    gimp
    vlc
    
    # COSMIC-specific utilities (if available)
    # cosmic-edit
    # cosmic-files
    # cosmic-settings
    # cosmic-term
    # cosmic-store
  ];

  # COSMIC-specific GNOME services
  services.gnome.gnome-keyring.enable = true;

  # Enable XDG portals for proper app integration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
  };

  # COSMIC-specific fonts
  fonts.packages = with pkgs; [
    # Fonts for COSMIC
    jetbrains-mono
    fira-code
    inter
  ];

  # Environment variables for COSMIC and GNOME integration
  environment.sessionVariables = {
    # COSMIC specific
    COSMIC_DATA_CONTROL_ENABLED = "1";
    
    # GTK and GNOME integration
    GTK_USE_PORTAL = "1";
    GTK_THEME = "Adwaita:dark";
    GDK_BACKEND = "wayland,x11";
    
    # Qt integration
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    
    # Mozilla applications
    MOZ_ENABLE_WAYLAND = "1";
    
    # Electron applications
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    
    # XDG
    XDG_CURRENT_DESKTOP = "cosmic";
    XDG_SESSION_DESKTOP = "cosmic";
    XDG_SESSION_TYPE = "wayland";
    
    # Cursor
    XCURSOR_SIZE = "24";
    
    # Java applications
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  # COSMIC-specific services
  services.accounts-daemon.enable = true;
  services.system76-scheduler.enable = true;
  
  # Enable flatpak for COSMIC store integration
  services.flatpak.enable = true;
}
