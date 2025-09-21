{
  pkgs,
  inputs,
  ...
}:

{

  # Development environment configuration
  environment.systemPackages = with pkgs; [
    # Rust development tools
    (inputs.fenix.packages.${pkgs.system}.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer

    # Python with development packages
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

    # More development languages
    go

    # Core development tools
    jdk
    gcc
    clang
    cmake
    gnumake
    gdb
    dotnet-sdk
    mono
    pkg-config

    # Code editors and IDEs
    jetbrains.pycharm-community-bin
    vscode-fhs
    zed-editor

    # Command line tools
    jq
    tree
    ripgrep
    fd
    bat
    gh
    direnv
    fakeroot
    git
    gh
    libcap
    nix-search-tv

    # Language servers and formatters
    nil
    nixfmt-rfc-style
    clang-tools
    omnisharp-roslyn
    jdt-language-server
    yaml-language-server

    # JavaScript/Node.js development
    nodejs_22
    pnpm
  ];

  # Enable some development tools
  programs = {
    # Enable Java
    java = {
      enable = true;
      package = pkgs.jdk;
    };
    # Enable direnv
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };

  # Set development environment variables
  environment.sessionVariables = {
    RUST_BACKTRACE = "1";
    CARGO_HOME = "$HOME/.cargo";
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
    JAVA_HOME = "${pkgs.jdk}";
    CC = "${pkgs.gcc}/bin/gcc";
    CXX = "${pkgs.gcc}/bin/g++";
    PKG_CONFIG_PATH = "${pkgs.pkg-config}/lib/pkgconfig";
    NODE_OPTIONS = "--max-old-space-size=4096";
    PYTHONPATH = "$HOME/.local/lib/python3.12/site-packages";
  };
}
