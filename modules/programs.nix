{
  pkgs,
  pkgsMaster,
  ...
}:

{
  # System packages
  environment.systemPackages = with pkgs; [
    # System utilities
    btop
    btrfs-progs
    dconf-editor
    dgop
    dosfstools
    mtools
    ntfs3g

    # Media & Graphics
    icoextract
    icoutils
    krita
    xournalpp

    # Communication
    discord
    element-desktop
    telegram-desktop
    zapzap

    # Web browsers
    vivaldi
    vivaldi-ffmpeg-codecs

    # Gaming & Wine
    bottles
    cartridges
    lutris
    mangohud
    goverlay
    protonplus
    steamcmd
    steam-run
    umu-launcher
    vkbasalt
    vkbasalt-cli
    wineWowPackages.fonts
    wineWowPackages.stagingFull
    winetricks

    # Productivity
    onlyoffice-desktopeditors
    qbittorrent

    # Archives & Tools
    rar
    p7zip
    unzip
    unrar
    arrpc
    equicord
    freetype
    varia

    # Other programs
    proton-authenticator
  ];

  # Environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_ENABLE_HARDWARE_ACCELERATION = "1";
  };

  # Services
  services.flatpak.enable = true;

  # Flatpak repo setup
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = "flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo";
  };

  # Programs configuration
  programs = {
    # Basic programs
    dconf.enable = true;
    adb.enable = true;
    chromium.enable = true;
    appimage.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;

    # Steam configuration
    steam = {
      enable = true;
      extraCompatPackages = with pkgsMaster; [ proton-ge-bin ];
      extraPkgs =
        pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXcomposite
          libGL
          vulkan-loader
          libpulseaudio
          alsa-lib
          libkrb5
          systemd
          wayland
          libxkbcommon
        ];
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
    };
  };
}
