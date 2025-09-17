final: prev: {
  # Custom packages
  inter-font = final.callPackage ./packages/inter-font.nix { };

  # Wayland-optimized applications
  vivaldi = prev.vivaldi.overrideAttrs (oldAttrs: {
    buildPhase = builtins.replaceStrings
      [ "for f in libGLESv2.so libqt5_shim.so ; do" ]
      [ "for f in libGLESv2.so libqt5_shim.so libqt6_shim.so ; do" ]
      oldAttrs.buildPhase;
  }).override {
    qt5 = final.qt6;
    commandLineArgs = [
      "--ozone-platform=wayland"
      "--enable-wayland-ime"
      "--password-store=kwallet6"
    ];
    proprietaryCodecs = true;
    enableWidevine = true;
  };

  vscode-fhs = prev.vscode-fhs.override {
    commandLineArgs = [
      "--ozone-platform=wayland"
      "--enable-wayland-ime"
      "--password-store=kwallet6"
    ];
  };

  discord = prev.discord.override {
    commandLineArgs = [
      "--ozone-platform=wayland"
      "--enable-wayland-ime"
    ];
  };

  # Application customizations
  bottles = prev.bottles.override {
    removeWarningPopup = true;
  };

  # Steam tweaks
  # steam = prev.steam.override {
  #   extraArgs = [ "-system-compositor" ];
  # };
}
