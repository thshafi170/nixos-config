{ self, config, lib, pkgs, pkgsMaster, pkgsStaging, pkgsNxt, ... }:

let
  # Custom package overrides
  customPackages = {
    vivaldi = pkgs.vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
      commandLineArgs = ''
        --ozone-platform=wayland
        --enable-wayland-ime
        --wayland-text-input-version=3
      '';
    };
    
    bottles = pkgs.bottles.override {
      removeWarningPopup = true;
    };

    # equibop = pkgs.equibop.override {
    #   withMiddleClickScroll = true;
    # };
  };

  # Steam extra packages for better compatibility
  steamExtraPackages = with pkgs; [
    # X11 libraries
    xorg.libXcursor xorg.libXi xorg.libXinerama xorg.libXScrnSaver
    xorg.libXcomposite xorg.libXdamage xorg.libXrandr xorg.libXrender xorg.libXfixes

    # Graphics and rendering
    libGL vulkan-loader libdrm libpng freetype fontconfig

    # Audio
    libpulseaudio libvorbis alsa-lib

    # System libraries
    stdenv.cc.cc.lib libkrb5 keyutils dbus systemd udev

    # Network and compression
    openssl curl zlib bzip2

    # Wayland support
    wayland libxkbcommon

    # GTK and accessibility
    gtk3 at-spi2-atk
  ];

  # User applications (non-development, non-virtualization)
  systemPackages = with pkgs; [
    # System utilities
    btop btrfs-progs dconf-editor dosfstools mtools ntfs3g

    # Media and graphics
    icoextract icoutils krita vlc xournalpp

    # Communication
    discord element-desktop telegram-desktop zapzap

    # Gaming
    cartridges lutris mangohud goverlay protonplus
    steamcmd steam-run umu-launcher vkbasalt vkbasalt-cli

    # Wine and compatibility
    wineWowPackages.fonts wineWowPackages.stagingFull winetricks

    # Office and productivity
    onlyoffice-desktopeditors qbittorrent

    # Archive utilities
    rar unzip unrar

    # Custom packages
    customPackages.vivaldi vivaldi-ffmpeg-codecs customPackages.bottles

    # Other applications
    arrpc equicord freetype nix-alien pwvucontrol varia
  ];

in {
  nixpkgs.overlays = [
    self.inputs.nix-alien.overlays.default
    (self: super: customPackages)
  ];

  environment = {
    systemPackages = systemPackages;
    sessionVariables.NIXOS_OZONE_WL = "1";
  };

  programs = {
    # Basic programs
    dconf.enable = true;
    adb.enable = true;
    chromium.enable = true;

    # AppImage support
    appimage = {
      enable = true;
      binfmt = true;
    };

    # Steam
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs: steamExtraPackages;
      };
      extraCompatPackages = with pkgsMaster; [ proton-ge-bin ];
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
    };

    gamescope = {
      enable = true;
      capSysNice = true;
    };

    gamemode.enable = true;
  };
}