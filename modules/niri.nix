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

    # Necessary programs
    wl-clipboard
    cliphist
    brightnessctl
    wlr-randr
    nemo
    kitty
    pwvucontrol
    pavucontrol
    nwg-look

    # GNOME programs
    file-roller
    nautilus
    gnome-boxes
    gnome-control-center
    gnome-tweaks
    gnome-text-editor
    loupe
    papers
    xdg-user-dirs-gtk

    # Nautilus plugins
    nautilus-python
    nautilus-open-any-terminal
    code-nautilus

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
    xwayland-satellite
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
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };
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
