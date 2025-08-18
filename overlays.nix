final: prev: {
  # Custom packages
  inter-font = final.callPackage ./packages/inter-font.nix { };
  dgop = final.callPackage ./packages/dgop.nix { };

  # Wayland-optimized applications
  vivaldi = prev.vivaldi.override {
    proprietaryCodecs = true;
    enableWidevine = true;
    commandLineArgs = "--ozone-platform=wayland --enable-wayland-ime";
  };

  discord = prev.discord.override {
    commandLineArgs = "--ozone-platform=wayland --enable-wayland-ime";
  };

  # Application customizations
  bottles = prev.bottles.override {
    removeWarningPopup = true;
  };

  steam = prev.steam.override {
    extraArgs = [ "-system-composer" ];
  };
}
