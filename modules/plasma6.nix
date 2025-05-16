{ config, pkgs, lib, ... }:

{
  services = {
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

  i18n.inputMethod.fcitx5.plasma6Support = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
  ];

  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
  };

  environment.systemPackages = (with pkgs; [
    adwaita-fonts
    adwaita-icon-theme
    adwaita-icon-theme-legacy
    adwaita-qt
    adw-gtk3
    dee
    gtk3
    gtk4
    morewaita-icon-theme
    libadwaita
    libappindicator
    libappindicator-gtk2
    libayatana-appindicator
    libunity
    ]) ++ (with pkgs.kdePackages; [
    markdownpart
    alligator
    isoimagewriter
    kcmutils
    sddm-kcm
    flatpak-kcm
    kjournald
    ocean-sound-theme
    xwaylandvideobridge
  ]);

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
    ];
  };

  programs.chromium.enablePlasmaBrowserIntegration = true;
}