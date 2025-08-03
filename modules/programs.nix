{ self, config, lib, pkgs, pkgsMaster, pkgsStaging, pkgsNxt, ... }:

{
  # Package overlays for custom configurations
  nixpkgs.overlays = [
    self.inputs.nix-alien.overlays.default
    (final: prev: {
      vivaldi = prev.vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = true;
        commandLineArgs = "--ozone-platform=wayland --enable-wayland-ime";
      };
      
      discord = prev.discord.override {
        commandLineArgs = "--ozone-platform=wayland --enable-wayland-ime";
      };

      bottles = prev.bottles.override {
        removeWarningPopup = true;
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    # System utilities
    btop btrfs-progs dconf-editor dosfstools mtools ntfs3g

    # Media and graphics
    icoextract icoutils krita pwvucontrol vlc xournalpp

    # Communication
    discord element-desktop telegram-desktop zapzap

    # Web browsers
    vivaldi vivaldi-ffmpeg-codecs

    # Gaming
    bottles cartridges lutris mangohud goverlay protonplus
    steamcmd steam-run umu-launcher vkbasalt vkbasalt-cli 

    # Wine
    wineWowPackages.fonts wineWowPackages.stagingFull winetricks

    # Office and productivity
    onlyoffice-desktopeditors qbittorrent

    # Archives
    rar unzip unrar

    # Other
    arrpc equicord freetype nix-alien varia
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_ENABLE_HARDWARE_ACCELERATION = "1";
  };

  # Flatpak configuration
  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  programs = {
    dconf.enable = true;
    adb.enable = true;
    chromium.enable = true;
    appimage.enable = true;
    gamemode.enable = true;

    steam = {
      enable = true;
      extraCompatPackages = with pkgsMaster; [ proton-ge-bin ];
      extraPkgs = pkgs: with pkgs; [
        # X11 support
        xorg.libXcursor xorg.libXi xorg.libXinerama xorg.libXcomposite
        # Graphics 
        libGL vulkan-loader
        # Audio
        libpulseaudio alsa-lib
        # System
        libkrb5 systemd
        # Wayland
        wayland libxkbcommon
      ];
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
    };

    gamescope.enable = true;
  };
}