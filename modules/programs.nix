{
  inputs,
  pkgs,
  ...
}:

{
  # System packages
  environment.systemPackages = with pkgs; [
    # System utilities
    btop
    btrfs-progs
    colord
    dconf-editor
    dosfstools
    gammastep
    libsecret
    mtools
    ntfs3g
    seatd

    # Media & Graphics
    ffmpegthumbnailer
    gdk-pixbuf
    icoextract
    icoutils
    imagemagick
    krita
    webp-pixbuf-loader
    wpgtk
    xournalpp

    # Android development tools
    android-tools
    android-udev-rules

    # Communication
    (discord.override {
      commandLineArgs = [
        "--ozone-platform=wayland"
        "--enable-wayland-ime"
        "--wayland-text-input-version=3"
      ];
    })
    element-desktop
    telegram-desktop
    zapzap

    # Web browsers
    # (vivaldi.override {
    #  commandLineArgs = [
    #    "--password-store=gnome-libsecret"
    #    "--ozone-platform=wayland"
    #    "--enable-wayland-ime"
    #    "--wayland-text-input-version=3"
    #  ];
    #})
    vivaldi-ffmpeg-codecs

    # Gaming & Wine
    (bottles.override {
      removeWarningPopup = true;
    })
    cartridges
    lutris
    mangohud
    goverlay
    protonplus
    #(steam.override {
    #  extraArgs = ''
    #    -system-composer
    #  '';
    #})
    steamcmd
    steam-run
    umu-launcher
    vkbasalt
    vkbasalt-cli
    wineWowPackages.fonts
    wineWowPackages.stagingFull
    winetricks

    # Other programs
    proton-authenticator

    # Productivity
    onlyoffice-desktopeditors
    qbittorrent

    # Archives & Tools
    rar
    p7zip
    unzip
    unrar
    # arrpc
    equicord
    freetype
    varia
  ];

  # Environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_ENABLE_HARDWARE_ACCELERATION = "1";
  };

  # Services
  services.flatpak.enable = true;

  # XDG configuration
  xdg = {
    autostart.enable = true;
    icons.enable = true;
    menus.enable = true;
    mime.enable = true;
    portal.xdgOpenUsePortal = true;
    sounds.enable = true;
  };

  # Flatpak repo setup
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = "flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo";
  };

  # Programs configuration
  programs = {
    # Basic programs
    adb.enable = true;
    command-not-found.enable = true;
    chromium.enable = true;
    dconf.enable = true;
    appimage.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;

    # Steam configuration
    steam = {
      enable = true;
      extraPackages = with pkgs; [
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
