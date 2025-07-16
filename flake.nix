{
  description = "thshafi170's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-staging.url = "github:NixOS/nixpkgs/staging";
    nixpkgs-staging-next.url = "github:NixOS/nixpkgs/staging-next";

    flake-utils.url = "github:numtide/flake-utils";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.2-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien.url = "github:thiagokokada/nix-alien";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:YaLTeR/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walker.url = "github:abenz1267/walker";

    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-master, nixpkgs-staging, nixpkgs-staging-next, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    
    mkPkgs = nixpkgs: import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    
    pkgs = mkPkgs nixpkgs;
    pkgsMaster = mkPkgs nixpkgs-master;
    pkgsStaging = mkPkgs nixpkgs-staging;
    pkgsNxt = mkPkgs nixpkgs-staging-next;

    commonModules = [
      inputs.lix-module.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      inputs.chaotic.nixosModules.default
      inputs.nur.modules.nixos.default
      inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
    ];

    nixpkgsConfig = {
      nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
      nixpkgs.config.allowUnfree = true;
    };

    homeManagerConfig = {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "bak";
        users.thshafi170 = import ./home/default.nix;
      };
    };

  in {
    nixosConfigurations.X1-Yoga-2nd = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit self pkgs pkgsMaster pkgsStaging pkgsNxt; };
      modules = [
        ./hosts/default.nix
        nixpkgsConfig
        homeManagerConfig
      ] ++ commonModules;
    };
  };
}