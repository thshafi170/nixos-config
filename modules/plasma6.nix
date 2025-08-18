{
  pkgs,
  ...
}:

{
  # Enable Plasma 6 desktop environment
  services = {
    accounts-daemon.enable = true;
    desktopManager = {
      plasma6 = {
        enable = true;
        enableQt5Integration = true;
      };
    };
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        enableHidpi = true;
      };
    };
  };

  # PAM setting for using fingerprint authentication in Plasma 6
  security.pam.services.kde-fingerprint.fprintAuth = true;

  # fcitx5 configuration
  i18n.inputMethod.fcitx5.plasma6Support = true;

  # Package Exclusion
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
  ];

  # Essential programs
  environment.systemPackages =
    (with pkgs; [
      adwaita-fonts
      adwaita-icon-theme
      adwaita-icon-theme-legacy
      adwaita-qt
      adw-gtk3
      dee
      morewaita-icon-theme
      libappindicator
      libappindicator-gtk2
      libayatana-appindicator
      libunity
      vlc
    ])
    ++ (with pkgs.kdePackages; [
      markdownpart
      alligator
      isoimagewriter
      kcmutils
      phonon-vlc
      sddm-kcm
      flatpak-kcm
      kjournald
      ksystemlog
      ocean-sound-theme
      xwaylandvideobridge
    ]);

  # XDG configuration
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = "kde";
  };

  # KDE-specific environment variables
  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
    XMODIFIERS = "@im=fcitx";
  };

  # Enable Plasma Browser Integration for Chromium
  programs.chromium.enablePlasmaBrowserIntegration = true;
}
