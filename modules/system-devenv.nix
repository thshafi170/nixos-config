{ config, inputs, lib, pkgs, pkgsMaster, pkgsStaging, pkgsNxt, ... }:

let
  # Rust toolchain with essential components
  rustToolchain = pkgs.rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" "rust-analyzer" "clippy" "rustfmt" ];
  };

  # Python environment with development packages
  pythonEnv = pkgs.python312.withPackages (ps: with ps; [
    # Package management
    pip
    
    # Code formatting and linting
    black flake8 mypy pytest
    
    # Common libraries
    requests numpy pandas
    
    # Language server and plugins
    python-lsp-server pylsp-mypy python-lsp-black
  ]);

  # Development tools and IDEs
  devTools = with pkgs; [
    # IDEs and editors
    vscode-fhs jetbrains.pycharm-community nano neovim
    
    # Build tools and compilers
    gcc clang cmake gnumake gdb
    
    # .NET development
    dotnet-sdk mono
    
    # Version control and utilities
    git curl jq tree ripgrep fd bat fastfetch
    
    # Android development
    android-tools android-udev-rules
    
    # Other development utilities
    direnv fakeroot gh nixd
  ];

  # Language servers and development support
  languageServers = with pkgs; [
    clang-tools omnisharp-roslyn jdt-language-server 
    nixd yaml-language-server
  ];

  # Node.js LTS and package managers
  nodePackages = with pkgs; [
    nodejs_22 pnpm
  ];

  # Additional packages from other channels
  extraPackages = with pkgsNxt; [
    msedit # Microsoft Edit
  ];

in {
  # Java development program
  programs.java = {
    enable = true;
    package = pkgs.jdk;
  };
  
  environment = {
    systemPackages = [ rustToolchain pythonEnv pkgs.jdk ] 
                   ++ devTools 
                   ++ languageServers 
                   ++ nodePackages 
                   ++ extraPackages;

    variables = {
      # Rust environment
      RUST_BACKTRACE = "1";
      RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";
      
      # .NET environment
      DOTNET_CLI_TELEMETRY_OPTOUT = "1";
      
      # C/C++ toolchain
      CC = "${pkgs.gcc}/bin/gcc";
      CXX = "${pkgs.gcc}/bin/g++";
      
      # Java environment
      JAVA_HOME = "${pkgs.jdk}/lib/openjdk";
    };
  };

  nixpkgs.config.allowUnfree = true;
}