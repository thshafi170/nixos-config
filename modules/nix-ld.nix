{ config, pkgs, lib, ... }:

let
  # Core system libraries that most applications need
  coreLibs = with pkgs; [
    stdenv.cc.cc dbus expat icu libcap libelf libunwind 
    libusb1 libuuid util-linux tbb
  ];

  # Audio libraries for media applications
  audioLibs = with pkgs; [
    alsa-lib flac libcaca libcanberra libmikmod libogg 
    libpulseaudio libsamplerate libtheora libvorbis libvpx 
    speex pipewire
  ];

  # Compression and archive handling
  compressionLibs = with pkgs; [
    bzip2 zlib zstd
  ];

  # Font rendering and text handling
  fontLibs = with pkgs; [
    fontconfig freetype libidn
  ];

  # Graphics, rendering, and GPU libraries
  graphicsLibs = with pkgs; [
    cairo fuse3 libdrm libGL libglvnd libva libvdpau librsvg 
    mesa pango pixman vulkan-loader freeglut glew110
  ];

  # GUI toolkit libraries
  guiLibs = with pkgs; [
    atk at-spi2-atk at-spi2-core cups gdk-pixbuf glib 
    gnome2.GConf gtk2 gtk3 libappindicator-gtk2 libappindicator-gtk3 
    libdbusmenu-gtk2 libindicator-gtk2 libxkbcommon
  ];

  # Image format libraries
  imageLibs = with pkgs; [
    libjpeg libpng libpng12 libtiff
  ];

  # Multimedia libraries
  multimediaLibs = with pkgs; [
    ffmpeg
  ];

  # SDL gaming libraries
  sdlLibs = with pkgs; [
    SDL SDL2 SDL2_image SDL2_mixer SDL2_ttf 
    SDL_image SDL_mixer SDL_ttf
  ];

  # Security and cryptography
  securityLibs = with pkgs; [
    libgcrypt libnotify libsodium libssh nspr nss 
    openssl acl attr fakeroot libudev0-shim
  ];

  # X11 windowing system libraries
  x11Libs = with pkgs.xorg; [
    libICE libSM libX11 libXScrnSaver libXcomposite libXcursor 
    libXdamage libXext libXfixes libXft libXi libXinerama 
    libXmu libXrandr libXrender libXt libXtst libXxf86vm 
    libxcb libxkbfile libxshmfence
  ];

  # All libraries combined
  allLibs = coreLibs ++ audioLibs ++ compressionLibs ++ fontLibs
         ++ graphicsLibs ++ guiLibs ++ imageLibs ++ multimediaLibs
         ++ sdlLibs ++ securityLibs ++ x11Libs;

in {
  services.envfs.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = allLibs ++ lib.optionals (config.hardware.graphics.enable) [
      # Additional graphics libraries when hardware acceleration is enabled
      # (placeholder for future additions)
    ];
  };
}
