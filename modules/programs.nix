{ self, config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    android-tools
    android-udev-rules
    arrpc
    bottles
    btop
    btrfs-progs
    dconf-editor
    dosfstools
    element-desktop
    fastfetch
    freetype
    gh
    git
    icoutils
    krita
    lutris
    mtools
    nil
    nodejs_22
    ntfs3g
    onlyoffice-desktopeditors
    pnpm
    protonplus
    pwvucontrol
    python3Full
    qbittorrent
    rar
    steam-run
    telegram-desktop
    unzip
    unrar
    vesktop
    vkbasalt
    vkbasalt-cli
    vscode-fhs
    wineWowPackages.fonts
    wineWowPackages.stagingFull
    winetricks
    xournalpp
  ];

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
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
    };
    gamescope.enable = true;
    gamemode.enable = true;
  };
}