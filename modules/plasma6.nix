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

  # Fingerprint authentication PAM setting for Plasma 6
  security.pam.services.kde-fingerprint.fprintAuth = true;

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
      (
        (vivaldi.override {
          commandLineArgs = [
            "--ozone-platform=wayland"
            "--enable-wayland-ime"
            "--wayland-text-input-version=3"
          ];
        }).overrideAttrs
        (oldAttrs: {
          dontWrapQtApps = false;
          dontPatchELF = true;
          nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.kdePackages.wrapQtAppsHook ];
        })
      )
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

  # Plasma-specific options
  programs = {
    chromium.enablePlasmaBrowserIntegration = true;
    kdeconnect.enable = true;
  };
}
