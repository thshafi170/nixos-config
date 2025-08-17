{
  lib,
  stdenvNoCC,
  fetchurl,
  autoPatchelfHook,
  dpkg,
  glib-networking,
  wrapGAppsHook4,
  webkitgtk_4_1,
}:

stdenvNoCC.mkDerivation rec {
  pname = "proton-authenticator";
  version = "1.0.0";

  src = fetchurl {
    url = "https://proton.me/download/authenticator/linux/ProtonAuthenticator_${version}_amd64.deb";
    hash = "sha256-Ri6U7tuQa5nde4vjagQKffWgGXbZtANNmeph1X6PFuM=";
  };

  # Don't try to configure or build since this is a pre-built package
  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [
    dpkg # For extracting .deb files
    autoPatchelfHook # Automatically patches ELF binaries for NixOS
    wrapGAppsHook4 # For GTK4/GLib applications
  ];

  buildInputs = [
    webkitgtk_4_1 # WebKit for GTK (likely used for UI)
  ];

  # Extract the .deb file
  unpackPhase = ''
    runHook preUnpack
    dpkg-deb -x $src .
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    # Install the main binary
    install -Dm755 usr/bin/proton-authenticator $out/bin/proton-authenticator

    # Copy all shared resources (icons, desktop files, etc.)
    cp -r usr/share $out/

    # Wrap the program with necessary environment variables
    wrapProgram "$out/bin/proton-authenticator" \
      --prefix GIO_EXTRA_MODULES : "${glib-networking}/lib/gio/modules"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Two-factor authentication manager with optional sync";
    longDescription = ''
      Proton Authenticator is a two-factor authentication (2FA) app from Proton.
      It generates time-based one-time passwords (TOTP) and supports optional
      sync across devices when used with a Proton account.
    '';
    homepage = "https://proton.me/authenticator";
    downloadPage = "https://proton.me/download/authenticator";
    license = licenses.unfree; # Proprietary software
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    mainProgram = "proton-authenticator";
  };
}
