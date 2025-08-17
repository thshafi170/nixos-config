{
  config,
  inputs,
  lib,
  pkgs,
  pkgsMaster,
  pkgsStaging,
  pkgsNext,
  ...
}:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Rust toolchain
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer-nightly

    # Python with essential packages
    (python312.withPackages (
      ps: with ps; [
        pip
        black
        flake8
        mypy
        pytest
        requests
        numpy
        pandas
        python-lsp-server
        pylsp-mypy
        python-lsp-black
      ]
    ))

    # Core development tools
    jdk
    gcc
    clang
    cmake
    gnumake
    gdb
    dotnet-sdk
    mono

    # IDEs
    vscode-fhs
    jetbrains.pycharm-community-bin

    # CLI utilities
    jq
    tree
    ripgrep
    fd
    bat
    gh
    direnv
    fakeroot
    git

    # Language servers & tools
    nixd
    nixfmt-rfc-style
    clang-tools
    omnisharp-roslyn
    jdt-language-server
    yaml-language-server

    # Node.js & package managers
    nodejs_22
    pnpm

    # Android development
    android-tools
    android-udev-rules
  ];

  # Java configuration
  programs.java = {
    enable = true;
    package = pkgs.jdk;
  };

  # Development environment variables
  environment.sessionVariables = {
    RUST_BACKTRACE = "1";
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";
    JAVA_HOME = "${pkgs.jdk}/lib/openjdk";
    CC = "${pkgs.gcc}/bin/gcc";
    CXX = "${pkgs.gcc}/bin/g++";
  };
}
