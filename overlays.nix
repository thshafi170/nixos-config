final: prev: {
  # Custom packages
  inter-font = final.callPackage ./packages/inter-font.nix { };

  # Wayland-optimized applications
  vivaldi = (prev.vivaldi.overrideAttrs (oldAttrs: {
    buildPhase = builtins.replaceStrings
      [ "for f in libGLESv2.so libqt5_shim.so ; do" ]
      [ "for f in libGLESv2.so libqt5_shim.so libqt6_shim.so ; do" ]
      oldAttrs.buildPhase;
  })).override {
    commandLineArgs = [
      "--ozone-platform=wayland"
      "--enable-wayland-ime"
      "--password-store=kwallet6"
    ];
    proprietaryCodecs = true;
    enableWidevine = true;
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

  # Steam tweaks (Enabled only for Niri)
  # steam = prev.steam.override {
  #   extraArgs = [ "-system-compositor" ];
  # };
}
