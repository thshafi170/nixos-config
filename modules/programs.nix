{ self, config, pkgs, pkgsMaster, lib, ... }:

{
  nixpkgs.overlays = [
    self.inputs.nix-alien.overlays.default
    (self: super: {
      vivaldi = (super.vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = true;
        commandLineArgs = ''
          --ozone-platform=wayland
          --enable-wayland-ime
          --wayland-text-input-version=3
        '';
      }).overrideAttrs (oldAttrs: {
        dontWrapQtApps = false;
        dontPatchELF = true;
        nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [super.kdePackages.wrapQtAppsHook];
      });
      vesktop = (super.vesktop.override {
        withMiddleClickScroll = true;
      });
    })
  ];

  environment.systemPackages = (with pkgs; [
    android-tools
    android-udev-rules
    arrpc
    btop
    btrfs-progs
    dconf-editor
    direnv
    dosfstools
    element-desktop
    fakeroot
    fastfetch
    freetype
    gh
    git
    icoextract
    icoutils
    krita
    lutris
    mangohud
    goverlay
    mtools
    nix-alien
    nixd
    nodejs_22
    ntfs3g
    onlyoffice-desktopeditors
    pnpm
    protonplus
    pwvucontrol
    python3Full
    qbittorrent
    rar
    steamcmd
    steam-run
    telegram-desktop
    umu-launcher
    unzip
    unrar
    vesktop
    vivaldi
    vivaldi-ffmpeg-codecs
    vkbasalt
    vkbasalt-cli
    vlc
    vscode-fhs
    wineWowPackages.fonts
    wineWowPackages.stagingFull
    winetricks
    xournalpp
    zapzap
  ]) ++ (with pkgs.python312Packages; [
      black
      flake8
      isort
      ipython
      jupyter
      mypy
      pip
      pytest
      virtualenv
  ]) ++ (with pkgsMaster; [
    (bottles.override {
      removeWarningPopup = true;
    })
  ]);

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs = {
    dconf.enable = true;
    adb.enable = true;
    java = {
      enable = true;
      package = pkgs.jdk;
    };
    appimage = {
      enable = true;
      binfmt = true;
    };
    chromium.enable = true;
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            libkrb5
            keyutils
          ];
      };
      extraCompatPackages = with pkgsMaster; [
        proton-ge-bin
      ];
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
