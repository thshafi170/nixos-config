{
  inputs,
  pkgs,
  ...
}:

{
  # Module imports
  imports = [
    ../services/niri-session.nix
    ../services/power-wm.nix
  ];

  # Niri + other essentials
  programs = {
    niri.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };
  };

  # Essential services
  services = {
    # Display manager
    displayManager.ly.enable = true;

    # Desktop services
    gnome.gnome-keyring.enable = true;
    gnome.gnome-settings-daemon.enable = true;
    gvfs.enable = true;
    iio-niri.enable = true;
    
    # D-bus tweaks
    dbus.packages = with pkgs; [
      gcr_4
      gnome-settings-daemon
      libsecret
    ];
    
    # System services
    blueman.enable = true;
  };

  # Security
  security = {
    polkit.enable = true;
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

    # Basic Wayland utilities
    wl-clipboard
    wlogout
    brightnessctl
    wlr-randr
    nemo
    kitty
    swaybg
    swayidle
    swww

    # Audio control utilities
    pwvucontrol
    pavucontrol

    # Screenshot tools
    slurp
    grim
    satty

    # GNOME programs
    file-roller
    nautilus
    gnome-boxes
    gnome-control-center
    gnome-settings-daemon
    gnome-tweaks
    gnome-text-editor
    loupe
    papers
    polkit_gnome
    xdg-user-dirs-gtk

    # Nautilus plugins
    nautilus-python
    nautilus-open-any-terminal
    code-nautilus

    # Theming
    bibata-cursors
    kdePackages.breeze
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    kdePackages.qqc2-breeze-style
    papirus-folders
    papirus-icon-theme
    adw-gtk3
    colloid-gtk-theme
    colloid-icon-theme
    themechanger
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugins

    # System tools
    xdg-utils
    xdg-user-dirs
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    xsettingsd

    # Wayland support
    xwayland
    xwayland-satellite
    wayland-utils
  ];

  # XDG portals
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.common.default = "gnome";
  };

  # Environment variables
  environment.sessionVariables = {
    # XDG setup
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";

    # GNOME related
    XDG_SESSION_DESKTOP = "GNOME";
    XDG_MENU_PREFIX = "gnome-";
    GDK_SCALE = "1.25";
    GNOME_KEYRING_CONTROL = "/run/user/1000/keyring";
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";

    # Qt
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";

    # Wayland
    DISPLAY = ":0";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    CLUTTER_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland,x11";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
