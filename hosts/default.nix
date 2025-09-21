{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{
  # Import other configurations for reference
  imports = [
    ./hardware-configuration.nix
    ../modules
    ../users
  ];

  # nixpkgs configuration
  nixpkgs = {
    overlays = [
      (import ../overlays.nix)
    ];
    config = {
      allowUnfree = true;
    };
  };

  # System hostname
  networking.hostName = "X1-Yoga-2nd";

  # Time configuration
  time = {
    timeZone = "Asia/Dhaka";
    hardwareClockInLocalTime = false;
  };

  # Language and locale settings
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [
      "bn_BD/UTF-8"
      "ja_JP.UTF-8/UTF-8"
      "ko_KR.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
      "ru_UA.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
      "zh_TW.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Console configuration
  console = {
    packages = [ pkgs.terminus_font ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-122n.psf.gz";
    keyMap = "us";
  };

  # System font configuration
  fonts = {
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
    fontconfig.useEmbeddedBitmaps = true;
    enableDefaultPackages = false;
    packages = with pkgs; [
      # Essential fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      liberation_ttf
      dejavu_fonts
      cantarell-fonts
      jetbrains-mono
      fira-code
      fira-code-symbols
      terminus_font

      # Development fonts
      nerd-fonts.meslo-lg
      source-code-pro

      # UI fonts
      adwaita-fonts
      font-awesome
      material-icons
      material-symbols
      powerline-fonts
      powerline-symbols

      # Language-specific fonts
      lohit-fonts.bengali
      source-sans
      source-serif
      source-han-sans
      source-han-serif
      source-han-mono

      # Custom fonts
      inter-font
    ];
  };

  # zRAM swap configuration
  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "zstd";
    swapDevices = 1;
    memoryPercent = 75;
  };

  # System limits and optimization
  systemd = {
    user.extraConfig = "DefaultLimitNOFILE=524288";
    services.nix-daemon.environment.TMPDIR = "/var/tmp";
  };

  # Nix package manager configuration
  nix = {
    package = pkgs.lixPackageSets.stable.lix;
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      cores = 4;
      max-jobs = 4;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "thshafi170"
      ];
      # Binary cache sources
      substituters = [
        "https://cache.nixos.org"
        "https://chaotic-nyx.cachix.org"
        "https://nix-community.cachix.org"
        "https://an-anime-team.cachix.org"
        "https://niri.cachix.org"
      ];
      # Public keys for binary caches
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "an-anime-team.cachix.org-1:nr9QXfYG5tDXIImqxjSXd1b6ymLfGCvviuV8xRPIKPM="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
    };
  };

  # Required packages for Lix
  environment.systemPackages = with pkgs; [
    lixPackageSets.latest.nixpkgs-review
    lixPackageSets.latest.nix-direnv
    lixPackageSets.latest.nix-eval-jobs
    lixPackageSets.latest.nix-fast-build
    lixPackageSets.latest.colmena
  ];

  # Allow unfree packages globally
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";

  # System configuration
  system = {
    rebuild.enableNg = true;
    stateVersion = "25.11";
  };

}
