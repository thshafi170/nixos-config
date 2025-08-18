{
  pkgs,
  ...
}:

{
  imports = [
    ./services/niri-session.nix
  ];

  # Niri Wayland compositor + IIO support
  programs = {
    niri.enable = true;
    iio-niri.enable = true;
  };

  # Essential services
  services = {
    # Display manager
    displayManager.ly.enable = true;

    # Desktop services
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;

    # System services
    blueman.enable = true;
  };

  # Security
  security = {
    polkit = {
      enable = true;
      package = pkgs.polkit_gnome;
    };
    pam.services = {
      login.enableGnomeKeyring = true;
      ly.enableGnomeKeyring = true;
    };
  };

  # Essential packages
  environment.systemPackages = with pkgs; [
    # Niri essentials
    niri
    niriswitcher
    walker
    quickshell

    # Desktop utilities
    wl-clipboard
    cliphist
    brightnessctl
    wlr-randr

    # File manager and basic apps
    nautilus
    nemo
    file-roller

    # Control and monitoring
    gnome-tweaks

    # Terminal and audio
    kitty
    pwvucontrol
    pavucontrol

    # Theming
    bibata-cursors
    papirus-folders
    papirus-icon-theme
    adw-gtk3
    colloid-gtk-theme

    # System tools
    polkit_gnome
    xdg-utils
    xdg-user-dirs

    # Wayland support
    xwayland
    wayland-utils
  ];

  # XDG portals
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.common.default = "gnome";
  };

  # Programs
  programs = {
    dconf.enable = true;
    seahorse.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # Environment variables
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    GDK_BACKEND = "wayland,x11";
    SDL_VIDEODRIVER = "wayland,x11";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

}
